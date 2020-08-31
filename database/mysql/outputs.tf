output "heartbeat_id" {
  description = "id for detector heartbeat"
  value       = signalfx_detector.heartbeat.*.id
}

output "mysql_slow_id" {
  description = "id for detector mysql_slow"
  value       = signalfx_detector.mysql_slow.*.id
}

output "mysql_threads_anomaly_id" {
  description = "id for detector mysql_threads_anomaly"
  value       = signalfx_detector.mysql_threads_anomaly.*.id
}

output "mysql_questions_anomaly_id" {
  description = "id for detector mysql_questions_anomaly"
  value       = signalfx_detector.mysql_questions_anomaly.*.id
}
