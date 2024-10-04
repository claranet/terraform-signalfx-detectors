output "connection_state" {
  description = "Detector resource for connection_state"
  value       = signalfx_detector.connection_state
}

output "connection_traffic" {
  description = "Detector resource for connection_traffic"
  value       = signalfx_detector.connection_traffic
}

output "heartbeat" {
  description = "Detector resource for heartbeat"
  value       = signalfx_detector.heartbeat
}

