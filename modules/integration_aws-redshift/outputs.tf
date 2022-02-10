output "cpu_usage" {
  description = "Detector resource for cpu_usage"
  value       = signalfx_detector.cpu_usage
}

output "heartbeat" {
  description = "Detector resource for heartbeat"
  value       = signalfx_detector.heartbeat
}

output "storage_usage" {
  description = "Detector resource for storage_usage"
  value       = signalfx_detector.storage_usage
}

