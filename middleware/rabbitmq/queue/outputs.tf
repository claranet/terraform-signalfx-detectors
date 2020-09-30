output "consumer_use" {
  description = "Detector resource for consumer_use"
  value       = signalfx_detector.consumer_use
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

