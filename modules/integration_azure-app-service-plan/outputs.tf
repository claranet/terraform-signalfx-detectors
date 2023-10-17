output "cpu" {
  description = "Detector resource for cpu"
  value       = signalfx_detector.cpu
}

output "heartbeat" {
  description = "Detector resource for heartbeat"
  value       = signalfx_detector.heartbeat
}

output "memory" {
  description = "Detector resource for memory"
  value       = signalfx_detector.memory
}

