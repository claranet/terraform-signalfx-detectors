output "process_state_id" {
  description = "id for detector process state"
  value       = signalfx_detector.process_state.*.id
}

output "heartbeat_id" {
  description = "id for detector heartbeat"
  value       = signalfx_detector.heartbeat.*.id
}

