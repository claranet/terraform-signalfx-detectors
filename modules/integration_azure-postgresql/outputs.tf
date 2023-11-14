output "active_connections" {
  description = "Detector resource for active_connections"
  value       = signalfx_detector.active_connections
}

output "cpu_usage" {
  description = "Detector resource for cpu_usage"
  value       = signalfx_detector.cpu_usage
}

output "heartbeat" {
  description = "Detector resource for heartbeat"
  value       = signalfx_detector.heartbeat
}

output "io_consumption" {
  description = "Detector resource for io_consumption"
  value       = signalfx_detector.io_consumption
}

output "memory_usage" {
  description = "Detector resource for memory_usage"
  value       = signalfx_detector.memory_usage
}

output "serverlog_storage_usage" {
  description = "Detector resource for serverlog_storage_usage"
  value       = signalfx_detector.serverlog_storage_usage
}

output "storage_usage" {
  description = "Detector resource for storage_usage"
  value       = signalfx_detector.storage_usage
}

