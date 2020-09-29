output "evictions" {
  description = "Detector resource for evictions"
  value       = signalfx_detector.evictions
}

output "evictions_growing" {
  description = "Detector resource for evictions_growing"
  value       = signalfx_detector.evictions_growing
}

output "free_memory" {
  description = "Detector resource for free_memory"
  value       = signalfx_detector.free_memory
}

output "heartbeat" {
  description = "Detector resource for heartbeat"
  value       = signalfx_detector.heartbeat
}

output "max_connection" {
  description = "Detector resource for max_connection"
  value       = signalfx_detector.max_connection
}

output "no_connection" {
  description = "Detector resource for no_connection"
  value       = signalfx_detector.no_connection
}

output "swap" {
  description = "Detector resource for swap"
  value       = signalfx_detector.swap
}

