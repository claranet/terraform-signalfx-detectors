output "apdex" {
  description = "Detector resource for apdex"
  value       = signalfx_detector.apdex
}

output "error_rate" {
  description = "Detector resource for error_rate"
  value       = signalfx_detector.error_rate
}

output "heartbeat" {
  description = "Detector resource for heartbeat"
  value       = signalfx_detector.heartbeat
}

