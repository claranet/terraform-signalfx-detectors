output "heartbeat_id" {
  description = "id for detector heartbeat"
  value       = signalfx_detector.heartbeat.*.id
}

output "VPN_status_id" {
  description = "id for detector VPN_status"
  value       = signalfx_detector.VPN_status.*.id
}
