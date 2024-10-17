output "connection_state" {
  description = "Detector resource for connection_state"
  value       = signalfx_detector.connection_state
}

output "heartbeat" {
  description = "Detector resource for heartbeat"
  value       = signalfx_detector.heartbeat
}

output "virtual_interface_traffic" {
  description = "Detector resource for virtual_interface_traffic"
  value       = signalfx_detector.virtual_interface_traffic
}

