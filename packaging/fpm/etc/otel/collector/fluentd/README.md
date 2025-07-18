# [DEPRECATED] Custom TD Agent Fluentd Configuration for the Splunk OpenTelemetry Collector

> **_NOTE:_**  Fluentd support has been deprecated and will be removed in a future release.
> Please refer to [deprecation documentation](../../../../docs/deprecations/fluentd-support.md) for more information.

This directory contains a custom fluentd configuration to forward log events
to the Splunk OpenTelemetry Collector.  By default, the collector will listen
on 127.0.0.1:8006 for log events forwarded from fluentd.  See the
"fluentforward" receiver in the default collector config at
/etc/otel/collector/agent_config.yaml for details or to make any changes
to the collector.

Directory contents:

- splunk-otel-collector.conf: Drop-in file for the fluentd service.  As an
  alternative to overwriting the default fluentd config file
  (/etc/td-agent/td-agent.conf), copy this file to
  /etc/systemd/system/td-agent.service.d/splunk-otel-collector.conf to
  override the default fluentd config path in favor of the custom
  fluentd config file in this directory (see fluent.conf below), and run the
  following commands to apply the changes:

    systemctl daemon-reload
    systemctl restart td-agent

- fluent.conf: The main fluentd configuration file to forward events to the
  collector.  By default, this file will configure fluentd to include custom
  fluentd sources from the conf.d sub-directory (see conf.d below) and forward
  all log events with the @SPLUNK label to the collector.  If changes are made
  to this file, run the following command to apply the changes:

    systemctl restart td-agent

- conf.d: Directory for custom fluentd configuration files.  The main fluentd
  configuration (see fluent.conf above) will automatically include all files
  ending in .conf from the conf.d directory.  New fluentd sources should
  include the @SPLUNK label for all log events intended to be forwarded to the
  collector (see the sample file in conf.d for details).  After adding new
  config files to the conf.d directory, run the following command to apply the
  changes:

    systemctl restart td-agent

  *Important*: By default, the fluentd service runs as the "td-agent" user.
  When adding new fluentd source configurations, ensure that the "td-agent"
  user has permissions to access the paths defined in these sources.

See https://docs.fluentd.org/configuration for general fluentd configuration
details.
