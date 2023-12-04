output "heartbeat" {
  description = "Detector resource for heartbeat"
  value       = signalfx_detector.heartbeat
}

output "replicas" {
  description = "Detector resource for replicas"
  value       = signalfx_detector.replicas
}

output "restarts" {
  description = "Detector resource for restarts"
  value       = signalfx_detector.restarts
}

