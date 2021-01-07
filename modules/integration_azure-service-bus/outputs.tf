output "active_connections" {
  description = "Detector resource for active_connections"
  value       = signalfx_detector.active_connections
}

output "heartbeat" {
  description = "Detector resource for heartbeat"
  value       = signalfx_detector.heartbeat
}

output "server_errors" {
  description = "Detector resource for server_errors"
  value       = signalfx_detector.server_errors
}

output "throttled_requests" {
  description = "Detector resource for throttled_requests"
  value       = signalfx_detector.throttled_requests
}

output "user_errors" {
  description = "Detector resource for user_errors"
  value       = signalfx_detector.user_errors
}

