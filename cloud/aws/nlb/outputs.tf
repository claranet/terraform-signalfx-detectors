output "heartbeat_id" {
  description = "id for detector heartbeat"
  value       = signalfx_detector.heartbeat.*.id
}

output "no_healthy_instances_id" {
  description = "id for detector no_healthy_instances"
  value       = signalfx_detector.no_healthy_instances.*.id
}
