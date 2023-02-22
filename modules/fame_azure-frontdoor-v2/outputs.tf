output "cache_hit_rate" {
  description = "Detector resource for cache_hit_rate"
  value       = signalfx_detector.cache_hit_rate
}

output "heartbeat" {
  description = "Detector resource for heartbeat"
  value       = signalfx_detector.heartbeat
}

output "http_errors" {
  description = "Detector resource for http_errors"
  value       = signalfx_detector.http_errors
}

output "probes_errors" {
  description = "Detector resource for probes_errors"
  value       = signalfx_detector.probes_errors
}

output "waf_actions" {
  description = "Detector resource for waf_actions"
  value       = signalfx_detector.waf_actions
}

