output "heartbeat_id" {
  description = "id for detector heartbeat"
  value       = signalfx_detector.heartbeat.*.id
}

output "latency_id" {
  description = "id for detector latency"
  value       = signalfx_detector.latency.*.id
}

output "http_5xx_errors_id" {
  description = "id for detector http_5xx_errors"
  value       = signalfx_detector.http_5xx_errors.*.id
}

output "http_4xx_errors_id" {
  description = "id for detector http_4xx_errors"
  value       = signalfx_detector.http_4xx_errors.*.id
}
