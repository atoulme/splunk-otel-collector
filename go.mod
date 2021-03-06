module github.com/signalfx/splunk-otel-collector

go 1.15

require (
	github.com/client9/misspell v0.3.4
	github.com/golangci/golangci-lint v1.31.0
	github.com/google/addlicense v0.0.0-20200906110928-a0294312aa76
	github.com/jstemmer/go-junit-report v0.9.1
	github.com/open-telemetry/opentelemetry-collector-contrib/exporter/sapmexporter v0.15.0
	github.com/open-telemetry/opentelemetry-collector-contrib/exporter/signalfxcorrelationexporter v0.15.0
	github.com/open-telemetry/opentelemetry-collector-contrib/exporter/signalfxexporter v0.15.0
	github.com/open-telemetry/opentelemetry-collector-contrib/exporter/splunkhecexporter v0.15.0
	github.com/open-telemetry/opentelemetry-collector-contrib/extension/httpforwarder v0.15.0
	github.com/open-telemetry/opentelemetry-collector-contrib/extension/observer/hostobserver v0.15.0
	github.com/open-telemetry/opentelemetry-collector-contrib/extension/observer/k8sobserver v0.15.0
	github.com/open-telemetry/opentelemetry-collector-contrib/processor/k8sprocessor v0.15.0
	github.com/open-telemetry/opentelemetry-collector-contrib/processor/metricstransformprocessor v0.15.0
	github.com/open-telemetry/opentelemetry-collector-contrib/processor/resourcedetectionprocessor v0.15.0
	github.com/open-telemetry/opentelemetry-collector-contrib/receiver/carbonreceiver v0.15.0
	github.com/open-telemetry/opentelemetry-collector-contrib/receiver/collectdreceiver v0.15.0
	github.com/open-telemetry/opentelemetry-collector-contrib/receiver/dockerstatsreceiver v0.15.0
	github.com/open-telemetry/opentelemetry-collector-contrib/receiver/k8sclusterreceiver v0.15.0
	github.com/open-telemetry/opentelemetry-collector-contrib/receiver/kubeletstatsreceiver v0.15.0
	github.com/open-telemetry/opentelemetry-collector-contrib/receiver/prometheusexecreceiver v0.15.0
	github.com/open-telemetry/opentelemetry-collector-contrib/receiver/receivercreator v0.15.0
	github.com/open-telemetry/opentelemetry-collector-contrib/receiver/redisreceiver v0.15.0
	github.com/open-telemetry/opentelemetry-collector-contrib/receiver/sapmreceiver v0.15.0
	github.com/open-telemetry/opentelemetry-collector-contrib/receiver/signalfxreceiver v0.15.0
	github.com/open-telemetry/opentelemetry-collector-contrib/receiver/simpleprometheusreceiver v0.15.0
	github.com/open-telemetry/opentelemetry-collector-contrib/receiver/splunkhecreceiver v0.15.0
	github.com/open-telemetry/opentelemetry-collector-contrib/receiver/statsdreceiver v0.15.0
	github.com/ory/go-acc v0.2.6
	github.com/pavius/impi v0.0.3
	github.com/securego/gosec/v2 v2.5.0
	github.com/signalfx/defaults v1.2.2-0.20180531161417-70562fe60657
	github.com/signalfx/golib/v3 v3.3.16
	github.com/signalfx/signalfx-agent v0.0.0-00010101000000-000000000000
	github.com/spf13/viper v1.7.1
	github.com/stretchr/testify v1.6.1
	go.opentelemetry.io/collector v0.15.0
	go.uber.org/zap v1.16.0
	golang.org/x/sys v0.0.0-20201015000850-e3ed0017c211
	gopkg.in/yaml.v2 v2.3.0
	honnef.co/go/tools v0.0.1-2020.1.6
)

replace (
	github.com/open-telemetry/opentelemetry-collector-contrib/exporter/signalfxexporter v0.0.0-00010101000000-000000000000 => github.com/open-telemetry/opentelemetry-collector-contrib/exporter/signalfxexporter v0.15.0
	github.com/open-telemetry/opentelemetry-collector-contrib/exporter/splunkhecexporter v0.0.0-00010101000000-000000000000 => github.com/open-telemetry/opentelemetry-collector-contrib/exporter/splunkhecexporter v0.15.0
	github.com/open-telemetry/opentelemetry-collector-contrib/extension/observer v0.0.0-00010101000000-000000000000 => github.com/open-telemetry/opentelemetry-collector-contrib/extension/observer v0.15.0
	github.com/open-telemetry/opentelemetry-collector-contrib/internal/common v0.0.0-00010101000000-000000000000 => github.com/open-telemetry/opentelemetry-collector-contrib/internal/common v0.15.0
	github.com/open-telemetry/opentelemetry-collector-contrib/internal/k8sconfig v0.0.0-00010101000000-000000000000 => github.com/open-telemetry/opentelemetry-collector-contrib/internal/k8sconfig v0.15.0
	github.com/open-telemetry/opentelemetry-collector-contrib/internal/splunk v0.0.0-00010101000000-000000000000 => github.com/open-telemetry/opentelemetry-collector-contrib/internal/splunk v0.15.0
	github.com/open-telemetry/opentelemetry-collector-contrib/receiver/k8sclusterreceiver v0.0.0-00010101000000-000000000000 => github.com/open-telemetry/opentelemetry-collector-contrib/receiver/k8sclusterreceiver v0.15.0
	github.com/open-telemetry/opentelemetry-collector-contrib/receiver/redisreceiver v0.0.0-00010101000000-000000000000 => github.com/open-telemetry/opentelemetry-collector-contrib/receiver/redisreceiver v0.15.0
)

// each of these is required for the smartagentreceiver
replace (
	code.cloudfoundry.org/go-loggregator => github.com/signalfx/go-loggregator v1.0.1-0.20200205155641-5ba5ca92118d
	github.com/dancannon/gorethink => gopkg.in/gorethink/gorethink.v4 v4.0.0
	github.com/influxdata/telegraf => github.com/signalfx/telegraf v0.10.2-0.20201211214327-200738592ced
	github.com/prometheus/prometheus => github.com/prometheus/prometheus v1.8.2-0.20201105135750-00f16d1ac3a4
	github.com/signalfx/signalfx-agent => github.com/signalfx/signalfx-agent v1.0.1-0.20210104180832-f3147854c36c
	github.com/signalfx/signalfx-agent/pkg/apm => github.com/signalfx/signalfx-agent/pkg/apm v0.0.0-20210104180832-f3147854c36c
	github.com/soheilhy/cmux => github.com/signalfx/signalfx-agent/thirdparty/cmux v0.0.0-20210104180832-f3147854c36c // required for smartagentreceiver to drop google.golang.org/grpc/examples/helloworld/helloworld test dep
	google.golang.org/grpc => google.golang.org/grpc v1.29.1 // required for smartagentreceiver's go.etcd.io/etcd dep
)
