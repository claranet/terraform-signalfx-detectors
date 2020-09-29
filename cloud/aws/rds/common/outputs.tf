output "cpu_90_15min" {
  description = "Detector resource for cpu_90_15min"
  value       = signalfx_detector.cpu_90_15min
}

output "free_space_low" {
  description = "Detector resource for free_space_low"
  value       = signalfx_detector.free_space_low
}

output "heartbeat" {
  description = "Detector resource for heartbeat"
  value       = signalfx_detector.heartbeat
}

output "replica_lag" {
  description = "Detector resource for replica_lag"
  value       = signalfx_detector.replica_lag
}

