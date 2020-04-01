output "heartbeat_id" {
  description = "id for detector heartbeat"
  value       = signalfx_detector.heartbeat.*.id
}

output "app_error_rate_id" {
  description = "id for detector app_error_rate"
  value       = signalfx_detector.app_error_rate.*.id
}

output "app_apdex_score_id" {
  description = "id for detector app_apdex_score"
  value       = signalfx_detector.app_apdex_score.*.id
}
