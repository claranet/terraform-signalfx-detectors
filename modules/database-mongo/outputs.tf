output "asserts" {
  description = "Detector resource for asserts"
  value       = signalfx_detector.asserts
}

output "heartbeat" {
  description = "Detector resource for heartbeat"
  value       = signalfx_detector.heartbeat
}

output "max_connections" {
  description = "Detector resource for max_connections"
  value       = signalfx_detector.max_connections
}

output "page_faults" {
  description = "Detector resource for page_faults"
  value       = signalfx_detector.page_faults
}

output "primary" {
  description = "Detector resource for primary"
  value       = signalfx_detector.primary
}

output "replication_lag" {
  description = "Detector resource for replication_lag"
  value       = signalfx_detector.replication_lag
}

output "secondary" {
  description = "Detector resource for secondary"
  value       = signalfx_detector.secondary
}

