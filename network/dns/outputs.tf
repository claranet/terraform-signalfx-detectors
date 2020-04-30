output "dns_query_time_id" {
  description = "id for detector dns_query_time"
  value       = signalfx_detector.dns_query_time.*.id
}

output "dns_error_code_id" {
  description = "id for detector dns_error_code"
  value       = signalfx_detector.dns_error_code.*.id
}

output "dns_result_code_id" {
  description = "id for detector dns_result_code"
  value       = signalfx_detector.dns_result_code.*.id
}
