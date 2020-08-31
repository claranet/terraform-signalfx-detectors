output "replication_lag_id" {
  description = "id for detector replication_lag"
  value       = signalfx_detector.replication_lag.*.id
}
