output "heartbeat" {
  description = "Detector resource for heartbeat"
  value       = signalfx_detector.heartbeat
}

output "mysql_connections" {
  description = "Detector resource for mysql_connections"
  value       = signalfx_detector.mysql_connections
}

output "mysql_pool_efficiency" {
  description = "Detector resource for mysql_pool_efficiency"
  value       = signalfx_detector.mysql_pool_efficiency
}

output "mysql_pool_utilization" {
  description = "Detector resource for mysql_pool_utilization"
  value       = signalfx_detector.mysql_pool_utilization
}

output "mysql_questions_anomaly" {
  description = "Detector resource for mysql_questions_anomaly"
  value       = signalfx_detector.mysql_questions_anomaly
}

output "mysql_replication_lag" {
  description = "Detector resource for mysql_replication_lag"
  value       = signalfx_detector.mysql_replication_lag
}

output "mysql_slave_io_status" {
  description = "Detector resource for mysql_slave_io_status"
  value       = signalfx_detector.mysql_slave_io_status
}

output "mysql_slave_sql_status" {
  description = "Detector resource for mysql_slave_sql_status"
  value       = signalfx_detector.mysql_slave_sql_status
}

output "mysql_slow" {
  description = "Detector resource for mysql_slow"
  value       = signalfx_detector.mysql_slow
}

output "mysql_threads_anomaly" {
  description = "Detector resource for mysql_threads_anomaly"
  value       = signalfx_detector.mysql_threads_anomaly
}

