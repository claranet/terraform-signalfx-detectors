output "heartbeat" {
  description = "Detector resource for heartbeat"
  value       = signalfx_detector.heartbeat
}

output "ntp" {
  description = "Detector resource for ntp"
  value       = signalfx_detector.ntp
}

