output "heartbeat" {
  description = "Detector resource for heartbeat"
  value       = signalfx_detector.heartbeat
}

output "read_latency_99th_percentile" {
  description = "Detector resource for read_latency_99th_percentile"
  value       = signalfx_detector.read_latency_99th_percentile
}

output "read_latency_real_time" {
  description = "Detector resource for read_latency_real_time"
  value       = signalfx_detector.read_latency_real_time
}

output "storage_exceptions_count" {
  description = "Detector resource for storage_exceptions_count"
  value       = signalfx_detector.storage_exceptions_count
}

output "transactional_read_latency_99th_percentile" {
  description = "Detector resource for transactional_read_latency_99th_percentile"
  value       = signalfx_detector.transactional_read_latency_99th_percentile
}

output "transactional_read_latency_real_time" {
  description = "Detector resource for transactional_read_latency_real_time"
  value       = signalfx_detector.transactional_read_latency_real_time
}

output "transactional_write_latency_99th_percentile" {
  description = "Detector resource for transactional_write_latency_99th_percentile"
  value       = signalfx_detector.transactional_write_latency_99th_percentile
}

output "transactional_write_latency_real_time" {
  description = "Detector resource for transactional_write_latency_real_time"
  value       = signalfx_detector.transactional_write_latency_real_time
}

output "write_latency_99th_percentile" {
  description = "Detector resource for write_latency_99th_percentile"
  value       = signalfx_detector.write_latency_99th_percentile
}

output "write_latency_real_time" {
  description = "Detector resource for write_latency_real_time"
  value       = signalfx_detector.write_latency_real_time
}

