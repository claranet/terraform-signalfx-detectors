output "heartbeat" {
  description = "Detector resource for heartbeat"
  value       = signalfx_detector.heartbeat
}

output "postfix_showq_message_size_bytes_count_deferred" {
  description = "Detector resource for postfix_showq_message_size_bytes_count_deferred"
  value       = signalfx_detector.postfix_showq_message_size_bytes_count_deferred
}

output "postfix_showq_message_size_bytes_count_hold" {
  description = "Detector resource for postfix_showq_message_size_bytes_count_hold"
  value       = signalfx_detector.postfix_showq_message_size_bytes_count_hold
}

output "postfix_showq_message_size_bytes_count_maildrop" {
  description = "Detector resource for postfix_showq_message_size_bytes_count_maildrop"
  value       = signalfx_detector.postfix_showq_message_size_bytes_count_maildrop
}

output "postfix_smtp_delivery_delay_seconds_count" {
  description = "Detector resource for postfix_smtp_delivery_delay_seconds_count"
  value       = signalfx_detector.postfix_smtp_delivery_delay_seconds_count
}

