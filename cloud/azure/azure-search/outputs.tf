output "search_latency_id" {
  description = "id for detector search_latency"
  value       = signalfx_detector.search_latency.*.id
}

output "search_throttled_queries_rate_id" {
  description = "id for detector search_throttled_queries_rate"
  value       = signalfx_detector.search_throttled_queries_rate.*.id
}
