output "heartbeat" {
  description = "Detector resource for heartbeat"
  value       = signalfx_detector.heartbeat
}

output "wsrep_flow_control_paused" {
  description = "Detector resource for wsrep_flow_control_paused"
  value       = signalfx_detector.wsrep_flow_control_paused
}

output "wsrep_local_recv_queue_avg" {
  description = "Detector resource for wsrep_local_recv_queue_avg"
  value       = signalfx_detector.wsrep_local_recv_queue_avg
}

output "wsrep_local_state" {
  description = "Detector resource for wsrep_local_state"
  value       = signalfx_detector.wsrep_local_state
}

output "wsrep_ready" {
  description = "Detector resource for wsrep_ready"
  value       = signalfx_detector.wsrep_ready
}

