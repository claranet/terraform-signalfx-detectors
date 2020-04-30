output "invalid_ssl_certificate_id" {
  description = "id for detector invalid_ssl_certificate"
  value       = signalfx_detector.invalid_ssl_certificate.*.id
}

output "certificate_expiration_date_id" {
  description = "id for detector certificate_expiration_date"
  value       = signalfx_detector.certificate_expiration_date.*.id
}
