output "heartbeat_id" {
  description = "id for detector heartbeat"
  value       = signalfx_detector.heartbeat.*.id
}

output "zookeeper_latency_id" {
  description = "id for detector zookeeper_latency"
  value       = signalfx_detector.zookeeper_latency.*.id
}
