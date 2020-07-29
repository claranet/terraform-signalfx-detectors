output "heartbeat_id" {
  description = "id for detector heartbeat"
  value       = signalfx_detector.heartbeat.*.id
}

output "total_requests_id" {
  description = "id for detector total_requests"
  value       = signalfx_detector.total_requests.*.id
}

output "backend_connect_time_id" {
  description = "id for detector backend_connect_time"
  value       = signalfx_detector.backend_connect_time.*.id
}

output "failed_requests_id" {
  description = "id for detector failed_requests"
  value       = signalfx_detector.failed_requests.*.id
}

output "unhealthy_host_ratio_id" {
  description = "id for detector unhealthy_host_ratio"
  value       = signalfx_detector.unhealthy_host_ratio.*.id
}

output "http_4xx_errors_id" {
  description = "id for detector http_4xx_errors"
  value       = signalfx_detector.http_4xx_errors.*.id
}

output "http_5xx_errors_id" {
  description = "id for detector http_5xx_errors"
  value       = signalfx_detector.http_5xx_errors.*.id
}

output "backend_http_4xx_errors_id" {
  description = "id for detector backend_http_4xx_errors"
  value       = signalfx_detector.backend_http_4xx_errors.*.id
}

output "backend_http_5xx_errors_id" {
  description = "id for detector backend_http_5xx_errors"
  value       = signalfx_detector.backend_http_5xx_errors.*.id
}
