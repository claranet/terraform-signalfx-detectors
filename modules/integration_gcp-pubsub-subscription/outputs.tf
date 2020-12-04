output "heartbeat" {
  description = "Detector resource for heartbeat"
  value       = signalfx_detector.heartbeat
}

output "oldest_unacked_message" {
  description = "Detector resource for oldest_unacked_message"
  value       = signalfx_detector.oldest_unacked_message
}

output "push_latency" {
  description = "Detector resource for push_latency"
  value       = signalfx_detector.push_latency
}

