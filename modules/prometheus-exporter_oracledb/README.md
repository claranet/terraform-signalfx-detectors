# ORACLEDB SignalFx detectors

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
:link: **Contents**

- [How to use this module?](#how-to-use-this-module)
- [What are the available detectors in this module?](#what-are-the-available-detectors-in-this-module)
- [How to collect required metrics?](#how-to-collect-required-metrics)
  - [Examples](#examples)
  - [Metrics](#metrics)
- [Related documentation](#related-documentation)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## How to use this module?

This directory defines a [Terraform](https://www.terraform.io/) 
[module](https://www.terraform.io/docs/modules/usage.html) you can use in your
existing [stack](https://github.com/claranet/terraform-signalfx-detectors/wiki/Getting-started#stack) by adding a 
`module` configuration and setting its `source` parameter to URL of this folder:

```hcl
module "signalfx-detectors-prometheus-exporter-oracledb" {
  source = "github.com/claranet/terraform-signalfx-detectors.git//modules/prometheus-exporter_oracledb?ref={revision}"

  environment   = var.environment
  notifications = local.notifications
}
```

Note the following parameters:

* `source`: Use this parameter to specify the URL of the module. The double slash (`//`) is intentional  and required. 
  Terraform uses it to specify subfolders within a Git repo (see [module
  sources](https://www.terraform.io/docs/modules/sources.html)). The `ref` parameter specifies a specific Git tag in
  this repository. It is recommended to use the latest "pinned" version in place of `{revision}`. Avoid using a branch 
  like `master` except for testing purpose. Note that every modules in this repository are available on the Terraform 
  [registry](https://registry.terraform.io/modules/claranet/detectors/signalfx) and we recommend using it as source 
  instead of `git` which is more flexible but less future-proof.

* `environment`: Use this parameter to specify the 
  [environment](https://github.com/claranet/terraform-signalfx-detectors/wiki/Getting-started#environment) used by this 
  instance of the module.
  Its value will be added to the `prefixes` list at the start of the [detector 
  name](https://github.com/claranet/terraform-signalfx-detectors/wiki/Templating#example).
  In general, it will also be used in the `filtering` internal sub-module to [apply
  filters](https://github.com/claranet/terraform-signalfx-detectors/wiki/Guidance#filtering) based on our default 
  [tagging convention](https://github.com/claranet/terraform-signalfx-detectors/wiki/Tagging-convention) by default.

* `notifications`: Use this parameter to define where alerts should be sent depending on their severity. It consists 
  of a Terraform [object](https://www.terraform.io/docs/configuration/types.html#object-) where each key represents an 
  available [detector rule severity](https://docs.signalfx.com/en/latest/detect-alert/set-up-detectors.html#severity) 
  and its value is a list of recipients. Every recipients must respect the [detector notification 
  format](https://registry.terraform.io/providers/splunk-terraform/signalfx/latest/docs/resources/detector#notification-format).
  Check the [notification binding](https://github.com/claranet/terraform-signalfx-detectors/wiki/Notifications-binding) 
  documentation to understand the recommended role of each severity.

These 3 parameters alongs with all variables defined in [common-variables.tf](common-variables.tf) are common to all 
[modules](../) in this repository. Other variables, specific to this module, are available in 
[variables-gen.tf](variables-gen.tf).
In general, the default configuration "works" but all of these Terraform 
[variables](https://www.terraform.io/docs/configuration/variables.html) make it possible to 
customize the detectors behavior to better fit your needs.

Most of them represent usual tips and rules detailled in the 
[guidance](https://github.com/claranet/terraform-signalfx-detectors/wiki/Guidance) documentation and listed in the 
common [variables](https://github.com/claranet/terraform-signalfx-detectors/wiki/Variables) dedicated documentation.

Feel free to explore the [wiki](https://github.com/claranet/terraform-signalfx-detectors/wiki) for more information about 
general usage of this repository.

## What are the available detectors in this module?

This module creates the following SignalFx detectors which could contain one or multiple alerting rules:

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|Oracle heartbeat|X|-|-|-|-|
|Oracle database status|X|-|-|-|-|

## How to collect required metrics?

This module uses metrics available from 
the scraping of a server following the [OpenMetrics convention](https://openmetrics.io/) based on and compatible with [the Prometheus
exposition format](https://github.com/prometheus/docs/blob/main/content/docs/instrumenting/exposition_formats.md#openmetrics-text-format).
They are generally called "Prometheus Exporter" which can be fetched by both the [SignalFx Smart Agent](https://github.com/signalfx/signalfx-agent)
thanks to its [prometheus exporter monitor](https://docs.signalfx.com/en/latest/integrations/agent/monitors/prometheus-exporter.html) and the
[OpenTelemetry Collector](https://github.com/signalfx/splunk-otel-collector) using its [prometheus
receiver](https://github.com/open-telemetry/opentelemetry-collector-contrib/tree/main/receiver/prometheusreceiver) or its derivates.


The detectors of this module uses defaults metrics from the [oracledb exporter] (https://github.com/iamseth/oracledb_exporter) and optionnaly custom metrics from custom templates which have to be specified during the deployment.  
Check its documentation to install and configure it appropriately with your Oracle database host.

by default in this module, only the metric oracledb_up is used with the default.metrics related to the [oracledb exporter]. 

### Examples

Here is a sample configuration fragment for the [OpenTelemetry Collector](https://opentelemetry.io/docs/collector/) agent using
the [prometheusexec receiver](https://github.com/open-telemetry/opentelemetry-collector-contrib/tree/main/receiver/prometheusexecreceiver).

In this example we have an oracle instance which is running in Multitenant mode, means that we have one Container Database and one pluggable database. 

important : Both needs a dedicated prometheus port to upload metrics.

{PATH_TO_ORACLEDB_BIN} = directory related to the oracledb_exporter binary which is used,
{PATH_TO_ORACLEDB_TEMPLATE} = directory related to the templates which are used (default & custom)
{ORACLE_HOME}= Oracle Home related to rdbms software
{TNS_PORT} = Oracle listener port on which the DB is listening.
{CONTAINER_DB} = name of the container DB (instance name)
{PLUGGABLE_DB} = name of the pluggable Database
{HOSTNAME} = name of the DB server host

```yaml

receivers:
  prometheus_exec/oracle-exporter-1:
  exec: {PATH_TO_ORACLEDB_BIN}/oracledb_exporter --default.metrics "{PATH_TO_ORACLEDB_TEMPLATE}/default-metrics.toml" --log.level error --web.listen-address :{{port}}
  port: {PROMETHEUS_PORT_1}
  scrape_interval: 300s
  env:
    - name: DATA_SOURCE_NAME
      value: "{USER}/{PASSWORD}@//localhost:{TNS_PORT}/{CONTAINER_DB}"
    - name: LD_LIBRARY_PATH
      value: "{ORACLE_HOME}/lib"
    - name: ORACLE_HOME
      value: "{ORACLE_HOME}"

  prometheus_exec/oracle-exporter-2:
  exec: {PATH_TO_ORACLEDB_BIN}/oracledb_exporter --default.metrics "{PATH_TO_ORACLEDB_TEMPLATE}/default-metrics.toml" --log.level error --web.listen-address :{{port}}
  port: {PROMETHEUS_PORT_2}
  scrape_interval: 300s
  env:
    - name: DATA_SOURCE_NAME
      value: "{USER}/{PASSWORD}@//localhost:{TNS_PORT}/{PLUGGABLE_DB}"
    - name: LD_LIBRARY_PATH
      value: "{ORACLE_HOME}/lib"
    - name: ORACLE_HOME
      value: "{ORACLE_HOME}"

processors:
  resource/add_dimensions-dbname-1:
    attributes:
      - action: upsert
        key: dbname
        value: {CONTAINER_DB}
      - action: upsert
        key: dbtype
        value: container_DB
  resource/add_dimensions-dbname-2:
    attributes:
      - action: upsert
        key: dbname
        value: {PLUGGABLE_DB}
      - action: upsert
        key: dbtype
        value: pluggable_DB

service:
  pipelines:
    metrics/oracle-exporter-1:
      receivers: [prometheus_exec/oracle-exporter-1]
      processors: [resource/add_dimensions-dbname-1,resource/add_global_dimensions]
      exporters: [signalfx]
    metrics/oracle-exporter-2:
      receivers: [prometheus_exec/oracle-exporter-2]
      processors: [resource/add_dimensions-dbname-2,resource/add_global_dimensions]
      exporters: [signalfx]
```


### Metrics


Here is the list of required metrics for detectors in this module.

* `oracledb_up`




## Related documentation

* [Terraform SignalFx provider](https://registry.terraform.io/providers/splunk-terraform/signalfx/latest/docs)
* [Terraform SignalFx detector](https://registry.terraform.io/providers/splunk-terraform/signalfx/latest/docs/resources/detector)
* [Prometheus Exporter for oracledb](https://github.com/iamseth/oracledb_exporter)
