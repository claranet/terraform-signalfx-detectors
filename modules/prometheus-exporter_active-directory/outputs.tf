output "active_directory_services" {
  description = "Detector resource for active_directory_services"
  value       = signalfx_detector.active_directory_services
}

output "heartbeat" {
  description = "Detector resource for heartbeat"
  value       = signalfx_detector.heartbeat
}

output "replication_errors" {
  description = "Detector resource for replication_errors"
  value       = signalfx_detector.replication_errors
}

