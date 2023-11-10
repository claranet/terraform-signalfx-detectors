output "cpu_usage" {
  description = "Detector resource for cpu_usage"
  value       = signalfx_detector.cpu_usage
}

output "dbload" {
  description = "Detector resource for dbload"
  value       = signalfx_detector.dbload
}

output "free_space" {
  description = "Detector resource for free_space"
  value       = signalfx_detector.free_space
}

output "heartbeat" {
  description = "Detector resource for heartbeat"
  value       = signalfx_detector.heartbeat
}

output "replica_lag" {
  description = "Detector resource for replica_lag"
  value       = signalfx_detector.replica_lag
}

