output "latency" {
  description = "Detector resource for latency"
  value       = signalfx_detector.latency
}

output "throttled_queries_rate" {
  description = "Detector resource for throttled_queries_rate"
  value       = signalfx_detector.throttled_queries_rate
}

