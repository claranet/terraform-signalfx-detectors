output "conflicts" {
  description = "Detector resource for conflicts"
  value       = signalfx_detector.conflicts
}

output "deadlocks" {
  description = "Detector resource for deadlocks"
  value       = signalfx_detector.deadlocks
}

output "heartbeat" {
  description = "Detector resource for heartbeat"
  value       = signalfx_detector.heartbeat
}

output "hit_ratio" {
  description = "Detector resource for hit_ratio"
  value       = signalfx_detector.hit_ratio
}

output "max_connections" {
  description = "Detector resource for max_connections"
  value       = signalfx_detector.max_connections
}

output "replication_lag" {
  description = "Detector resource for replication_lag"
  value       = signalfx_detector.replication_lag
}

output "replication_state" {
  description = "Detector resource for replication_state"
  value       = signalfx_detector.replication_state
}

output "rollbacks" {
  description = "Detector resource for rollbacks"
  value       = signalfx_detector.rollbacks
}

