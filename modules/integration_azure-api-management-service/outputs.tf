output "capacity" {
  description = "Detector resource for capacity"
  value       = signalfx_detector.capacity
}

output "duration_of_backend_request" {
  description = "Detector resource for duration_of_backend_request"
  value       = signalfx_detector.duration_of_backend_request
}

output "duration_of_gateway_request" {
  description = "Detector resource for duration_of_gateway_request"
  value       = signalfx_detector.duration_of_gateway_request
}

output "heartbeat" {
  description = "Detector resource for heartbeat"
  value       = signalfx_detector.heartbeat
}

