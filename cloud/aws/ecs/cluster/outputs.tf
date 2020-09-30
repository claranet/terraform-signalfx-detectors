output "cpu_utilization" {
  description = "Detector resource for cpu_utilization"
  value       = signalfx_detector.cpu_utilization
}

output "heartbeat" {
  description = "Detector resource for heartbeat"
  value       = signalfx_detector.heartbeat
}

output "memory_utilization" {
  description = "Detector resource for memory_utilization"
  value       = signalfx_detector.memory_utilization
}

