output "connection_refused_to_sql_ratio" {
  description = "Detector resource for connection_refused_to_sql_ratio"
  value       = signalfx_detector.connection_refused_to_sql_ratio
}

output "cpu_usage" {
  description = "Detector resource for cpu_usage"
  value       = signalfx_detector.cpu_usage
}

output "error_rate_5xx" {
  description = "Detector resource for error_rate_5xx"
  value       = signalfx_detector.error_rate_5xx
}

output "memory_usage" {
  description = "Detector resource for memory_usage"
  value       = signalfx_detector.memory_usage
}

