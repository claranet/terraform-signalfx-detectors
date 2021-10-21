output "heartbeat" {
  description = "Detector resource for heartbeat"
  value       = signalfx_detector.heartbeat
}

output "server_errors" {
  description = "Detector resource for server_errors"
  value       = signalfx_detector.server_errors
}

output "status" {
  description = "Detector resource for status"
  value       = signalfx_detector.status
}

output "total_requests" {
  description = "Detector resource for total_requests"
  value       = signalfx_detector.total_requests
}

