output "backup" {
  description = "Detector resource for backup"
  value       = signalfx_detector.backup
}

output "backup_copy_jobs_failed" {
  description = "Detector resource for backup_copy_jobs_failed"
  value       = signalfx_detector.backup_copy_jobs_failed
}

output "backup_failed" {
  description = "Detector resource for backup_failed"
  value       = signalfx_detector.backup_failed
}

output "backup_job_expired" {
  description = "Detector resource for backup_job_expired"
  value       = signalfx_detector.backup_job_expired
}

output "backup_rp_expired" {
  description = "Detector resource for backup_rp_expired"
  value       = signalfx_detector.backup_rp_expired
}

output "backup_rp_partial" {
  description = "Detector resource for backup_rp_partial"
  value       = signalfx_detector.backup_rp_partial
}

