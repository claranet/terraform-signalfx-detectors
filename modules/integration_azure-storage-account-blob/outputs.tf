output "latency_e2e" {
  description = "Detector resource for latency_e2e"
  value       = signalfx_detector.latency_e2e
}

output "requests_error_rate" {
  description = "Detector resource for requests_error_rate"
  value       = signalfx_detector.requests_error_rate
}

