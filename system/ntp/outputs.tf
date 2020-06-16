output "ntp_id" {
  description = "id for detector ntp"
  value       = signalfx_detector.ntp.*.id
}
