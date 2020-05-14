output "nginx_ingress_too_many_5xx_id" {
  description = "id for detector nginx_ingress_too_many_5xx"
  value       = signalfx_detector.nginx_ingress_too_many_5xx.*.id
}

output "nginx_ingress_too_many_4xx_id" {
  description = "id for detector nginx_ingress_too_many_4xx"
  value       = signalfx_detector.nginx_ingress_too_many_4xx.*.id
}
