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

output "rejected_connections" {
  description = "Detector resource for rejected_connections"
  value       = signalfx_detector.rejected_connections
}

