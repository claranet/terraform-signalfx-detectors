output "cpu" {
  description = "Detector resource for cpu"
  value       = signalfx_detector.cpu
}

output "heartbeat" {
  description = "Detector resource for heartbeat"
  value       = signalfx_detector.heartbeat
}

output "remaining_cpu_credit" {
  description = "Detector resource for remaining_cpu_credit"
  value       = signalfx_detector.remaining_cpu_credit
}

