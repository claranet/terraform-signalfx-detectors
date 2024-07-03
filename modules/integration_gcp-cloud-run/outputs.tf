output "connection_refused_to_sql_ratio" {
  description = "Detector resource for connection_refused_to_sql_ratio"
  value       = signalfx_detector.connection_refused_to_sql_ratio
}

output "cpu_utilizations" {
  description = "Detector resource for cpu_utilizations"
  value       = signalfx_detector.cpu_utilizations
}

output "error_rate_5xx" {
  description = "Detector resource for error_rate_5xx"
  value       = signalfx_detector.error_rate_5xx
}

output "memory_utilizations" {
  description = "Detector resource for memory_utilizations"
  value       = signalfx_detector.memory_utilizations
}

