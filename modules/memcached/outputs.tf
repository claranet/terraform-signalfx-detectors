output "heartbeat" {
  description = "Detector resource for heartbeat"
  value       = signalfx_detector.heartbeat
}

output "memcached_max_conn" {
  description = "Detector resource for memcached_max_conn"
  value       = signalfx_detector.memcached_max_conn
}

