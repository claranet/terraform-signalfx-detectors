output "db_4xx_requests" {
  description = "Detector resource for db_4xx_requests"
  value       = signalfx_detector.db_4xx_requests
}

output "db_5xx_requests" {
  description = "Detector resource for db_5xx_requests"
  value       = signalfx_detector.db_5xx_requests
}

output "heartbeat" {
  description = "Detector resource for heartbeat"
  value       = signalfx_detector.heartbeat
}

output "scaling" {
  description = "Detector resource for scaling"
  value       = signalfx_detector.scaling
}

output "used_rus_capacity" {
  description = "Detector resource for used_rus_capacity"
  value       = signalfx_detector.used_rus_capacity
}

