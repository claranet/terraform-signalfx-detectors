output "heartbeat_id" {
  description = "id for detector heartbeat"
  value       = signalfx_detector.heartbeat.*.id
}

output "aurora_mysql_replica_lag_id" {
  description = "id for detector aurora_mysql_replica_lag"
  value       = signalfx_detector.aurora_mysql_replica_lag.*.id
}
