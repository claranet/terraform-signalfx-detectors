output "blocked_over_connected_clients_ratio" {
  description = "Detector resource for blocked_over_connected_clients_ratio"
  value       = signalfx_detector.blocked_over_connected_clients_ratio
}

output "heartbeat" {
  description = "Detector resource for heartbeat"
  value       = signalfx_detector.heartbeat
}

output "memory_usage_ratio" {
  description = "Detector resource for memory_usage_ratio"
  value       = signalfx_detector.memory_usage_ratio
}

output "system_memory_usage_ratio" {
  description = "Detector resource for system_memory_usage_ratio"
  value       = signalfx_detector.system_memory_usage_ratio
}

