output "failover_unavailable_id" {
  description = "id for detector failover_unavailable"
  value       = signalfx_detector.failover_unavailable.*.id
}
