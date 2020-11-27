output "backend_connect_time" {
  description = "Detector resource for backend_connect_time"
  value       = signalfx_detector.backend_connect_time
}

output "backend_http_4xx_errors" {
  description = "Detector resource for backend_http_4xx_errors"
  value       = signalfx_detector.backend_http_4xx_errors
}

output "backend_http_5xx_errors" {
  description = "Detector resource for backend_http_5xx_errors"
  value       = signalfx_detector.backend_http_5xx_errors
}

output "failed_requests" {
  description = "Detector resource for failed_requests"
  value       = signalfx_detector.failed_requests
}

output "heartbeat" {
  description = "Detector resource for heartbeat"
  value       = signalfx_detector.heartbeat
}

output "http_4xx_errors" {
  description = "Detector resource for http_4xx_errors"
  value       = signalfx_detector.http_4xx_errors
}

output "http_5xx_errors" {
  description = "Detector resource for http_5xx_errors"
  value       = signalfx_detector.http_5xx_errors
}

output "total_requests" {
  description = "Detector resource for total_requests"
  value       = signalfx_detector.total_requests
}

output "unhealthy_host_ratio" {
  description = "Detector resource for unhealthy_host_ratio"
  value       = signalfx_detector.unhealthy_host_ratio
}

