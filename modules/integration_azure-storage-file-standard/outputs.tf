output "capacity" {
  description = "Detector resource for capacity"
  value       = signalfx_detector.capacity
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

output "throughput" {
  description = "Detector resource for throughput"
  value       = signalfx_detector.throughput
}

