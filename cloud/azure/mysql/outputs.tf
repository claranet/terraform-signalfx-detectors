output "heartbeat_id" {
  description = "id for detector heartbeat"
  value       = signalfx_detector.heartbeat.*.id
}

output "cpu_usage_id" {
  description = "id for detector cpu_usage"
  value       = signalfx_detector.cpu_usage.*.id
}

output "free_storage_id" {
  description = "id for detector free_storage"
  value       = signalfx_detector.free_storage.*.id
}

output "io_consumption_id" {
  description = "id for detector io_consumption"
  value       = signalfx_detector.io_consumption.*.id
}

output "memory_usage_id" {
  description = "id for detector memory_usage"
  value       = signalfx_detector.memory_usage.*.id
}
