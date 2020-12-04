output "average_processing_time" {
  description = "Detector resource for average_processing_time"
  value       = signalfx_detector.average_processing_time
}

output "busy_threads_percentage" {
  description = "Detector resource for busy_threads_percentage"
  value       = signalfx_detector.busy_threads_percentage
}

output "heartbeat" {
  description = "Detector resource for heartbeat"
  value       = signalfx_detector.heartbeat
}

