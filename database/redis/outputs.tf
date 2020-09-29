output "blocked_clients" {
  description = "Detector resource for blocked_clients"
  value       = signalfx_detector.blocked_clients
}

output "evicted_keys" {
  description = "Detector resource for evicted_keys"
  value       = signalfx_detector.evicted_keys
}

output "expirations" {
  description = "Detector resource for expirations"
  value       = signalfx_detector.expirations
}

output "heartbeat" {
  description = "Detector resource for heartbeat"
  value       = signalfx_detector.heartbeat
}

output "hitrate" {
  description = "Detector resource for hitrate"
  value       = signalfx_detector.hitrate
}

output "keyspace_full" {
  description = "Detector resource for keyspace_full"
  value       = signalfx_detector.keyspace_full
}

output "memory_frag_high" {
  description = "Detector resource for memory_frag_high"
  value       = signalfx_detector.memory_frag_high
}

output "memory_frag_low" {
  description = "Detector resource for memory_frag_low"
  value       = signalfx_detector.memory_frag_low
}

output "memory_used_max" {
  description = "Detector resource for memory_used_max"
  value       = signalfx_detector.memory_used_max
}

output "memory_used_total" {
  description = "Detector resource for memory_used_total"
  value       = signalfx_detector.memory_used_total
}

output "rejected_connections" {
  description = "Detector resource for rejected_connections"
  value       = signalfx_detector.rejected_connections
}

