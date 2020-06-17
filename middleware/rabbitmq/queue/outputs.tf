output "messages_ready_ids" {
  description = "id for detector messages_ready_ids"
  value       = signalfx_detector.messages_ready.id
}

output "messages_unacknowledged_ids" {
  description = "id for detector messages_unacknowledged_ids"
  value       = signalfx_detector.messages_unacknowledged.id
}

output "messages_ack_rate_ids" {
  description = "id for detector messages_ack_rate"
  value       = signalfx_detector.messages_ack_rate.id
}

output "consumer_utilisation_ids" {
  description = "id for detector consumer_utilisation"
  value       = signalfx_detector.consumer_utilisation.id
}
