output "current_sessions" {
  description = "Detector resource for current_sessions"
  value       = signalfx_detector.current_sessions
}

output "encryption_status" {
  description = "Detector resource for encryption_status"
  value       = signalfx_detector.encryption_status
}

output "heartbeat" {
  description = "Detector resource for heartbeat"
  value       = signalfx_detector.heartbeat
}

output "status" {
  description = "Detector resource for status"
  value       = signalfx_detector.status
}

