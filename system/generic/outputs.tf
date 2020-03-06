output "heartbeat_id" {
	description = "id for detector heartbeat"
	value       = signalfx_detector.heartbeat.*.id
}

output "cpu_id" {
	description = "id for detector cpu"
	value       = signalfx_detector.cpu.*.id
}

output "load_id" {
	description = "id for detector load"
	value       = signalfx_detector.load.*.id
}

output "disk_space_id" {
	description = "id for detector disk space"
	value       = signalfx_detector.disk_space.*.id
}

output "disk_running_out_id" {
	description = "id for detector disk running out"
	value       = signalfx_detector.disk_running_out.*.id
}

output "memory_id" {
	description = "id for detector memory"
	value       = signalfx_detector.memory.*.id
}
