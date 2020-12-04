output "file_descriptors" {
  description = "Detector resource for file_descriptors"
  value       = signalfx_detector.file_descriptors
}

output "heartbeat" {
  description = "Detector resource for heartbeat"
  value       = signalfx_detector.heartbeat
}

output "zookeeper_health" {
  description = "Detector resource for zookeeper_health"
  value       = signalfx_detector.zookeeper_health
}

output "zookeeper_latency" {
  description = "Detector resource for zookeeper_latency"
  value       = signalfx_detector.zookeeper_latency
}

