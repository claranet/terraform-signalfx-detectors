output "heartbeat" {
  description = "Detector resource for heartbeat"
  value       = signalfx_detector.heartbeat
}

output "restarts" {
  description = "Detector resource for restarts"
  value       = signalfx_detector.restarts
}

