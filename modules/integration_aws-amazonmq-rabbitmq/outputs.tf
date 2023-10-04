output "disk_free" {
  description = "Detector resource for disk_free"
  value       = signalfx_detector.disk_free
}

output "memory_used" {
  description = "Detector resource for memory_used"
  value       = signalfx_detector.memory_used
}

output "messages_ack_rate" {
  description = "Detector resource for messages_ack_rate"
  value       = signalfx_detector.messages_ack_rate
}

output "messages_ready" {
  description = "Detector resource for messages_ready"
  value       = signalfx_detector.messages_ready
}

output "messages_unacknowledged" {
  description = "Detector resource for messages_unacknowledged"
  value       = signalfx_detector.messages_unacknowledged
}

