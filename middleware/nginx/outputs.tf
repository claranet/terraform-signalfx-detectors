output "heartbeat_id" {
  description = "id for detector heartbeat"
  value       = signalfx_detector.heartbeat.*.id
}

output "dropped_connections_id" {
  description = "id for detector dropped_connections"
  value       = signalfx_detector.dropped_connections.*.id
}

