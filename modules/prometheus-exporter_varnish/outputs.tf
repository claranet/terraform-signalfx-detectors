output "backend_failed" {
  description = "Detector resource for backend_failed"
  value       = signalfx_detector.backend_failed
}

output "dropped_sessions" {
  description = "Detector resource for dropped_sessions"
  value       = signalfx_detector.dropped_sessions
}

output "heartbeat" {
  description = "Detector resource for heartbeat"
  value       = signalfx_detector.heartbeat
}

output "hit_rate" {
  description = "Detector resource for hit_rate"
  value       = signalfx_detector.hit_rate
}

output "memory_usage" {
  description = "Detector resource for memory_usage"
  value       = signalfx_detector.memory_usage
}

output "thread_number" {
  description = "Detector resource for thread_number"
  value       = signalfx_detector.thread_number
}

