output "cpu_90_15min_id" {
  description = "id for detector cpu_90_15min"
  value       = signalfx_detector.cpu_90_15min.*.id
}

output "free_space_low_id" {
  description = "id for detector free_space_low"
  value       = signalfx_detector.free_space_low.*.id
}

output "replica_lag_id" {
  description = "id for detector replica_lag"
  value       = signalfx_detector.replica_lag.*.id
}
