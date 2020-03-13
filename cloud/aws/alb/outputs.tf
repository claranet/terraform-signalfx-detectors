output "heartbeat_id" {
  description = "id for detector heartbeat"
  value       = signalfx_detector.heartbeat.*.id
}

output "no_healthy_instances_id" {
  description = "id for detector no_healthy_instances"
  value       = signalfx_detector.no_healthy_instances.*.id
}

output "latency_id" {
  description = "id for detector latency"
  value       = signalfx_detector.latency.*.id
}

output "httpcode_5xx_id" {
  description = "id for detector httpcode_5xx"
  value       = signalfx_detector.httpcode_5xx.*.id
}

output "httpcode_4xx_id" {
  description = "id for detector httpcode_4xx"
  value       = signalfx_detector.httpcode_4xx.*.id
}

output "httpcode_target_5xx_id" {
  description = "id for detector httpcode_target_5xx"
  value       = signalfx_detector.httpcode_target_5xx.*.id
}

output "httpcode_target_4xx_id" {
  description = "id for detector httpcode_target_4xx"
  value       = signalfx_detector.httpcode_target_4xx.*.id
}
