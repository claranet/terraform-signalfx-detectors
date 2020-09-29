output "cpu" {
  description = "Detector resource for cpu"
  value       = signalfx_detector.cpu
}

output "deadlocks_count" {
  description = "Detector resource for deadlocks_count"
  value       = signalfx_detector.deadlocks_count
}

output "dtu_consumption" {
  description = "Detector resource for dtu_consumption"
  value       = signalfx_detector.dtu_consumption
}

output "free_space" {
  description = "Detector resource for free_space"
  value       = signalfx_detector.free_space
}

output "heartbeat" {
  description = "Detector resource for heartbeat"
  value       = signalfx_detector.heartbeat
}

