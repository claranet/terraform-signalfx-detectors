output "get_hits_id" {
  description = "id for detector get_hits"
  value       = signalfx_detector.get_hits.*.id
}

output "cpu_high_id" {
  description = "id for detector cpu_high"
  value       = signalfx_detector.cpu_high.*.id
}
