output "iops_read_stats" {
  description = "Detector resource for iops_read_stats"
  value       = signalfx_detector.iops_read_stats
}

output "iops_write_stats" {
  description = "Detector resource for iops_write_stats"
  value       = signalfx_detector.iops_write_stats
}

output "percent_io_limit" {
  description = "Detector resource for percent_io_limit"
  value       = signalfx_detector.percent_io_limit
}

output "used_space" {
  description = "Detector resource for used_space"
  value       = signalfx_detector.used_space
}

