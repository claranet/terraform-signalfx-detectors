output "heartbeat_id" {
  description = "id for detector heartbeat"
  value       = signalfx_detector.heartbeat.*.id
}

output "cluster_status_id" {
  description = "id for detector cluster_status"
  value       = signalfx_detector.cluster_status.*.id
}

output "free_space_id" {
  description = "id for detector free_space"
  value       = signalfx_detector.free_space.*.id
}

output "cpu_90_15min_id" {
  description = "id for detector cpu_90_15min"
  value       = signalfx_detector.cpu_90_15min.*.id
}
