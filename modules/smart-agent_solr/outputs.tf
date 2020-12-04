output "errors" {
  description = "Detector resource for errors"
  value       = signalfx_detector.errors
}

output "heartbeat" {
  description = "Detector resource for heartbeat"
  value       = signalfx_detector.heartbeat
}

output "searcher_warmup_time" {
  description = "Detector resource for searcher_warmup_time"
  value       = signalfx_detector.searcher_warmup_time
}

