output "heartbeat_id" {
  description = "id for detector heartbeat"
  value       = signalfx_detector.heartbeat.*.id
}

output "incoming_records_id" {
  description = "id for detector incoming_records"
  value       = signalfx_detector.incoming_records.*.id
}
