output "heartbeat" {
  description = "Detector resource for heartbeat"
  value       = signalfx_detector.heartbeat
}

output "http_4xx_errors_count" {
  description = "Detector resource for http_4xx_errors_count"
  value       = signalfx_detector.http_4xx_errors_count
}

output "http_5xx_errors_count" {
  description = "Detector resource for http_5xx_errors_count"
  value       = signalfx_detector.http_5xx_errors_count
}

output "http_success_status_rate" {
  description = "Detector resource for http_success_status_rate"
  value       = signalfx_detector.http_success_status_rate
}

output "memory_usage_count" {
  description = "Detector resource for memory_usage_count"
  value       = signalfx_detector.memory_usage_count
}

output "response_time" {
  description = "Detector resource for response_time"
  value       = signalfx_detector.response_time
}

