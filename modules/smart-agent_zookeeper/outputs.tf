output "file_descriptors" {
  description = "Detector resource for file_descriptors"
  value       = signalfx_detector.file_descriptors
}

output "heartbeat" {
  description = "Detector resource for heartbeat"
  value       = signalfx_detector.heartbeat
}

output "zookeeper-health" {
  description = "Detector resource for zookeeper-health"
  value       = signalfx_detector.zookeeper-health
}

output "zookeeper-latency" {
  description = "Detector resource for zookeeper-latency"
  value       = signalfx_detector.zookeeper-latency
}

