output "heartbeat" {
  description = "Detector resource for heartbeat"
  value       = signalfx_detector.heartbeat
}

output "state_health_status" {
  description = "Detector resource for state_health_status"
  value       = signalfx_detector.state_health_status
}

output "state_oom_killed" {
  description = "Detector resource for state_oom_killed"
  value       = signalfx_detector.state_oom_killed
}

output "state_status" {
  description = "Detector resource for state_status"
  value       = signalfx_detector.state_status
}

