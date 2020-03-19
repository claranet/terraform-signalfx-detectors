output "heartbeat_id" {
  description = "id for detector heartbeat"
  value       = signalfx_detector.heartbeat.*.id
}

output "4xx_requests_id" {
  description = "id for detector 4xx_requests"
  value       = signalfx_detector.4xx_requests.*.id
}

output "5xx_requests_id" {
  description = "id for detector 5xx_requests"
  value       = signalfx_detector.5xx_requests.*.id
}

output "scaling_id" {
  description = "id for detector scaling"
  value       = signalfx_detector.scaling.*.id
}
