output "heartbeat_id" {
  description = "id for detector heartbeat"
  value       = signalfx_detector.heartbeat.*.id
}

output "cpu_id" {
  description = "id for detector cpu"
  value       = signalfx_detector.cpu.*.id
}

output "free_space_id" {
  description = "id for detector free_space"
  value       = signalfx_detector.free_space.*.id
}

output "dtu_consumption_id" {
  description = "id for detector dtu_consumption"
  value       = signalfx_detector.dtu_consumption.*.id
}
