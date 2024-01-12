output "cluster-health" {
  description = "Detector resource for cluster-health"
  value       = signalfx_detector.cluster-health
}

output "cluster-latency" {
  description = "Detector resource for cluster-latency"
  value       = signalfx_detector.cluster-latency
}

output "file_descriptors" {
  description = "Detector resource for file_descriptors"
  value       = signalfx_detector.file_descriptors
}

output "heartbeat" {
  description = "Detector resource for heartbeat"
  value       = signalfx_detector.heartbeat
}

output "server-health" {
  description = "Detector resource for server-health"
  value       = signalfx_detector.server-health
}

output "server-latency" {
  description = "Detector resource for server-latency"
  value       = signalfx_detector.server-latency
}

