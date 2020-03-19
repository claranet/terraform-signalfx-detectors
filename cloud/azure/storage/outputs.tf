output "heartbeat_id" {
  description = "id for detector heartbeat"
  value       = signalfx_detector.heartbeat.*.id
}

output "blobservices_requests_error_id" {
  description = "id for detector blobservices_requests_error"
  value       = signalfx_detector.blobservices_requests_error.*.id
}

output "fileservices_requests_error_id" {
  description = "id for detector fileservices_requests_error"
  value       = signalfx_detector.fileservices_requests_error.*.id
}

output "queueservices_requests_error_id" {
  description = "id for detector queueservices_requests_error"
  value       = signalfx_detector.queueservices_requests_error.*.id
}

output "tableservices_requests_error_id" {
  description = "id for detector tableservices_requests_error"
  value       = signalfx_detector.tableservices_requests_error.*.id
}

output "blobservices_latency_id" {
  description = "id for detector blobservices_latency"
  value       = signalfx_detector.blobservices_latency.*.id
}

output "fileservices_latency_id" {
  description = "id for detector fileservices_latency"
  value       = signalfx_detector.fileservices_latency.*.id
}

output "queueservices_latency_id" {
  description = "id for detector queueservices_latency"
  value       = signalfx_detector.queueservices_latency.*.id
}

output "tableservices_latency_id" {
  description = "id for detector tableservices_latency"
  value       = signalfx_detector.tableservices_latency.*.id
}

output "blob_timeout_error_requests_id" {
  description = "id for detector blob_timeout_error_requests"
  value       = signalfx_detector.blob_timeout_error_requests.*.id
}

output "file_timeout_error_requests_id" {
  description = "id for detector file_timeout_error_requests"
  value       = signalfx_detector.file_timeout_error_requests.*.id
}

output "queue_timeout_error_requests_id" {
  description = "id for detector queue_timeout_error_requests"
  value       = signalfx_detector.queue_timeout_error_requests.*.id
}

output "table_timeout_error_requests_id" {
  description = "id for detector table_timeout_error_requests"
  value       = signalfx_detector.table_timeout_error_requests.*.id
}

output "blob_network_error_requests_id" {
  description = "id for detector blob_network_error_requests"
  value       = signalfx_detector.blob_network_error_requests.*.id
}

output "file_network_error_requests_id" {
  description = "id for detector file_network_error_requests"
  value       = signalfx_detector.file_network_error_requests.*.id
}

output "queue_network_error_requests_id" {
  description = "id for detector queue_network_error_requests"
  value       = signalfx_detector.queue_network_error_requests.*.id
}

output "table_network_error_requests_id" {
  description = "id for detector table_network_error_requests"
  value       = signalfx_detector.table_network_error_requests.*.id
}

output "blob_throttling_error_requests_id" {
  description = "id for detector blob_throttling_error_requests"
  value       = signalfx_detector.blob_throttling_error_requests.*.id
}

output "file_throttling_error_requests_id" {
  description = "id for detector file_throttling_error_requests"
  value       = signalfx_detector.file_throttling_error_requests.*.id
}

output "queue_throttling_error_requests_id" {
  description = "id for detector queue_throttling_error_requests"
  value       = signalfx_detector.queue_throttling_error_requests.*.id
}

output "table_throttling_error_requests_id" {
  description = "id for detector table_throttling_error_requests"
  value       = signalfx_detector.table_throttling_error_requests.*.id
}

output "blob_server_other_error_requests_id" {
  description = "id for detector blob_server_other_error_requests"
  value       = signalfx_detector.blob_server_other_error_requests.*.id
}

output "file_server_other_error_requests_id" {
  description = "id for detector file_server_other_error_requests"
  value       = signalfx_detector.file_server_other_error_requests.*.id
}

output "queue_server_other_error_requests_id" {
  description = "id for detector queue_server_other_error_requests"
  value       = signalfx_detector.queue_server_other_error_requests.*.id
}

output "table_server_other_error_requests_id" {
  description = "id for detector table_server_other_error_requests"
  value       = signalfx_detector.table_server_other_error_requests.*.id
}

output "blob_client_other_error_requests_id" {
  description = "id for detector blob_client_other_error_requests"
  value       = signalfx_detector.blob_client_other_error_requests.*.id
}

output "file_client_other_error_requests_id" {
  description = "id for detector file_client_other_error_requests"
  value       = signalfx_detector.file_client_other_error_requests.*.id
}

output "queue_client_other_error_requests_id" {
  description = "id for detector queue_client_other_error_requests"
  value       = signalfx_detector.queue_client_other_error_requests.*.id
}

output "table_client_other_error_requests_id" {
  description = "id for detector table_client_other_error_requests"
  value       = signalfx_detector.table_client_other_error_requests.*.id
}

output "blob_authorization_error_requests_id" {
  description = "id for detector blob_authorization_error_requests"
  value       = signalfx_detector.blob_authorization_error_requests.*.id
}

output "file_authorization_error_requests_id" {
  description = "id for detector file_authorization_error_requests"
  value       = signalfx_detector.file_authorization_error_requests.*.id
}

output "queue_authorization_error_requests_id" {
  description = "id for detector queue_authorization_error_requests"
  value       = signalfx_detector.queue_authorization_error_requests.*.id
}

output "table_authorization_error_requests_id" {
  description = "id for detector table_authorization_error_requests"
  value       = signalfx_detector.table_authorization_error_requests.*.id
}
