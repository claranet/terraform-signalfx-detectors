output "gc_old_gen" {
  description = "Detector resource for gc_old_gen"
  value       = signalfx_detector.gc_old_gen
}

output "heartbeat" {
  description = "Detector resource for heartbeat"
  value       = signalfx_detector.heartbeat
}

output "memory_heap" {
  description = "Detector resource for memory_heap"
  value       = signalfx_detector.memory_heap
}

