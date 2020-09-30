output "conversion_errors" {
  description = "Detector resource for conversion_errors"
  value       = signalfx_detector.conversion_errors
}

output "failed_function_requests" {
  description = "Detector resource for failed_function_requests"
  value       = signalfx_detector.failed_function_requests
}

output "heartbeat" {
  description = "Detector resource for heartbeat"
  value       = signalfx_detector.heartbeat
}

output "runtime_errors" {
  description = "Detector resource for runtime_errors"
  value       = signalfx_detector.runtime_errors
}

output "su_utilization" {
  description = "Detector resource for su_utilization"
  value       = signalfx_detector.su_utilization
}

