output "cpu_utilization_id" {
  description = "id for detector cpu_utilization"
  value       = signalfx_detector.cpu_utilization.*.id
}

output "disk_throttled_bps_id" {
  description = "id for detector disk_throttled_bps"
  value       = signalfx_detector.disk_throttled_bps.*.id
}

output "disk_throttled_ops_id" {
  description = "id for detector disk_throttled_ops"
  value       = signalfx_detector.disk_throttled_ops.*.id
}
