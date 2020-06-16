output "heartbeat_id" {
  description = "id for detector heartbeat"
  value       = signalfx_detector.heartbeat.*.id
}

output "ready_id" {
  description = "id for detector ready"
  value       = signalfx_detector.ready.*.id
}

output "volume_space_id" {
  description = "id for detector volume_space"
  value       = signalfx_detector.volume_space.*.id
}

output "volume_inodes_id" {
  description = "id for detector volume_inodes"
  value       = signalfx_detector.volume_inodes.*.id
}
