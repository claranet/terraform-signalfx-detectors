output "heartbeat_id" {
  description = "id for detector heartbeat"
  value       = signalfx_detector.heartbeat.*.id
}

output "http_code_matched_id" {
  description = "id for detector http_code_matched"
  value       = signalfx_detector.http_code_matched.*.id
}

output "http_status_code_id" {
  description = "id for detector http_status_code"
  value       = signalfx_detector.http_status_code.*.id
}

output "http_regex_matched_id" {
  description = "id for detector http_regex_matched"
  value       = signalfx_detector.http_regex_matched.*.id
}

output "http_response_time_id" {
  description = "id for detector http_response_time"
  value       = signalfx_detector.http_response_time.*.id
}

output "http_content_length_id" {
  description = "id for detector http_content_length"
  value       = signalfx_detector.http_content_length.*.id
}
