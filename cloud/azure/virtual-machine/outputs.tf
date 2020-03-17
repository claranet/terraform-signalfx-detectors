output "heartbeat_id" {
  description = "id for detector heartbeat"
  value       = signalfx_detector.heartbeat.*.id
}

output "cpu_usage_id" {
  description = "id for detector cpu_usage"
  value       = signalfx_detector.cpu_usage.*.id
}

output "credit_cpu_id" {
  description = "id for detector credit_cpu"
  value       = signalfx_detector.credit_cpu.*.id
}
