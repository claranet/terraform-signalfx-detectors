output "invocations" {
  description = "Detector resource for invocations"
  value       = signalfx_detector.invocations
}

output "pct_errors" {
  description = "Detector resource for pct_errors"
  value       = signalfx_detector.pct_errors
}

output "throttles" {
  description = "Detector resource for throttles"
  value       = signalfx_detector.throttles
}

