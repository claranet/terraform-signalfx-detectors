# ORACLE SignalFx detectors

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## How to use this module?

This directory defines a [Terraform](https://www.terraform.io/) 
[module](https://www.terraform.io/docs/modules/usage.html) you can use in your
existing [stack](https://github.com/claranet/terraform-signalfx-detectors/wiki/Getting-started#stack) by adding a 
`module` configuration and setting its `source` parameter to URL of this folder:

```hcl
module "signalfx-detectors-prometheus-exporter-oracle" {
  source = "github.com/claranet/terraform-signalfx-detectors.git//modules/prometheus-exporter_oracle?ref={revision}"

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
|Oracle listener|X|-|-|-|-|
|Oracle dbisdown|X|-|-|-|-|
|Oracle pdbisdown|X|-|-|-|-|
|Oracle blocking_sessions|X|-|-|-|-|
|Oracle alertlogerror|X|-|-|-|-|
|Oracle fra_usage|X|-|-|X|-|
|Oracle sessions_limits|X|-|-|X|-|
|Oracle process_limits|X|-|-|X|-|
|Oracle stby_replication|X|-|-|-|-|
|Oracle oracledb_export|X|-|-|-|-|
|Oracle oracle_rman_incr|X|-|-|-|-|
|Oracle oracle_rman_arch|X|-|-|-|-|
|Oracle user_expiration|X|-|-|-|-|
|Oracle tablespace_cdb|X|-|-|-|-|
|Oracle tablespace_pdb|X|-|-|-|-|
|Oracle tablespace_single|X|-|-|-|-|
|Oracle dbvagent|X|-|-|-|-|
|Oracle dbvnet|X|-|-|-|-|
|Oracle dbvctl|X|-|-|-|-|

## How to collect required metrics?

This module uses metrics available from 
the scraping of a server following the [OpenMetrics convention](https://openmetrics.io/) based on and compatible with [the Prometheus
exposition format](https://github.com/prometheus/docs/blob/main/content/docs/instrumenting/exposition_formats.md#openmetrics-text-format).
They are generally called "Prometheus Exporter" which can be fetched by both the [SignalFx Smart Agent](https://github.com/signalfx/signalfx-agent)
thanks to its [prometheus exporter monitor](https://docs.signalfx.com/en/latest/integrations/agent/monitors/prometheus-exporter.html) and the
[OpenTelemetry Collector](https://github.com/signalfx/splunk-otel-collector) using its [prometheus
receiver](https://github.com/open-telemetry/opentelemetry-collector-contrib/tree/main/receiver/prometheusreceiver) or its derivates.




### Metrics


Here is the list of required metrics for detectors in this module.

* `dbvagent`
* `dbvctl`
* `dbvnet`
* `oracledb_AlertLogError_count`
* `oracledb_blocking_sessions_count`
* `oracledb_FRA_Usage_value`
* `oracledb_Oracle_exports_value`
* `oracledb_Oracle_RMAN_Arch_value`
* `oracledb_Oracle_RMAN_Incr_value`
* `oracledb_Pdb_is_up_count`
* `oracledb_Process_limits_value`
* `oracledb_Sessions_limits_value`
* `oracledb_STBY_Replication_count`
* `oracledb_tablespace_usage_pct_NOCDB_V2_real_ts_used_pct`
* `oracledb_tablespace_usage_pct_PDB_V2_real_ts_used_pct`
* `oracledb_up`
* `oracledb_User_pass_expiration_V2_count`
* `tnslsnr`




## Related documentation

* [Terraform SignalFx provider](https://registry.terraform.io/providers/splunk-terraform/signalfx/latest/docs)
* [Terraform SignalFx detector](https://registry.terraform.io/providers/splunk-terraform/signalfx/latest/docs/resources/detector)
