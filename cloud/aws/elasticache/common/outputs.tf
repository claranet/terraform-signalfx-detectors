output "heartbeat_id" {
  description = "id for detector heartbeat"
  value       = signalfx_detector.heartbeat.*.id
}

output "evictions_id" {
  description = "id for detector evictions"
  value       = signalfx_detector.evictions.*.id
}

output "max_connection_id" {
  description = "id for detector max_connection"
  value       = signalfx_detector.max_connection.*.id
}

output "no_connection_id" {
  description = "id for detector no_connection"
  value       = signalfx_detector.no_connection.*.id
}

output "swap_id" {
  description = "id for detector swap"
  value       = signalfx_detector.swap.*.id
}

output "free_memory_id" {
  description = "id for detector free_memory"
  value       = signalfx_detector.free_memory.*.id
}

output "evictions_growing_id" {
  description = "id for detector evictions_growing"
  value       = signalfx_detector.evictions_growing.*.id
}
