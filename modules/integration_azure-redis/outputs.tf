output "evicted_keys" {
  description = "Detector resource for evicted_keys"
  value       = signalfx_detector.evicted_keys
}

output "heartbeat" {
  description = "Detector resource for heartbeat"
  value       = signalfx_detector.heartbeat
}

output "load" {
  description = "Detector resource for load"
  value       = signalfx_detector.load
}

output "processor_time" {
  description = "Detector resource for processor_time"
  value       = signalfx_detector.processor_time
}

