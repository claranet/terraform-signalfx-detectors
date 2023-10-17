output "database_4xx_request_rate" {
  description = "Detector resource for database_4xx_request_rate"
  value       = signalfx_detector.database_4xx_request_rate
}

output "database_5xx_request_rate" {
  description = "Detector resource for database_5xx_request_rate"
  value       = signalfx_detector.database_5xx_request_rate
}

output "heartbeat" {
  description = "Detector resource for heartbeat"
  value       = signalfx_detector.heartbeat
}

output "request_units_consumption" {
  description = "Detector resource for request_units_consumption"
  value       = signalfx_detector.request_units_consumption
}

output "scaling" {
  description = "Detector resource for scaling"
  value       = signalfx_detector.scaling
}

