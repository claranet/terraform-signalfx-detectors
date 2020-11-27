output "cluster_status" {
  description = "Detector resource for cluster_status"
  value       = signalfx_detector.cluster_status
}

output "cpu_90_15min" {
  description = "Detector resource for cpu_90_15min"
  value       = signalfx_detector.cpu_90_15min
}

output "free_space" {
  description = "Detector resource for free_space"
  value       = signalfx_detector.free_space
}

output "heartbeat" {
  description = "Detector resource for heartbeat"
  value       = signalfx_detector.heartbeat
}

