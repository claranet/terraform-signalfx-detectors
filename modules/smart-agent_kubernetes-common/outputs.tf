output "daemonset_crashloopbackoff" {
  description = "Detector resource for daemonset_crashloopbackoff"
  value       = signalfx_detector.daemonset_crashloopbackoff
}

output "daemonset_misscheduled" {
  description = "Detector resource for daemonset_misscheduled"
  value       = signalfx_detector.daemonset_misscheduled
}

output "daemonset_ready" {
  description = "Detector resource for daemonset_ready"
  value       = signalfx_detector.daemonset_ready
}

output "daemonset_scheduled" {
  description = "Detector resource for daemonset_scheduled"
  value       = signalfx_detector.daemonset_scheduled
}

output "deployment_available" {
  description = "Detector resource for deployment_available"
  value       = signalfx_detector.deployment_available
}

output "deployment_crashloopbackoff" {
  description = "Detector resource for deployment_crashloopbackoff"
  value       = signalfx_detector.deployment_crashloopbackoff
}

output "heartbeat" {
  description = "Detector resource for heartbeat"
  value       = signalfx_detector.heartbeat
}

output "job_failed" {
  description = "Detector resource for job_failed"
  value       = signalfx_detector.job_failed
}

output "node_ready" {
  description = "Detector resource for node_ready"
  value       = signalfx_detector.node_ready
}

output "oom_killed" {
  description = "Detector resource for oom_killed"
  value       = signalfx_detector.oom_killed
}

output "pod_phase_status" {
  description = "Detector resource for pod_phase_status"
  value       = signalfx_detector.pod_phase_status
}

output "replicaset_available" {
  description = "Detector resource for replicaset_available"
  value       = signalfx_detector.replicaset_available
}

output "replication_controller_available" {
  description = "Detector resource for replication_controller_available"
  value       = signalfx_detector.replication_controller_available
}

output "satefulset_ready" {
  description = "Detector resource for satefulset_ready"
  value       = signalfx_detector.satefulset_ready
}

output "terminated" {
  description = "Detector resource for terminated"
  value       = signalfx_detector.terminated
}

