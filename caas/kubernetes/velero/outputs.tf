output "velero_scheduled_backup_missing_id" {
  description = "id for detector velero_scheduled_backup_missing"
  value       = signalfx_detector.velero_scheduled_backup_missing.*.id
}

output "velero_backup_failure_id" {
  description = "id for detector velero_backup_failure"
  value       = signalfx_detector.velero_backup_failure.*.id
}

output "velero_backup_partial_failure_id" {
  description = "id for detector velero_backup_partial_failure"
  value       = signalfx_detector.velero_backup_partial_failure.*.id
}

output "velero_backup_deletion_failure_id" {
  description = "id for detector velero_backup_deletion_failure"
  value       = signalfx_detector.velero_backup_deletion_failure.*.id
}

output "velero_volume_snapshot_failure_id" {
  description = "id for detector velero_volume_snapshot_failure"
  value       = signalfx_detector.velero_volume_snapshot_failure.*.id
}
