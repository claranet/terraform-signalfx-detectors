output "cpu_usage" {
  description = "Detector resource for cpu_usage"
  value       = signalfx_detector.cpu_usage
}

output "credit_cpu" {
  description = "Detector resource for credit_cpu"
  value       = signalfx_detector.credit_cpu
}

output "heartbeat" {
  description = "Detector resource for heartbeat"
  value       = signalfx_detector.heartbeat
}

