# GCP-COMPUTE-ENGINE SignalFx detectors

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
:link: **Contents**

- [How to use this module?](#how-to-use-this-module)
- [What are the available detectors in this module?](#what-are-the-available-detectors-in-this-module)
- [How to collect required metrics?](#how-to-collect-required-metrics)
  - [Metrics](#metrics)
- [Notes](#notes)
  - [Metadata configuration for default filtering](#metadata-configuration-for-default-filtering)
  - [About disk detectors](#about-disk-detectors)
- [Related documentation](#related-documentation)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## How to use this module?

This directory defines a [Terraform](https://www.terraform.io/)
[module](https://www.terraform.io/docs/modules/usage.html) you can use in your
existing [stack](https://github.com/claranet/terraform-signalfx-detectors/wiki/Getting-started#stack) by adding a
`module` configuration and setting its `source` parameter to URL of this folder:

```hcl
module "signalfx-detectors-integration-gcp-compute-engine" {
  source = "github.com/claranet/terraform-signalfx-detectors.git//modules/integration_gcp-compute-engine?ref={revision}"

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
  of a Terraform [object](https://www.terraform.io/docs/configuration/types.html#object-) where each key represents an available
  [detector rule severity](https://docs.splunk.com/observability/alerts-detectors-notifications/create-detectors-for-alerts.html#severity)
  and its value is a list of recipients. Every recipients must respect the [detector notification
  format](https://registry.terraform.io/providers/splunk-terraform/signalfx/latest/docs/resources/detector#notification-format).
  Check the [notification binding](https://github.com/claranet/terraform-signalfx-detectors/wiki/Notifications-binding)
  documentation to understand the recommended role of each severity.

These 3 parameters alongs with all variables defined in [common-variables.tf](common-variables.tf) are common to all
[modules](../) in this repository. Other variables, specific to this module, are available in
[variables.tf](variables.tf).
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
|GCP GCE Instance heartbeat|X|-|-|-|-|
|GCP GCE Instance CPU utilization|X|X|-|-|-|
|GCP GCE Instance disk throttled bps|X|X|-|-|-|
|GCP GCE Instance disk throttled ops|X|X|-|-|-|

## How to collect required metrics?

This module deploys detectors using metrics reported by the
[GCP integration](https://docs.splunk.com/Observability/gdi/get-data-in/connect/gcp.html) configurable
with [this Terraform module](https://github.com/claranet/terraform-signalfx-integrations/tree/master/cloud/gcp).


Check the [Related documentation](#related-documentation) section for more detailed and specific information about this module dependencies.



### Metrics


Here is the list of required metrics for detectors in this module.

* `instance/cpu/usage_time`
* `instance/cpu/utilization`
* `instance/disk/read_bytes_count`
* `instance/disk/read_ops_count`
* `instance/disk/throttled_read_bytes_count`
* `instance/disk/throttled_read_ops_count`
* `instance/disk/throttled_write_bytes_count`
* `instance/disk/throttled_write_ops_count`
* `instance/disk/write_bytes_count`
* `instance/disk/write_ops_count`


## Notes

### Metadata configuration for default filtering

While SignalFx does not support `label` sync from GCE the default filtering policy relies on `metadata` instead.
Therefore, if you keep the default filter (if you don't define `filtering_custom` variable) you **need** to add those metadata to your GCP computes instances :

* sfx_env=true
* sfx_monitored=true

For example:

* via gcloud, at the instance level:
  ```
  gcloud compute instances add-metadata myinstance --zone=europe-west1-c --metadata sfx_env=true
  gcloud compute instances add-metadata myinstance --zone=europe-west1-c --metadata sfx_monitored=true
  ```
* via terraform, [at the instance level](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_instance#metadata)
* via terraform, [at the project level](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/compute_project_metadata)

You also **need** to check if those metadata are in the metadata `includeList` in your [SignalFx GCP
integration](https://dev.splunk.com/observability/docs/integrations/gcp_integration_overview/#Optional-fields).
You can configure this from [Claranet Terraform module for GCP
integration](https://github.com/claranet/terraform-signalfx-integrations/tree/master/cloud/gcp#input_gcp_compute_metadata_whitelist).

### About disk detectors

Detectors "GCP GCE Instance disk .." defines an explicit aggregation function by default in contrast to other detectors. It is because underlying metrics about throttle can
add optional `throttle_reason` dimension which will not exist on not throttle related metrics (used to calculate the percentage). To make them match we have to group on dimensions
__common__ between both metrics.
So, if you want to overwrite `disk_throttled_bps_aggregation_function` or `disk_throttled_ops_notifications` take care to keep the aggregation by 'instance_name' and 'device_name', else you might break the detector.

Notice these detectors has a `device_name` dimension in addition to `instance_name` compared to other detectors because it's possible to have two alertes on the same instance if this instance have two disks.


## Related documentation

* [Terraform SignalFx provider](https://registry.terraform.io/providers/splunk-terraform/signalfx/latest/docs)
* [Terraform SignalFx detector](https://registry.terraform.io/providers/splunk-terraform/signalfx/latest/docs/resources/detector)
* [Splunk Observability integrations](https://docs.splunk.com/Observability/gdi/get-data-in/integrations.html)
* [Stackdriver metrics](https://cloud.google.com/monitoring/api/metrics_gcp#gcp-compute)
* [Splunk Observability metrics](https://docs.splunk.com/Observability/gdi/get-data-in/connect/gcp.html#google-compute-engine-metrics)
