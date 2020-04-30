output "heartbeat_id" {
  description = "id for detector heartbeat"
  value       = signalfx_detector.heartbeat.*.id
}

output "invalid_tls_certificate_id" {
  description = "id for detector invalid_tls_certificate"
  value       = signalfx_detector.invalid_tls_certificate.*.id
}

output "tls_certificate_expiration_id" {
  description = "id for detector tls_certificate_expiration"
  value       = signalfx_detector.tls_certificate_expiration.*.id
}

output "certificate_expiration_date_id" {
  description = "id for detector certificate_expiration_date"
  value       = signalfx_detector.certificate_expiration_date.*.id
}
