output "cpu_utilization" {
  description = "Detector resource for cpu_utilization"
  value       = signalfx_detector.cpu_utilization
}

output "disk_utilization" {
  description = "Detector resource for disk_utilization"
  value       = signalfx_detector.disk_utilization
}

output "disk_utilization_forecast" {
  description = "Detector resource for disk_utilization_forecast"
  value       = signalfx_detector.disk_utilization_forecast
}

output "heartbeat" {
  description = "Detector resource for heartbeat"
  value       = signalfx_detector.heartbeat
}

output "memory_utilization" {
  description = "Detector resource for memory_utilization"
  value       = signalfx_detector.memory_utilization
}

output "memory_utilization_forecast" {
  description = "Detector resource for memory_utilization_forecast"
  value       = signalfx_detector.memory_utilization_forecast
}

