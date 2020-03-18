output "heartbeat_id" {
  description = "id for detector heartbeat"
  value       = signalfx_detector.heartbeat.*.id
}

output "cpu_percentage_id" {
  description = "id for detector cpu_percentage"
  value       = signalfx_detector.cpu_percentage.*.id
}

output "memory_percentage_id" {
  description = "id for detector memory_percentage"
  value       = signalfx_detector.memory_percentage.*.id
}
