output "heartbeat_id" {
  description = "id for detector heartbeat"
  value       = signalfx_detector.heartbeat.*.id
}

output "su_utilization_id" {
  description = "id for detector su_utilization"
  value       = signalfx_detector.su_utilization.*.id
}

output "failed_requests_id" {
  description = "id for detector failed_requests"
  value       = signalfx_detector.failed_requests.*.id
}

output "conversion_errors_id" {
  description = "id for detector conversion_errors"
  value       = signalfx_detector.conversion_errors.*.id
}

output "runtime_errors_id" {
  description = "id for detector runtime_errors"
  value       = signalfx_detector.runtime_errors.*.id
}
