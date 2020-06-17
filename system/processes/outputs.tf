output "processes_id" {
  description = "id for detector processes"
  value       = signalfx_detector.processes.*.id
}
