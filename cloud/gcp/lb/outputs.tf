output "backend_latency_bucket" {
  description = "Detector resource for backend_latency_bucket"
  value       = signalfx_detector.backend_latency_bucket
}

output "backend_latency_service" {
  description = "Detector resource for backend_latency_service"
  value       = signalfx_detector.backend_latency_service
}

output "error_rate_4xx" {
  description = "Detector resource for error_rate_4xx"
  value       = signalfx_detector.error_rate_4xx
}

output "error_rate_5xx" {
  description = "Detector resource for error_rate_5xx"
  value       = signalfx_detector.error_rate_5xx
}

output "request_count" {
  description = "Detector resource for request_count"
  value       = signalfx_detector.request_count
}

