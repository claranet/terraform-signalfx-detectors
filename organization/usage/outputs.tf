output "hosts_limit" {
  description = "id for detector hosts_limit"
  value       = signalfx_detector.hosts_limit
}

output "containers_limit" {
  description = "id for detector containers_limit"
  value       = signalfx_detector.containers_limit
}

output "custom_metrics_limit" {
  description = "id for detector custom_metrics_limit"
  value       = signalfx_detector.custom_metrics_limit
}

output "containers_ratio" {
  description = "id for detector containers_ratio"
  value       = signalfx_detector.containers_ratio
}

output "custom_metrics_ratio" {
  description = "id for detector custom_metrics_ratio"
  value       = signalfx_detector.custom_metrics_ratio
}

