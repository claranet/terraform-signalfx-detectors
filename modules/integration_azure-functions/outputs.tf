output "heartbeat" {
  description = "Detector resource for heartbeat"
  value       = signalfx_detector.heartbeat
}

output "high_connections_count" {
  description = "Detector resource for high_connections_count"
  value       = signalfx_detector.high_connections_count
}

output "high_threads_count" {
  description = "Detector resource for high_threads_count"
  value       = signalfx_detector.high_threads_count
}

output "http_5xx_errors_rate" {
  description = "Detector resource for http_5xx_errors_rate"
  value       = signalfx_detector.http_5xx_errors_rate
}

