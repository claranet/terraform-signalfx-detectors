output "capacity" {
  description = "Detector resource for capacity"
  value       = signalfx_detector.capacity
}

output "egress" {
  description = "Detector resource for egress"
  value       = signalfx_detector.egress
}

output "ingress" {
  description = "Detector resource for ingress"
  value       = signalfx_detector.ingress
}

output "iops" {
  description = "Detector resource for iops"
  value       = signalfx_detector.iops
}

output "no_snapshots" {
  description = "Detector resource for no_snapshots"
  value       = signalfx_detector.no_snapshots
}

output "snapshots_limit" {
  description = "Detector resource for snapshots_limit"
  value       = signalfx_detector.snapshots_limit
}

output "throttling" {
  description = "Detector resource for throttling"
  value       = signalfx_detector.throttling
}

