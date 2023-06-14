output "cpu" {
  description = "Detector resource for cpu"
  value       = signalfx_detector.cpu
}

output "disk" {
  description = "Detector resource for disk"
  value       = signalfx_detector.disk
}

output "heartbeat" {
  description = "Detector resource for heartbeat"
  value       = signalfx_detector.heartbeat
}

output "mem" {
  description = "Detector resource for mem"
  value       = signalfx_detector.mem
}

