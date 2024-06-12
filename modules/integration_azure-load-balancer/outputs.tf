output "backend_unhealthy_host_ratio" {
  description = "Detector resource for backend_unhealthy_host_ratio"
  value       = signalfx_detector.backend_unhealthy_host_ratio
}

output "heartbeat" {
  description = "Detector resource for heartbeat"
  value       = signalfx_detector.heartbeat
}

