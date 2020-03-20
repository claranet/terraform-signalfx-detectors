output "heartbeat_id" {
  description = "id for detector heartbeat"
  value       = signalfx_detector.heartbeat.*.id
}

output "health_id" {
  description = "id for detector health"
  value       = signalfx_detector.health.*.id
}

output "latency_p90_id" {
  description = "id for detector latency_p90"
  value       = signalfx_detector.atency_p90.*.id
}

output "5xx_error_rate_id" {
  description = "id for detector 5xx_error_rate"
  value       = signalfx_detector.5xx_error_rate.*.id
}

output "root_filesystem_usage_id" {
  description = "id for detector root_filesystem_usage"
  value       = signalfx_detector.root_filesystem_usage.*.id
}
