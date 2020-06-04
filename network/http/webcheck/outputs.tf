output "heartbeat_id" {
  description = "id for detector heartbeat"
  value       = signalfx_detector.heartbeat.*.id
}

output "http_code_matched_id" {
  description = "id for detector http_code_matched"
  value       = signalfx_detector.http_code_matched.*.id
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

output "certificate_expiration_date_id" {
  description = "id for detector certificate_expiration_date"
  value       = signalfx_detector.certificate_expiration_date.*.id
}

output "invalid_tls_certificate_id" {
  description = "id for detector invalid_tls_certificate"
  value       = signalfx_detector.invalid_tls_certificate.*.id
}
