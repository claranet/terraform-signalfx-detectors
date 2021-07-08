output "cpu_usage_percent" {
  description = "Detector resource for cpu_usage_percent"
  value       = signalfx_detector.cpu_usage_percent
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

