output "cpu_percent" {
  description = "Detector resource for cpu_percent"
  value       = signalfx_detector.cpu_percent
}

output "events_in_high" {
  description = "Detector resource for events_in_high"
  value       = signalfx_detector.events_in_high
}

output "events_in_low" {
  description = "Detector resource for events_in_low"
  value       = signalfx_detector.events_in_low
}

output "events_out_high" {
  description = "Detector resource for events_out_high"
  value       = signalfx_detector.events_out_high
}

output "events_out_low" {
  description = "Detector resource for events_out_low"
  value       = signalfx_detector.events_out_low
}

output "heartbeat" {
  description = "Detector resource for heartbeat"
  value       = signalfx_detector.heartbeat
}

output "queued_disk" {
  description = "Detector resource for queued_disk"
  value       = signalfx_detector.queued_disk
}

output "queued_events" {
  description = "Detector resource for queued_events"
  value       = signalfx_detector.queued_events
}

