output "cache_hits_id" {
  description = "id for detector cache_hits"
  value       = signalfx_detector.cache_hits.*.id
}

output "cpu_high_id" {
  description = "id for detector cpu_high"
  value       = signalfx_detector.cpu_high.*.id
}

output "replication_lag_id" {
  description = "id for detector replication_lag"
  value       = signalfx_detector.replication_lag.*.id
}

output "commands_id" {
  description = "id for detector commands"
  value       = signalfx_detector.commands.*.id
}
