output "heartbeat_id" {
  description = "id for detector heartbeat"
  value       = signalfx_detector.heartbeat.*.id
}

output "pct_errors_id" {
  description = "id for detector pct_errors"
  value       = signalfx_detector.pct_errors.*.id
}

output "errors_id" {
  description = "id for detector errors"
  value       = signalfx_detector.errors.*.id
}

output "throttles_id" {
  description = "id for detector throttles"
  value       = signalfx_detector.throttles.*.id
}

output "invocations_id" {
  description = "id for detector invocations"
  value       = signalfx_detector.invocations.*.id
}
