output "alb_4xx" {
  description = "Detector resource for alb_4xx"
  value       = signalfx_detector.alb_4xx
}

output "alb_5xx" {
  description = "Detector resource for alb_5xx"
  value       = signalfx_detector.alb_5xx
}

output "healthy" {
  description = "Detector resource for healthy"
  value       = signalfx_detector.healthy
}

output "heartbeat" {
  description = "Detector resource for heartbeat"
  value       = signalfx_detector.heartbeat
}

output "latency" {
  description = "Detector resource for latency"
  value       = signalfx_detector.latency
}

output "target_4xx" {
  description = "Detector resource for target_4xx"
  value       = signalfx_detector.target_4xx
}

output "target_5xx" {
  description = "Detector resource for target_5xx"
  value       = signalfx_detector.target_5xx
}

