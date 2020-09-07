output "heartbeat_id" {
  description = "id for detector heartbeat"
  value       = signalfx_detector.heartbeat.*.id
}

output "response_time_id" {
  description = "id for detector response_time"
  value       = signalfx_detector.response_time.*.id
}

output "memory_usage_count_id" {
  description = "id for detector memory_usage_count"
  value       = signalfx_detector.memory_usage_count.*.id
}

output "http_5xx_errors_count_id" {
  description = "id for detector http_5xx_errors_count"
  value       = signalfx_detector.http_5xx_errors_count.*.id
}

output "http_4xx_errors_count_id" {
  description = "id for detector http_4xx_errors_count"
  value       = signalfx_detector.http_4xx_errors_count.*.id
}

output "http_success_status_rate_id" {
  description = "id for detector http_success_status_rate"
  value       = signalfx_detector.http_success_status_rate.*.id
}
