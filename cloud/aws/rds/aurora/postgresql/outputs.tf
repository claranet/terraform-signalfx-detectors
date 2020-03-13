output "aurora_postgresql_replica_lag_id" {
  description = "id for detector aurora_postgresql_replica_lag"
  value       = signalfx_detector.aurora_postgresql_replica_lag.*.id
}
