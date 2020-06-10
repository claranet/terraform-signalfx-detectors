output "file_descriptors_id" {
  description = "id for detector file descriptors"
  value       = signalfx_detector.file_descriptors.*.id
}

output "processes_id" {
  description = "id for detector processes"
  value       = signalfx_detector.processes.*.id
}

output "sockets_id" {
  description = "id for detector sockets"
  value       = signalfx_detector.sockets.*.id
}

output "vm_memory_id" {
  description = "id for detector vm memory"
  value       = signalfx_detector.vm_memory.*.id
}

output "messages_ready_ids" {
  description = "id for detector messages_ack_rate"
  value       = [
    for d in signalfx_detector.messages_ack_rate:
    d.id
  ]
}

output "messages_unacknowledged_ids" {
  description = "id for detector messages_ack_rate"
  value       = [
    for d in signalfx_detector.messages_ack_rate:
    d.id
  ]
}

output "messages_ack_rate_ids" {
  description = "id for detector messages_ack_rate"
  value       = [
    for d in signalfx_detector.messages_ack_rate:
    d.id
  ]
}

output "heartbeat_id" {
  description = "id for detector heartbeat"
  value       = signalfx_detector.heartbeat.*.id
}
