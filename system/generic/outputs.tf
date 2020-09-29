output "cpu" {
  description = "Detector resource for cpu"
  value       = signalfx_detector.cpu
}

output "disk_inodes" {
  description = "Detector resource for disk_inodes"
  value       = signalfx_detector.disk_inodes
}

output "disk_running_out" {
  description = "Detector resource for disk_running_out"
  value       = signalfx_detector.disk_running_out
}

output "disk_space" {
  description = "Detector resource for disk_space"
  value       = signalfx_detector.disk_space
}

output "heartbeat" {
  description = "Detector resource for heartbeat"
  value       = signalfx_detector.heartbeat
}

output "load" {
  description = "Detector resource for load"
  value       = signalfx_detector.load
}

output "memory" {
  description = "Detector resource for memory"
  value       = signalfx_detector.memory
}

