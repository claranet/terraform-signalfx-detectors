output "cache_hits" {
  description = "Detector resource for cache_hits"
  value       = signalfx_detector.cache_hits
}

output "commands" {
  description = "Detector resource for commands"
  value       = signalfx_detector.commands
}

output "cpu_high" {
  description = "Detector resource for cpu_high"
  value       = signalfx_detector.cpu_high
}

output "network_conntrack_allowance_exceeded" {
  description = "Detector resource for network_conntrack_allowance_exceeded"
  value       = signalfx_detector.network_conntrack_allowance_exceeded
}

output "replication_lag" {
  description = "Detector resource for replication_lag"
  value       = signalfx_detector.replication_lag
}

output "database_capacity_unit" {
  description = "Detector resource for database_capacity_unit"
  value       = signalfx_detector.database_capacity_unit
}
