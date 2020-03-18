output "heartbeat_id" {
  description = "id for detector heartbeat"
  value       = signalfx_detector.heartbeat.*.id
}

output "api_result_id" {
  description = "id for detector api_result"
  value       = signalfx_detector.api_result.*.id
}

output "api_latency_id" {
  description = "id for detector api_latency"
  value       = signalfx_detector.api_latency.*.id
}
