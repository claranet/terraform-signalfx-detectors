output "nginx_ingress_4xx" {
  description = "Detector resource for nginx_ingress_4xx"
  value       = signalfx_detector.nginx_ingress_4xx
}

output "nginx_ingress_5xx" {
  description = "Detector resource for nginx_ingress_5xx"
  value       = signalfx_detector.nginx_ingress_5xx
}

output "nginx_ingress_latency" {
  description = "Detector resource for nginx_ingress_latency"
  value       = signalfx_detector.nginx_ingress_latency
}

