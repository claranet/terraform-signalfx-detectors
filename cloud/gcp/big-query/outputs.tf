output "concurrent_queries_id" {
  description = "id for detector concurrent_queries"
  value       = signalfx_detector.concurrent_queries.*.id
}

output "execution_time_id" {
  description = "id for detector execution_time"
  value       = signalfx_detector.execution_time.*.id
}

output "scanned_bytes_id" {
  description = "id for detector scanned_bytes"
  value       = signalfx_detector.scanned_bytes.*.id
}

output "scanned_bytes_billed_id" {
  description = "id for detector scanned_bytes_billed"
  value       = signalfx_detector.scanned_bytes_billed.*.id
}

output "available_slots_id" {
  description = "id for detector available_slots"
  value       = signalfx_detector.available_slots.*.id
}

output "stored_bytes_id" {
  description = "id for detector stored_bytes"
  value       = signalfx_detector.stored_bytes.*.id
}

output "table_count_id" {
  description = "id for detector table_count"
  value       = signalfx_detector.table_count.*.id
}

output "uploaded_bytes_id" {
  description = "id for detector uploaded_bytes"
  value       = signalfx_detector.uploaded_bytes.*.id
}

output "uploaded_bytes_billed_id" {
  description = "id for detector uploaded_bytes_billed"
  value       = signalfx_detector.uploaded_bytes_billed.*.id
}
