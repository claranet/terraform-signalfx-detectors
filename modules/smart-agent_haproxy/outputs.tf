output "backend_status" {
  description = "Detector resource for backend_status"
  value       = signalfx_detector.backend_status
}

output "heartbeat" {
  description = "Detector resource for heartbeat"
  value       = signalfx_detector.heartbeat
}

output "http_4xx_response" {
  description = "Detector resource for http_4xx_response"
  value       = signalfx_detector.http_4xx_response
}

output "http_5xx_response" {
  description = "Detector resource for http_5xx_response"
  value       = signalfx_detector.http_5xx_response
}

output "server_status" {
  description = "Detector resource for server_status"
  value       = signalfx_detector.server_status
}

output "session_limit" {
  description = "Detector resource for session_limit"
  value       = signalfx_detector.session_limit
}

