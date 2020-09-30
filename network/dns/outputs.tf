output "dns_query_time" {
  description = "Detector resource for dns_query_time"
  value       = signalfx_detector.dns_query_time
}

output "dns_result_code" {
  description = "Detector resource for dns_result_code"
  value       = signalfx_detector.dns_result_code
}

output "heartbeat" {
  description = "Detector resource for heartbeat"
  value       = signalfx_detector.heartbeat
}

