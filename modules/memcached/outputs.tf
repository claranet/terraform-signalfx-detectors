output "heartbeat" {
  description = "Detector resource for heartbeat"
  value       = signalfx_detector.heartbeat
}

output "memcached_hit_ratio" {
  description = "Detector resource for memcached_hit_ratio"
  value       = signalfx_detector.memcached_hit_ratio
}

output "memcached_max_conn" {
  description = "Detector resource for memcached_max_conn"
  value       = signalfx_detector.memcached_max_conn
}

