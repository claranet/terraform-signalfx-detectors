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

output "replication_lag" {
  description = "Detector resource for replication_lag"
  value       = signalfx_detector.replication_lag
}

output "storage_usage" {
  description = "Detector resource for storage_usage"
  value       = signalfx_detector.storage_usage
}

