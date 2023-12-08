output "heartbeat" {
  description = "Detector resource for heartbeat"
  value       = signalfx_detector.heartbeat
}

output "totalflowcount" {
  description = "Detector resource for totalflowcount"
  value       = signalfx_detector.totalflowcount
}

output "tunnel_status" {
  description = "Detector resource for tunnel_status"
  value       = signalfx_detector.tunnel_status
}

