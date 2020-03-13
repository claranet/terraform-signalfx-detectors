output "heartbeat_id" {
  description = "id for detector heartbeat"
  value       = signalfx_detector.heartbeat.*.id
}

output "no_healthy_instances_id" {
  description = "id for detector no_healthy_instances"
  value       = signalfx_detector.no_healthy_instances.*.id
}

output "too_much_4xx_id" {
  description = "id for detector too_much_4xx"
  value       = signalfx_detector.too_much_4xx.*.id
}

output "too_much_5xx_id" {
  description = "id for detector too_much_5xx"
  value       = signalfx_detector.too_much_5xx.*.id
}

output "too_much_4xx_backend_id" {
  description = "id for detector too_much_4xx_backend"
  value       = signalfx_detector.too_much_4xx_backend.*.id
}

output "too_much_5xx_backend_id" {
  description = "id for detector too_much_5xx_backend"
  value       = signalfx_detector.too_much_5xx_backend.*.id
}

output "backend_latency_id" {
  description = "id for detector backend_latency"
  value       = signalfx_detector.backend_latency.*.id
}
