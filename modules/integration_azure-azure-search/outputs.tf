output "search_latency" {
  description = "Detector resource for search_latency"
  value       = signalfx_detector.search_latency
}

output "search_throttled_queries_rate" {
  description = "Detector resource for search_throttled_queries_rate"
  value       = signalfx_detector.search_throttled_queries_rate
}

