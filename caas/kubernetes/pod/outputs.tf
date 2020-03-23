output "heartbeat_id" {
  description = "id for detector heartbeat"
  value       = signalfx_detector.heartbeat.*.id
}

output "pod_phase_status_id" {
  description = "id for detector pod_phase_status"
  value       = signalfx_detector.pod_phase_status.*.id
}

output "error_id" {
  description = "id for detector error"
  value       = signalfx_detector.error.*.id
}

output "terminated_id" {
  description = "id for detector terminated"
  value       = signalfx_detector.terminated.*.id
}
