# Common filters at ../../common/module/filters-integration-aws.tf are not used
# with AWS Backup because recovery points (snapshots) and jobs are unlikely to
# be tagged with `env` and `sfx_monitored`.
#
# We are also assuming that we want to be notified for every backup vault and
# resource types. `match_missing=False` is required to avoid duplicated signal
# and alerts, since CloudWatch returns aggregated metric, and per vault and
# resource type.
locals {
  filters = format("filter('namespace', 'AWS/Backup') and filter('stat', 'sum') and filter('BackupVaultName', '*', match_missing=False) and filter('ResourceType', '*', match_missing=False) and filter('aws_account_id', '%s')", var.aws_account_id)
}
