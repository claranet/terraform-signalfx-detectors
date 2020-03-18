output "heartbeat_id" {
  description = "id for detector heartbeat"
  value       = signalfx_detector.heartbeat.*.id
}

output "jobs_failed_id" {
  description = "id for detector jobs_failed"
  value       = signalfx_detector.jobs_failed.*.id
}

output "list_jobs_failed_id" {
  description = "id for detector list_jobs_failed"
  value       = signalfx_detector.list_jobs_failed.*.id
}

output "query_jobs_failed_id" {
  description = "id for detector query_jobs_failed"
  value       = signalfx_detector.query_jobs_failed.*.id
}

output "total_devices_id" {
  description = "id for detector total_devices"
  value       = signalfx_detector.total_devices.*.id
}

output "c2d_methods_failed_id" {
  description = "id for detector c2d_methods_failed"
  value       = signalfx_detector.c2d_methods_failed.*.id
}

output "c2d_twin_read_failed_id" {
  description = "id for detector c2d_twin_read_failed"
  value       = signalfx_detector.c2d_twin_read_failed.*.id
}

output "c2d_twin_update_failed_id" {
  description = "id for detector c2d_twin_update_failed"
  value       = signalfx_detector.c2d_twin_update_failed.*.id
}

output "d2c_twin_read_failed_id" {
  description = "id for detector d2c_twin_read_failed"
  value       = signalfx_detector.d2c_twin_read_failed.*.id
}

output "d2c_twin_update_failed_id" {
  description = "id for detector d2c_twin_update_failed"
  value       = signalfx_detector.d2c_twin_update_failed.*.id
}

output "d2c_telemetry_egress_dropped_id" {
  description = "id for detector d2c_telemetry_egress_dropped"
  value       = signalfx_detector.d2c_telemetry_egress_dropped.*.id
}

output "d2c_telemetry_egress_orphaned_id" {
  description = "id for detector d2c_telemetry_egress_orphaned"
  value       = signalfx_detector.d2c_telemetry_egress_orphaned.*.id
}

output "d2c_telemetry_egress_invalid_id" {
  description = "id for detector d2c_telemetry_egress_invalid"
  value       = signalfx_detector.d2c_telemetry_egress_invalid.*.id
}

output "d2c_telemetry_ingress_nosent_id" {
  description = "id for detector d2c_telemetry_ingress_nosent"
  value       = signalfx_detector.d2c_telemetry_ingress_nosent.*.id
}
