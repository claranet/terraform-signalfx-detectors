output "heartbeat_id" {
  description = "id for detector heartbeat"
  value       = signalfx_detector.heartbeat.*.id
}

output "latency_id" {
  description = "id for detector latency"
  value       = signalfx_detector.latency.*.id
}

output "httpcode_5xx_errors_id" {
  description = "id for detector httpcode_5xx_errors"
  value       = signalfx_detector.httpcode_5xx_errors.*.id
}

output "httpcode_4xx_errors_id" {
  description = "id for detector httpcode_4xx_errors"
  value       = signalfx_detector.httpcode_4xx_errors.*.id
}
