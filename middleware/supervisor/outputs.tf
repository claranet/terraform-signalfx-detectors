output "heartbeat" {
  description = "Detector resource for heartbeat"
  value       = signalfx_detector.heartbeat
}

output "process_state" {
  description = "Detector resource for process_state"
  value       = signalfx_detector.process_state
}

