output "heartbeat_id" {
  description = "id for detector heartbeat"
  value       = signalfx_detector.heartbeat.*.id
}

output "cluster_status_not_green_id" {
  description = "id for detector cluster_status_not_green"
  value       = signalfx_detector.cluster_status_not_green.*.id
}

output "cluster_initializing_shards_id" {
  description = "id for detector cluster_initializing_shards"
  value       = signalfx_detector.cluster_initializing_shards.*.id
}

output "cluster_relocating_shards_id" {
  description = "id for detector cluster_relocating_shards"
  value       = signalfx_detector.cluster_relocating_shards.*.id
}

output "cluster_unassigned_shards_id" {
  description = "id for detector cluster_unassigned_shards"
  value       = signalfx_detector.cluster_unassigned_shards.*.id
}

output "jvm_heap_memory_usage_id" {
  description = "id for detector jvm_heap_memory_usage"
  value       = signalfx_detector.jvm_heap_memory_usage.*.id
}

output "jvm_memory_young_usage_id" {
  description = "id for detector jvm_memory_young_usage"
  value       = signalfx_detector.jvm_memory_young_usage.*.id
}

output "jvm_memory_old_usage_id" {
  description = "id for detector jvm_memory_old_usage"
  value       = signalfx_detector.jvm_memory_old_usage.*.id
}

output "jvm_gc_old_collection_latency_id" {
  description = "id for detector jvm_gc_old_collection_latency"
  value       = signalfx_detector.jvm_gc_old_collection_latency.*.id
}

output "jvm_gc_young_collection_latency_id" {
  description = "id for detector jvm_gc_young_collection_latency"
  value       = signalfx_detector.jvm_gc_young_collection_latency.*.id
}

output "indexing_latency_id" {
  description = "id for detector indexing_latency"
  value       = signalfx_detector.indexing_latency.*.id
}

output "flush_latency_id" {
  description = "id for detector flush_latency"
  value       = signalfx_detector.flush_latency.*.id
}

output "http_connections_anomaly_id" {
  description = "id for detector http_connections_anomaly"
  value       = signalfx_detector.http_connections_anomaly.*.id
}

output "search_query_latency_id" {
  description = "id for detector search_query_latency"
  value       = signalfx_detector.search_query_latency.*.id
}

output "fetch_latency_id" {
  description = "id for detector fetch_latency"
  value       = signalfx_detector.fetch_latency.*.id
}

output "search_query_change_id" {
  description = "id for detector search_query_change"
  value       = signalfx_detector.search_query_change.*.id
}

output "fetch_change_id" {
  description = "id for detector fetch_change"
  value       = signalfx_detector.fetch_change.*.id
}

output "field_data_evictions_change_id" {
  description = "id for detector field_data_evictions_change"
  value       = signalfx_detector.field_data_evictions_change.*.id
}

output "query_cache_evictions_change_id" {
  description = "id for detector query_cache_evictions_change"
  value       = signalfx_detector.query_cache_evictions_change.*.id
}

output "request_cache_evictions_change_id" {
  description = "id for detector request_cache_evictions_change"
  value       = signalfx_detector.request_cache_evictions_change.*.id
}

output "task_time_in_queue_change_id" {
  description = "id for detector task_time_in_queue_change"
  value       = signalfx_detector.task_time_in_queue_change.*.id
}
