output "heartbeat_id" {
  description = "id for detector heartbeat"
  value       = signalfx_detector.heartbeat.*.id
}

output "memory_used_id" {
  description = "id for detector memory_used"
  value       = signalfx_detector.memory_used.*.id
}
