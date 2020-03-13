output "heartbeat_id" {
  description = "id for detector heartbeat"
  value       = signalfx_detector.heartbeat.*.id
}

output "cpu_utilization_id" {
  description = "id for detector cpu_utilization"
  value       = signalfx_detector.cpu_utilization.*.id
}

output "memory_utilization_id" {
  description = "id for detector memory_utilization"
  value       = signalfx_detector.memory_utilization.*.id
}
