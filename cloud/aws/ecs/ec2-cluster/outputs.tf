output "heartbeat_id" {
  description = "id for detector heartbeat"
  value       = signalfx_detector.heartbeat.*.id
}

output "cpu_utilization_id" {
  description = "id for detector no_healthy_instances"
  value       = signalfx_detector.no_healthy_instances.*.id
}

output "memory_reservation_id" {
  description = "id for detector memory_reservation"
  value       = signalfx_detector.memory_reservation.*.id
}
