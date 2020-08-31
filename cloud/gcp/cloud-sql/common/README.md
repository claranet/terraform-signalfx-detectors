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

It is recommended to descrease these thresholds for instances where this option is disabled (or unavailable for first generation).

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
