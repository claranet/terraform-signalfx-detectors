locals {
  memory_used_metric_name          = var.use_otel_receiver ? "redis.memory.used" : "bytes.used_memory"
  memory_rss_metric_name           = var.use_otel_receiver ? "redis.memory.rss" : "bytes.used_memory_rss"
  evicted_keys_metric_name         = var.use_otel_receiver ? "redis.keys.evicted" : "counter.evicted_keys"
  expired_keys_metric_name         = var.use_otel_receiver ? "redis.keys.expired" : "counter.expired_keys"
  blocked_clients_metric_name      = var.use_otel_receiver ? "redis.client.blocked" : "gauge.blocked_clients"
  connected_clients_metric_name    = var.use_otel_receiver ? "redis.client.connected" : "gauge.connected_clients"
  rejected_connections_metric_name = var.use_otel_receiver ? "redis.connections.rejected" : "counter.rejected_connections"
  keyspace_hits_metric_name        = var.use_otel_receiver ? "redis.keyspace.hits" : "counter.keyspace_hits"
  keyspace_misses_metric_name      = var.use_otel_receiver ? "redis.keyspace.hits" : "counter.keyspace_hits"
  db_keys_metric_name              = var.use_otel_receiver ? "redis.db.keys" : "gauge.db0_keys"

  plugin_filter = var.use_otel_receiver ? "" : "filter('plugin', 'redis_info') and "
}
