output "heartbeat" {
  description = "Detector resource for heartbeat"
  value       = signalfx_detector.heartbeat
}

output "postfix_queue_size" {
  description = "Detector resource for postfix_queue_size"
  value       = signalfx_detector.postfix_queue_size
}

