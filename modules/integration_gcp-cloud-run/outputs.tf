output "cpu_utilizations" {
  description = "Detector resource for cpu_utilizations"
  value       = signalfx_detector.cpu_utilizations
}

output "heartbeat" {
  description = "Detector resource for heartbeat"
  value       = signalfx_detector.heartbeat
}

output "memory_utilizations" {
  description = "Detector resource for memory_utilizations"
  value       = signalfx_detector.memory_utilizations
}

