output "heartbeat" {
  description = "Detector resource for heartbeat"
  value       = signalfx_detector.heartbeat
}

output "vpn_status" {
  description = "Detector resource for vpn_status"
  value       = signalfx_detector.vpn_status
}

