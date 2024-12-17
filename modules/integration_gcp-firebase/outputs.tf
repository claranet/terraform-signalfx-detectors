output "heartbeat" {
  description = "Detector resource for heartbeat"
  value       = signalfx_detector.heartbeat
}

output "io_utilization" {
  description = "Detector resource for io_utilization"
  value       = signalfx_detector.io_utilization
}

output "load" {
  description = "Detector resource for load"
  value       = signalfx_detector.load
}

