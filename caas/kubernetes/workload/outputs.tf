output "replica_available_id" {
  description = "id for detector replica_available"
  value       = signalfx_detector.replica_available.*.id
}

output "replica_ready_id" {
  description = "id for detector replica_ready"
  value       = signalfx_detector.replica_ready.*.id
}
