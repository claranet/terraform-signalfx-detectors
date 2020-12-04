output "heartbeat" {
  description = "Detector resource for heartbeat"
  value       = signalfx_detector.heartbeat
}

output "incoming_records" {
  description = "Detector resource for incoming_records"
  value       = signalfx_detector.incoming_records
}

