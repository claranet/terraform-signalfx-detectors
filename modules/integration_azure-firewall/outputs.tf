output "health_state" {
  description = "Detector resource for health_state"
  value       = signalfx_detector.health_state
}

output "heartbeat" {
  description = "Detector resource for heartbeat"
  value       = signalfx_detector.heartbeat
}

output "snat_port_utilization" {
  description = "Detector resource for snat_port_utilization"
  value       = signalfx_detector.snat_port_utilization
}

output "throughput" {
  description = "Detector resource for throughput"
  value       = signalfx_detector.throughput
}

