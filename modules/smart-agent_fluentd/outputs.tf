output "heartbeat" {
  description = "Detector resource for heartbeat"
  value       = signalfx_detector.heartbeat
}

output "buffer" {
  description = "Detector resource for buffer length"
  value       = signalfx_detector.buffer
}
