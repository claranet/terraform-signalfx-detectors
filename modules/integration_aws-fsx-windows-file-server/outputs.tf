output "cpu_utilization" {
  description = "Detector resource for cpu_utilization"
  value       = signalfx_detector.cpu_utilization
}

output "file_server_disk_throughput_utilization" {
  description = "Detector resource for file_server_disk_throughput_utilization"
  value       = signalfx_detector.file_server_disk_throughput_utilization
}

output "free_space" {
  description = "Detector resource for free_space"
  value       = signalfx_detector.free_space
}

output "heartbeat" {
  description = "Detector resource for heartbeat"
  value       = signalfx_detector.heartbeat
}

output "memory_utilization" {
  description = "Detector resource for memory_utilization"
  value       = signalfx_detector.memory_utilization
}

output "network_throughput_utilization" {
  description = "Detector resource for network_throughput_utilization"
  value       = signalfx_detector.network_throughput_utilization
}

output "storage_capacity_utilization" {
  description = "Detector resource for storage_capacity_utilization"
  value       = signalfx_detector.storage_capacity_utilization
}

