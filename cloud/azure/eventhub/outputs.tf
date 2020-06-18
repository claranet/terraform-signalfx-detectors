output "heartbeat_id" {
  description = "id for detector heartbeat"
  value       = signalfx_detector.heartbeat.*.id
}

output "eventhub_failed_requests_id" {
  description = "id for detector eventhub_failed_requests"
  value       = signalfx_detector.eventhub_failed_requests.*.id
}

output "eventhub_errors_id" {
  description = "id for detector eventhub_errors"
  value       = signalfx_detector.eventhub_errors.*.id
}
