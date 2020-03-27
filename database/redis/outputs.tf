output "heartbeat_id" {
  description = "id for detector heartbeat"
  value       = signalfx_detector.heartbeat.*.id
}

output "evicted_keys_id" {
  description = "id for detector evicted_keys"
  value       = signalfx_detector.evicted_keys.*.id
}

output "expirations_id" {
  description = "id for detector expirations"
  value       = signalfx_detector.expirations.*.id
}

output "blocked_clients_id" {
  description = "id for detector blocked_clients"
  value       = signalfx_detector.blocked_clients.*.id
}

output "keyspace_full_id" {
  description = "id for detector keyspace_full"
  value       = signalfx_detector.keyspace_full.*.id
}

output "memory_used_id" {
  description = "id for detector memory_used"
  value       = signalfx_detector.memory_used.*.id
}

output "memory_frag_id" {
  description = "id for detector memory_frag"
  value       = signalfx_detector.memory_frag.*.id
}

output "rejected_connections_id" {
  description = "id for detector rejected_connections"
  value       = signalfx_detector.rejected_connections.*.id
}

output "hitrate_id" {
  description = "id for detector hitrate"
  value       = signalfx_detector.hitrate.*.id
}
