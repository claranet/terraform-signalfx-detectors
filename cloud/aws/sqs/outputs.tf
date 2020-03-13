output "heartbeat_id" {
  description = "id for detector heartbeat"
  value       = signalfx_detector.heartbeat.*.id
}

output "visible_messages_id" {
  description = "id for detector visible_messages"
  value       = signalfx_detector.visible_messages.*.id
}

output "age_of_oldest_message_id" {
  description = "id for detector age_of_oldest_message"
  value       = signalfx_detector.age_of_oldest_message.*.id
}
