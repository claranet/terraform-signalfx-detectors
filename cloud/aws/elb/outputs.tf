output "backend_4xx" {
  description = "Detector resource for backend_4xx"
  value       = signalfx_detector.backend_4xx
}

output "backend_5xx" {
  description = "Detector resource for backend_5xx"
  value       = signalfx_detector.backend_5xx
}

output "backend_latency" {
  description = "Detector resource for backend_latency"
  value       = signalfx_detector.backend_latency
}

output "elb_4xx" {
  description = "Detector resource for elb_4xx"
  value       = signalfx_detector.elb_4xx
}

output "elb_5xx" {
  description = "Detector resource for elb_5xx"
  value       = signalfx_detector.elb_5xx
}

output "heartbeat" {
  description = "Detector resource for heartbeat"
  value       = signalfx_detector.heartbeat
}

output "no_healthy_instances" {
  description = "Detector resource for no_healthy_instances"
  value       = signalfx_detector.no_healthy_instances
}

