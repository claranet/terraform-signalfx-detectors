output "disk_write_queue" {
  description = "Detector resource for disk_write_queue"
  value       = signalfx_detector.disk_write_queue
}

output "heartbeat" {
  description = "Detector resource for heartbeat"
  value       = signalfx_detector.heartbeat
}

output "memory_used" {
  description = "Detector resource for memory_used"
  value       = signalfx_detector.memory_used
}

output "out_of_memory_errors" {
  description = "Detector resource for out_of_memory_errors"
  value       = signalfx_detector.out_of_memory_errors
}

