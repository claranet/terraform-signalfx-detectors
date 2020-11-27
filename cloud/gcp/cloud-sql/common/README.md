# COMMON SignalFx detectors

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
:link: **Contents**

- [How to use this module?](#how-to-use-this-module)
- [What are the available detectors in this module?](#what-are-the-available-detectors-in-this-module)
- [How to collect required metrics?](#how-to-collect-required-metrics)
- [Notes](#notes)
  - [Memory](#memory)
  - [Disk](#disk)
- [Related documentation](#related-documentation)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## How to use this module?

This directory defines a [Terraform](https://www.terraform.io/) 
[module](https://www.terraform.io/docs/modules/usage.html) you can use in your
existing [stack](https://github.com/claranet/terraform-signalfx-detectors/wiki/Getting-started#stack) by adding a 
`module` configuration and setting its `source` parameter to URL of this folder:

```hcl
module "signalfx-detectors-cloud-gcp-cloud-sql-common" {
  source = "github.com/claranet/terraform-signalfx-detectors.git//cloud/gcp/cloud-sql/common?ref={revision}"

  environment    = var.environment
  notifications  = local.notifications
  gcp_project_id = "fillme"
}

module "signalfx-detectors-cloud-gcp-cloud-sql-common-failover" {
  source = "github.com/claranet/terraform-signalfx-detectors.git//cloud/gcp/cloud-sql/common/failover?ref={revision}"

  environment    = var.environment
  notifications  = local.notifications
  gcp_project_id = "fillme"
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
  In general, it will also be used in `filter-tags` sub-module to apply a
  [filtering](https://github.com/claranet/terraform-signalfx-detectors/wiki/Guidance#filtering) based on our default 
  [tagging convention](https://github.com/claranet/terraform-signalfx-detectors/wiki/Tagging-convention) by default.

* `notifications`: Use this parameter to define where alerts should be sent depending on their severity. It consists 
  of a Terraform [object](https://www.terraform.io/docs/configuration/types.html#object-) where each key represents an 
  available [detector rule severity](https://docs.signalfx.com/en/latest/detect-alert/set-up-detectors.html#severity) 
  and its value is a list of recipients. Every recipients must respect the [detector notification 
  format](https://registry.terraform.io/providers/splunk-terraform/signalfx/latest/docs/resources/detector#notification-format).
  Check the [notification binding](https://github.com/claranet/terraform-signalfx-detectors/wiki/Notifications-binding) 
  documentation to understand the recommended role of each severity.

There are other Terraform [variables](https://www.terraform.io/docs/configuration/variables.html) in 
[variables.tf](variables.tf) so check their description to customize the detectors behavior to fit your needs. Most of them are 
common [variables](https://github.com/claranet/terraform-signalfx-detectors/wiki/Variables).
The [guidance](https://github.com/claranet/terraform-signalfx-detectors/wiki/Guidance) documentation will help you to use 
common mechanims provided by the modules like [multi 
instances](https://github.com/claranet/terraform-signalfx-detectors/wiki/Guidance#Multiple-instances).

Feel free to explore the [wiki](https://github.com/claranet/terraform-signalfx-detectors/wiki) for more information about 
general usage of this repository.

## What are the available detectors in this module?

This module creates the following SignalFx detectors which could contain one or multiple alerting rules:

* GCP Cloud SQL heartbeat
* GCP Cloud SQL CPU utilization
* GCP Cloud SQL disk utilization
* GCP Cloud SQL disk space is running out
* GCP Cloud SQL memory utilization
* GCP Cloud SQL memory is running out

## How to collect required metrics?

This module uses metrics available from 
the [GCP integration](https://docs.signalfx.com/en/latest/integrations/google-cloud-platform.html) configurable 
with this Terraform [module](https://github.com/claranet/terraform-signalfx-integrations/tree/master/cloud/gcp).




## Notes

### Memory

Memory forecast detector is disabled by default because considered as legacy.

Indeed, it has been created to detect memory leak which has been fixed long time ago and never observed again.

### Disk

Cloud SQL 2nd generation provides the [automatic storage increase](https://cloud.google.com/sql/docs/mysql/instance-settings#automatic-storage-increase-2ndgen) feature.

The default behavior of this module assume this option is enabled while this is true by default:

- Disk forecast detector is disabled by default because useless
- Disk utilization detector is enabled for safety but with high thresholds
    - `86%` is the minimum threshold to expand disk of 50GB capacity
    - `97.5%` is the maximum threshold to expand disk of 1000GB capacity

It is recommended to decrease these thresholds for instances where this option is disabled (or unavailable for first generation).

To achieve that, this is possible to source twice this module with `filter_custom_includes` to filter only relevant databases for each scenario:

```hcl
module "signalfx-detectors-cloud-gcp-cloud-sql-common-manual-storage" {
  source = "github.com/claranet/terraform-signalfx-detectors.git//cloud/gcp/cloud-sql/common"

  environment   = var.environment
  notifications = [var.slack_notification]
  filter_custom_includes = ["project_id:${var.project_id}", "database_id:*first-gen*"]
  disk_utilization_threshold_critical = 90
  disk_utilization_threshold_warning = 80
}

module "signalfx-detectors-cloud-gcp-cloud-sql-common-auto-storage" {
  source = "github.com/claranet/terraform-signalfx-detectors.git//cloud/gcp/cloud-sql/common"

  environment   = var.environment
  notifications = [var.slack_notification]
  filter_custom_includes = ["project_id:${var.project_id}"]
  filter_custom_excludes = ["database_id:*first-gen*"]
}

```


## Related documentation

* [Terraform SignalFx provider](https://registry.terraform.io/providers/splunk-terraform/signalfx/latest/docs)
* [Terraform SignalFx detector](https://registry.terraform.io/providers/splunk-terraform/signalfx/latest/docs/resources/detector)
* [Stackdriver metrics](https://cloud.google.com/monitoring/api/metrics_gcp#gcp-cloudsql)
