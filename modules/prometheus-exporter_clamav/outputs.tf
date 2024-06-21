output "clamav_queue_length" {
  description = "Detector resource for clamav_queue_length"
  value       = signalfx_detector.clamav_queue_length
}

output "heartbeat" {
  description = "Detector resource for heartbeat"
  value       = signalfx_detector.heartbeat
}

