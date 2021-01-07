output "http_4xx" {
  description = "Detector resource for http_4xx"
  value       = signalfx_detector.http_4xx
}

output "http_5xx" {
  description = "Detector resource for http_5xx"
  value       = signalfx_detector.http_5xx
}

output "latency" {
  description = "Detector resource for latency"
  value       = signalfx_detector.latency
}

