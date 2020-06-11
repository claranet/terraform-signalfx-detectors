output "heartbeat_id" {
  description = "id for detector heartbeat"
  value       = signalfx_detector.heartbeat.*.id
}

output "dns_query_time_id" {
  description = "id for detector dns_query_time"
  value       = signalfx_detector.dns_query_time.*.id
}

output "dns_result_code_id" {
  description = "id for detector dns_result_code"
  value       = signalfx_detector.dns_result_code.*.id
}
