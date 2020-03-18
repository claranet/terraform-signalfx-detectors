output "heartbeat_id" {
  description = "id for detector heartbeat"
  value       = signalfx_detector.heartbeat.*.id
}

output "http_5xx_errors_rate_id" {
  description = "id for detector http_5xx_errors_rate"
  value       = signalfx_detector.http_5xx_errors_rate.*.id
}

output "high_connections_count_id" {
  description = "id for detector high_connections_count"
  value       = signalfx_detector.high_connections_count.*.id
}

output "high_threads_count_id" {
  description = "id for detector high_threads_count"
  value       = signalfx_detector.high_threads_count.*.id
}
