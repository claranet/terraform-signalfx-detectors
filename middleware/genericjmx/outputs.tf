output "jmx_memory_heap" {
  description = "Detector resource for jmx_memory_heap"
  value       = signalfx_detector.jmx_memory_heap
}

output "jmx_old_gen" {
  description = "Detector resource for jmx_old_gen"
  value       = signalfx_detector.jmx_old_gen
}

