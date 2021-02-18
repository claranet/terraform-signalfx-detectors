output "spark_jvm_heap_old_usage" {
  description = "Detector resource for spark_jvm_heap_old_usage"
  value       = signalfx_detector.spark_jvm_heap_old_usage
}

output "spark_jvm_heap_usage" {
  description = "Detector resource for spark_jvm_heap_usage"
  value       = signalfx_detector.spark_jvm_heap_usage
}

