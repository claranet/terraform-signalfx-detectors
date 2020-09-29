output "apache_workers" {
  description = "Detector resource for apache_workers"
  value       = signalfx_detector.apache_workers
}

output "heartbeat" {
  description = "Detector resource for heartbeat"
  value       = signalfx_detector.heartbeat
}

