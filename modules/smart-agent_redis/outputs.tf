output "blocked_over_connected_clients_ratio" {
  description = "Detector resource for blocked_over_connected_clients_ratio"
  value       = signalfx_detector.blocked_over_connected_clients_ratio
}

output "evicted_keys_change_rate" {
  description = "Detector resource for evicted_keys_change_rate"
  value       = signalfx_detector.evicted_keys_change_rate
}

output "expired_keys_change_rate" {
  description = "Detector resource for expired_keys_change_rate"
  value       = signalfx_detector.expired_keys_change_rate
}

output "heartbeat" {
  description = "Detector resource for heartbeat"
  value       = signalfx_detector.heartbeat
}

output "high_memory_fragmentation_ratio" {
  description = "Detector resource for high_memory_fragmentation_ratio"
  value       = signalfx_detector.high_memory_fragmentation_ratio
}

output "hitrate" {
  description = "Detector resource for hitrate"
  value       = signalfx_detector.hitrate
}

output "low_memory_fragmentation_ratio" {
  description = "Detector resource for low_memory_fragmentation_ratio"
  value       = signalfx_detector.low_memory_fragmentation_ratio
}

output "rejected_connections" {
  description = "Detector resource for rejected_connections"
  value       = signalfx_detector.rejected_connections
}

output "stored_keys_change_rate" {
  description = "Detector resource for stored_keys_change_rate"
  value       = signalfx_detector.stored_keys_change_rate
}

output "used_over_maximum_memory_ratio" {
  description = "Detector resource for used_over_maximum_memory_ratio"
  value       = signalfx_detector.used_over_maximum_memory_ratio
}

output "used_over_system_memory_ratio" {
  description = "Detector resource for used_over_system_memory_ratio"
  value       = signalfx_detector.used_over_system_memory_ratio
}

