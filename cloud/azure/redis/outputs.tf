output "heartbeat_id" {
  description = "id for detector heartbeat"
  value       = signalfx_detector.heartbeat.*.id
}

output "evictedkeys_id" {
  description = "id for detector evictedkeys"
  value       = signalfx_detector.evictedkeys.*.id
}

output "percent_processor_time_id" {
  description = "id for detector percent_processor_time"
  value       = signalfx_detector.percent_processor_time.*.id
}

output "load_id" {
  description = "id for detector load"
  value       = signalfx_detector.load.*.id
}
