output "cpu" {
  description = "Detector resource for cpu"
  value       = signalfx_detector.cpu
}

output "storage_usage" {
  description = "Detector resource for storage_usage"
  value       = signalfx_detector.storage_usage
}

