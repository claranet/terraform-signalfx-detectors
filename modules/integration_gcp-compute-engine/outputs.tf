output "cpu_utilization" {
  description = "Detector resource for cpu_utilization"
  value       = signalfx_detector.cpu_utilization
}

output "disk_throttled_bps" {
  description = "Detector resource for disk_throttled_bps"
  value       = signalfx_detector.disk_throttled_bps
}

output "disk_throttled_ops" {
  description = "Detector resource for disk_throttled_ops"
  value       = signalfx_detector.disk_throttled_ops
}

output "heartbeat" {
  description = "Detector resource for heartbeat"
  value       = signalfx_detector.heartbeat
}

