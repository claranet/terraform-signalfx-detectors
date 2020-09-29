output "app_5xx_error_rate" {
  description = "Detector resource for app_5xx_error_rate"
  value       = signalfx_detector.app_5xx_error_rate
}

output "health" {
  description = "Detector resource for health"
  value       = signalfx_detector.health
}

output "heartbeat" {
  description = "Detector resource for heartbeat"
  value       = signalfx_detector.heartbeat
}

output "latency_p90" {
  description = "Detector resource for latency_p90"
  value       = signalfx_detector.latency_p90
}

output "root_filesystem_usage" {
  description = "Detector resource for root_filesystem_usage"
  value       = signalfx_detector.root_filesystem_usage
}

