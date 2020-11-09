output "backend_failed" {
  description = "Detector resource for backend_failed"
  value       = signalfx_detector.backend_failed
}

output "cache_hit_rate" {
  description = "Detector resource for cache_hit_rate"
  value       = signalfx_detector.cache_hit_rate
}

output "heartbeat" {
  description = "Detector resource for heartbeat"
  value       = signalfx_detector.heartbeat
}

output "memory_usage" {
  description = "Detector resource for memory_usage"
  value       = signalfx_detector.memory_usage
}

output "session_dropped" {
  description = "Detector resource for session_dropped"
  value       = signalfx_detector.session_dropped
}

output "threads_number" {
  description = "Detector resource for threads_number"
  value       = signalfx_detector.threads_number
}

