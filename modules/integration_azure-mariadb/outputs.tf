output "cpu" {
  description = "Detector resource for cpu"
  value       = signalfx_detector.cpu
}

output "heartbeat" {
  description = "Detector resource for heartbeat"
  value       = signalfx_detector.heartbeat
}

output "io" {
  description = "Detector resource for io"
  value       = signalfx_detector.io
}

output "memory" {
  description = "Detector resource for memory"
  value       = signalfx_detector.memory
}

output "replication_lag" {
  description = "Detector resource for replication_lag"
  value       = signalfx_detector.replication_lag
}

output "storage" {
  description = "Detector resource for storage"
  value       = signalfx_detector.storage
}

