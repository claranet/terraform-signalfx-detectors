output "heartbeat_id" {
  description = "id for detector heartbeat"
  value       = signalfx_detector.heartbeat.*.id
}

output "no_successful_message_id" {
  description = "id for detector no_successful_message"
  value       = signalfx_detector.no_successful_message.*.id
}

output "failed_messages_id" {
  description = "id for detector failed_messages"
  value       = signalfx_detector.failed_messages.*.id
}

output "unmatched_events_id" {
  description = "id for detector unmatched_events"
  value       = signalfx_detector.unmatched_events.*.id
}
