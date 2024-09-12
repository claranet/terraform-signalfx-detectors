output "container_count" {
  description = "Detector resource for container_count"
  value       = signalfx_detector.container_count
}

output "cpu_utilizations" {
  description = "Detector resource for cpu_utilizations"
  value       = signalfx_detector.cpu_utilizations
}

output "memory_utilizations" {
  description = "Detector resource for memory_utilizations"
  value       = signalfx_detector.memory_utilizations
}

