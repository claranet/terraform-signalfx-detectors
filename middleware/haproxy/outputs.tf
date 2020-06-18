output "server_status_id" {
  description = "id for detector server_status"
  value       = signalfx_detector.server_status.id
}

output "backend_status_id" {
  description = "id for detector backend_status"
  value       = signalfx_detector.backend_status.id
}

output "session_limit_id" {
  description = "id for detector session_limit"
  value       = signalfx_detector.session_limit.id
}

output "http_5xx_response_id" {
  description = "id for detector http_5xx_response"
  value       = signalfx_detector.http_5xx_response.id
}

output "http_4xx_response_id" {
  description = "id for detector http_4xx_response"
  value       = signalfx_detector.http_4xx_response.id
}

output "heartbeat_id" {
  description = "id for detector heartbeat"
  value       = signalfx_detector.heartbeat.id
}
