output "heartbeat_id" {
  description = "id for detector heartbeat"
  value       = signalfx_detector.heartbeat.*.id
}

output "active_connections_id" {
  description = "id for detector active_connections"
  value       = signalfx_detector.active_connections.*.id
}

output "user_errors_id" {
  description = "id for detector user_errors"
  value       = signalfx_detector.user_errors.*.id
}

output "server_errors_id" {
  description = "id for detector server_errors"
  value       = signalfx_detector.server_errors.*.id
}
