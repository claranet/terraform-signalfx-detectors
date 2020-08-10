output "sending_operations_id" {
  description = "id for detector sending_operations"
  value       = signalfx_detector.sending_operations.*.id
}

output "unavailable_sending_operations_id" {
  description = "id for detector unavailable_sending_operations"
  value       = signalfx_detector.unavailable_sending_operations.*.id
}

output "unavailable_sending_operations_ratio_id" {
  description = "id for detector unavailable_sending_operations_ratio"
  value       = signalfx_detector.unavailable_sending_operations_ratio.*.id
}
