output "heartbeat_id" {
  description = "id for detector heartbeat"
  value       = signalfx_detector.heartbeat.*.id
}

output "searcher_warmup_time_id" {
  description = "id for detector searcher_warmup_time"
  value       = signalfx_detector.searcher_warmup_time.*.id
}
