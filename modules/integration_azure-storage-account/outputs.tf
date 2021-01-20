output "capacity" {
  description = "Detector resource for capacity"
  value       = signalfx_detector.capacity
}

output "count" {
  description = "Detector resource for count"
  value       = signalfx_detector.count
}

output "egress" {
  description = "Detector resource for egress"
  value       = signalfx_detector.egress
}

output "ingress" {
  description = "Detector resource for ingress"
  value       = signalfx_detector.ingress
}

output "latency_e2e" {
  description = "Detector resource for latency_e2e"
  value       = signalfx_detector.latency_e2e
}

output "requests_rate" {
  description = "Detector resource for requests_rate"
  value       = signalfx_detector.requests_rate
}

output "requests_rate_status" {
  description = "Detector resource for requests_rate_status"
  value       = signalfx_detector.requests_rate_status
}

