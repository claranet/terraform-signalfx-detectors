output "heartbeat_id" {
  description = "id for detector heartbeat"
  value       = signalfx_detector.heartbeat.*.id
}

output "disk_utilization_id" {
  description = "id for detector disk_utilization"
  value       = signalfx_detector.disk_utilization.*.id
}

output "disk_utilization_forecast_id" {
  description = "id for detector disk_utilization_forecast"
  value       = signalfx_detector.disk_utilization_forecast.*.id
}

output "memory_utilization_id" {
  description = "id for detector memory_utilization"
  value       = signalfx_detector.memory_utilization.*.id
}

output "memory_utilization_forecast_id" {
  description = "id for detector memory_utilization_forecast"
  value       = signalfx_detector.memory_utilization_forecast.*.id
}
