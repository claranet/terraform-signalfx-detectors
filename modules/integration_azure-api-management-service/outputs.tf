output "backend_requests_duration" {
  description = "Detector resource for backend_requests_duration"
  value       = signalfx_detector.backend_requests_duration
}

output "capacity" {
  description = "Detector resource for capacity"
  value       = signalfx_detector.capacity
}

output "gateway_requests_duration" {
  description = "Detector resource for gateway_requests_duration"
  value       = signalfx_detector.gateway_requests_duration
}

output "heartbeat" {
  description = "Detector resource for heartbeat"
  value       = signalfx_detector.heartbeat
}

