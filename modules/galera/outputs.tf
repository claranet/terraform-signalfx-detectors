output "heartbeat" {
  description = "Detector resource for heartbeat"
  value       = signalfx_detector.heartbeat
}

output "wsrep_local_state" {
  description = "Detector resource for wsrep_local_state"
  value       = signalfx_detector.wsrep_local_state
}

output "wsrep_ready" {
  description = "Detector resource for wsrep_ready"
  value       = signalfx_detector.wsrep_ready
}

