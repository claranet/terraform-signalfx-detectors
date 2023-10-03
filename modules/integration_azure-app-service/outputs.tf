output "heartbeat" {
  description = "Detector resource for heartbeat"
  value       = signalfx_detector.heartbeat
}

output "http_4xx_error_rate" {
  description = "Detector resource for http_4xx_error_rate"
  value       = signalfx_detector.http_4xx_error_rate
}

output "http_5xx_error_rate" {
  description = "Detector resource for http_5xx_error_rate"
  value       = signalfx_detector.http_5xx_error_rate
}

output "http_success_status_rate" {
  description = "Detector resource for http_success_status_rate"
  value       = signalfx_detector.http_success_status_rate
}

output "response_time" {
  description = "Detector resource for response_time"
  value       = signalfx_detector.response_time
}

