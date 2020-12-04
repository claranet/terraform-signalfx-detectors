output "file_descriptors" {
  description = "Detector resource for file_descriptors"
  value       = signalfx_detector.file_descriptors
}

output "heartbeat" {
  description = "Detector resource for heartbeat"
  value       = signalfx_detector.heartbeat
}

output "processes" {
  description = "Detector resource for processes"
  value       = signalfx_detector.processes
}

output "sockets" {
  description = "Detector resource for sockets"
  value       = signalfx_detector.sockets
}

output "vm_memory" {
  description = "Detector resource for vm_memory"
  value       = signalfx_detector.vm_memory
}

