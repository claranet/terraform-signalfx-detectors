output "oldest_unacked_message_id" {
  description = "id for detector oldest_unacked_message"
  value       = signalfx_detector.oldest_unacked_message.*.id
}

output "push_latency_id" {
  description = "id for detector push_latency"
  value       = signalfx_detector.push_latency.*.id
}

