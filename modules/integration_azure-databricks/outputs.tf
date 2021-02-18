output "spark_jvm_heap_usage" {
  description = "Detector resource for spark_jvm_heap_usage"
  value       = signalfx_detector.spark_jvm_heap_usage
}

output "spark_jvm_old_gen_usage" {
  description = "Detector resource for spark_jvm_old_gen_usage"
  value       = signalfx_detector.spark_jvm_old_gen_usage
}

