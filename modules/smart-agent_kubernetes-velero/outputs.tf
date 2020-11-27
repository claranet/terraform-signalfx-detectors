output "velero_backup_deletion_failure" {
  description = "Detector resource for velero_backup_deletion_failure"
  value       = signalfx_detector.velero_backup_deletion_failure
}

output "velero_backup_failure" {
  description = "Detector resource for velero_backup_failure"
  value       = signalfx_detector.velero_backup_failure
}

output "velero_backup_partial_failure" {
  description = "Detector resource for velero_backup_partial_failure"
  value       = signalfx_detector.velero_backup_partial_failure
}

output "velero_scheduled_backup_missing" {
  description = "Detector resource for velero_scheduled_backup_missing"
  value       = signalfx_detector.velero_scheduled_backup_missing
}

output "velero_volume_snapshot_failure" {
  description = "Detector resource for velero_volume_snapshot_failure"
  value       = signalfx_detector.velero_volume_snapshot_failure
}

