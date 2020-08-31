## Notes

Failover will be obviously not available on replica Cloud SQL instances.

Saldy there is no way to automatically filter only Cloud SQL master instances.

While Cloud SQL console automatically append `-replica` suffix to replica instances names,
this module use it by default to exclude them but you can change it if needed:

```
module "signalfx-detectors-cloud-gcp-cloud-sql-common-failover" {
  source = "github.com/claranet/terraform-signalfx-detectors.git//cloud/gcp/cloud-sql/common/failover"

  environment   = var.environment
  notifications = [local.slack_notification]
  filter_custom_includes = ["project_id:${var.project_id}"]
  filter_custom_excludes = ["database_id:*-rr"]
}
```
