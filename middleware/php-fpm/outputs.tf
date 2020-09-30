output "heartbeat" {
  description = "Detector resource for heartbeat"
  value       = signalfx_detector.heartbeat
}

output "php_fpm_connect_idle" {
  description = "Detector resource for php_fpm_connect_idle"
  value       = signalfx_detector.php_fpm_connect_idle
}

