output "heartbeat" {
  description = "Detector resource for heartbeat"
  value       = signalfx_detector.heartbeat
}

output "totalflowcount" {
  description = "Detector resource for totalflowcount"
  value       = signalfx_detector.totalflowcount
}

output "tunnelstatus" {
  description = "Detector resource for tunnelstatus"
  value       = signalfx_detector.tunnelstatus
}

