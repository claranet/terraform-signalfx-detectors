output "heartbeat_id" {
  description = "id for detector heartbeat"
  value       = signalfx_detector.heartbeat.*.id
}

output "mongodb_replication_id" {
  description = "id for detector mongodb_replication"
  value       = signalfx_detector.mongodb_replication.*.id
}
