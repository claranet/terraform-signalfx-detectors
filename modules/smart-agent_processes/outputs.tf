output "listener" {
  description = "Detector resource for listener"
  value       = signalfx_detector.listener
}

output "processes" {
  description = "Detector resource for processes"
  value       = signalfx_detector.processes
}

