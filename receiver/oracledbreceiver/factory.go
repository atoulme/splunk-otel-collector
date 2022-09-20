// Copyright The OpenTelemetry Authors
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//       http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

package oracledbreceiver // import "github.com/signalfx/splunk-otel-collector/receiver/oracledbreceiver"

import (
	"context"
	"database/sql"
	"fmt"
	"time"

	"go.opentelemetry.io/collector/component"
	"go.opentelemetry.io/collector/config"
	"go.opentelemetry.io/collector/consumer"
	"go.opentelemetry.io/collector/receiver/scraperhelper"
)

const (
	typeStr   = "oracledb"
	stability = component.StabilityLevelInDevelopment
)

// NewFactory creates a new Oracle receiver factory.
func NewFactory() component.ReceiverFactory {
	return component.NewReceiverFactory(
		typeStr,
		createDefaultConfig,
		component.WithMetricsReceiver(createReceiverFunc(sql.Open, NewDbClient), stability))
}

func createDefaultConfig() config.Receiver {
	return &Config{
		ReceiverSettings: config.NewReceiverSettings(config.NewComponentID(typeStr)),
		ScraperControllerSettings: scraperhelper.ScraperControllerSettings{
			ReceiverSettings:   config.NewReceiverSettings(config.NewComponentID(typeStr)),
			CollectionInterval: 10 * time.Second,
		},
	}
}

type sqlOpenerFunc func(driverName, dataSourceName string) (*sql.DB, error)

func createReceiverFunc(sqlOpenerFunc sqlOpenerFunc, clientProviderFunc ClientProviderFunc) component.CreateMetricsReceiverFunc {
	return func(
		ctx context.Context,
		settings component.ReceiverCreateSettings,
		cfg config.Receiver,
		consumer consumer.Metrics,
	) (component.MetricsReceiver, error) {
		sqlCfg := cfg.(*Config)
		var opts []scraperhelper.ScraperControllerOption
		for i, query := range sqlCfg.Queries {
			id := config.NewComponentIDWithName(typeStr, fmt.Sprintf("query-%d: %s", i, query.SQL))
			mp := NewScraper(id, query, sqlCfg.ScraperControllerSettings, settings.TelemetrySettings.Logger, func() (*sql.DB, error) {
				return sqlOpenerFunc(sqlCfg.Driver, sqlCfg.DataSource)
			}, clientProviderFunc)
			opt := scraperhelper.AddScraper(mp)
			opts = append(opts, opt)
		}
		return scraperhelper.NewScraperControllerReceiver(
			&sqlCfg.ScraperControllerSettings,
			settings,
			consumer,
			opts...,
		)
	}
}
