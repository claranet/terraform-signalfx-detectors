output "varnish_backend_failed" {
  description = "Detector resource for varnish_backend_failed"
  value       = signalfx_detector.varnish_backend_failed
}

output "varnish_cache_hit_rate" {
  description = "Detector resource for varnish_cache_hit_rate"
  value       = signalfx_detector.varnish_cache_hit_rate
}

output "varnish_memory_usage" {
  description = "Detector resource for varnish_memory_usage"
  value       = signalfx_detector.varnish_memory_usage
}

output "varnish_session_dropped" {
  description = "Detector resource for varnish_session_dropped"
  value       = signalfx_detector.varnish_session_dropped
}

output "varnish_threads_number" {
  description = "Detector resource for varnish_threads_number"
  value       = signalfx_detector.varnish_threads_number
}

