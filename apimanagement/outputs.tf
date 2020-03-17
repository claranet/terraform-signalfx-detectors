output "heartbeat_id" {
  description = "id for detector heartbeat"
  value       = signalfx_detector.heartbeat.*.id
}

output "failed_requests_id" {
  description = "id for detector failed_requests"
  value       = signalfx_detector.failed_requests.*.id
}

output "other_requests_id" {
  description = "id for detector other_requests"
  value       = signalfx_detector.other_requests.*.id
}

output "unauthorized_requests_id" {
  description = "id for detector unauthorized_requests"
  value       = signalfx_detector.unauthorized_requests.*.id
}

output "successful_requests_id" {
  description = "id for detector successful_requests"
  value       = signalfx_detector.successful_requests.*.id
}
