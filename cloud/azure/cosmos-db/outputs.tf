output "heartbeat_id" {
  description = "id for detector heartbeat"
  value       = signalfx_detector.heartbeat.*.id
}

output "db_4xx_requests_id" {
  description = "id for detector db_4xx_requests"
  value       = signalfx_detector.db_4xx_requests.*.id
}

output "db_5xx_requests_id" {
  description = "id for detector db_5xx_requests"
  value       = signalfx_detector.db_5xx_requests.*.id
}

output "scaling_id" {
  description = "id for detector scaling"
  value       = signalfx_detector.scaling.*.id
}
