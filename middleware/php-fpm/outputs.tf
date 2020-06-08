output "heartbeat_id" {
  description = "id for detector heartbeat"
  value       = signalfx_detector.heartbeat.*.id
}

output "php_fpm_connect_idle_id" {
  description = "id for detector php_fpm_connect_idle"
  value       = signalfx_detector.php_fpm_connect_idle.*.id
}
