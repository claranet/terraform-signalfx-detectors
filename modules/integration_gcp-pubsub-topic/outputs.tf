output "sending_operations" {
  description = "Detector resource for sending_operations"
  value       = signalfx_detector.sending_operations
}

output "unavailable_sending_operations" {
  description = "Detector resource for unavailable_sending_operations"
  value       = signalfx_detector.unavailable_sending_operations
}

output "unavailable_sending_operations_ratio" {
  description = "Detector resource for unavailable_sending_operations_ratio"
  value       = signalfx_detector.unavailable_sending_operations_ratio
}

