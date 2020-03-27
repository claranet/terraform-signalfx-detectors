output "heartbeat_id" {
  description = "id for detector heartbeat"
  value       = signalfx_detector.heartbeat.*.id
}

output "too_many_locks_id" {
  description = "id for detector too_many_locks"
  value       = signalfx_detector.too_many_locks.*.id
}
