output "heartbeat" {
  description = "Detector resource for heartbeat"
  value       = signalfx_detector.heartbeat
}

output "no_healthy_instances" {
  description = "Detector resource for no_healthy_instances"
  value       = signalfx_detector.no_healthy_instances
}

