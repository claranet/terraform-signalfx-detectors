# Global

variable "environment" {
  description = "Infrastructure environment"
  type        = string
}

# SignalFx module specific

variable "notifications" {
  description = "Notification recipients list for every detectors"
  type        = list
}

variable "prefixes" {
  description = "Prefixes list to prepend between brackets on every monitors names before environment"
  type        = list
  default     = []
}

variable "filter_custom_includes" {
  description = "List of tags to include when custom filtering is used"
  type        = list
  default     = []
}

variable "filter_custom_excludes" {
  description = "List of tags to exclude when custom filtering is used"
  type        = list
  default     = []
}

variable "detectors_disabled" {
  description = "Disable all detectors in this module"
  type        = bool
  default     = false
}

# ElasticSearch detectors specific

variable "heartbeat_disabled" {
  description = "Disable all alerting rules for heartbeat detector"
  type        = bool
  default     = null
}

variable "heartbeat_notifications" {
  description = "Notification recipients list for every alerting rules of heartbeat detector"
  type        = list
  default     = []
}

variable "heartbeat_timeframe" {
  description = "Timeframe for system not reporting detector (i.e. \"10m\")"
  type        = string
  default     = "20m"
}

# Cluster_status_not_green detectors

variable "cluster_status_not_green_disabled" {
  description = "Disable all alerting rules for cluster_status_not_green detector"
  type        = bool
  default     = null
}

variable "cluster_status_not_green_disabled_critical" {
  description = "Disable critical alerting rule for cluster_status_not_green detector"
  type        = bool
  default     = null
}

variable "cluster_status_not_green_disabled_warning" {
  description = "Disable warning alerting rule for cluster_status_not_green detector"
  type        = bool
  default     = null
}

variable "cluster_status_not_green_notifications" {
  description = "Notification recipients list for every alerting rules of cluster_status_not_green detector"
  type        = list
  default     = []
}

variable "cluster_status_not_green_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of cluster_status_not_green detector"
  type        = list
  default     = []
}

variable "cluster_status_not_green_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of cluster_status_not_green detector"
  type        = list
  default     = []
}

variable "cluster_status_not_green_aggregation_function" {
  description = "Aggregation function and group by for cluster_status_not_green detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "cluster_status_not_green_transformation_function" {
  description = "Transformation function for cluster_status_not_green detector (mean, min, max)"
  type        = string
  default     = "mean"
}

variable "cluster_status_not_green_transformation_window" {
  description = "Transformation window for cluster_status_not_green detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "cluster_status_not_green_threshold_critical" {
  description = "Critical threshold for cluster_status_not_green detector"
  type        = number
  default     = 2
}

variable "cluster_status_not_green_threshold_warning" {
  description = "Warning threshold for cluster_status_not_green detector"
  type        = number
  default     = 1
}

# Cluster_initializing_shards detectors

variable "cluster_initializing_shards_disabled" {
  description = "Disable all alerting rules for cluster_initializing_shards detector"
  type        = bool
  default     = null
}

variable "cluster_initializing_shards_disabled_critical" {
  description = "Disable critical alerting rule for cluster_initializing_shards detector"
  type        = bool
  default     = null
}

variable "cluster_initializing_shards_disabled_warning" {
  description = "Disable warning alerting rule for cluster_initializing_shards detector"
  type        = bool
  default     = null
}

variable "cluster_initializing_shards_notifications" {
  description = "Notification recipients list for every alerting rules of cluster_initializing_shards detector"
  type        = list
  default     = []
}

variable "cluster_initializing_shards_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of cluster_initializing_shards detector"
  type        = list
  default     = []
}

variable "cluster_initializing_shards_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of cluster_initializing_shards detector"
  type        = list
  default     = []
}

variable "cluster_initializing_shards_aggregation_function" {
  description = "Aggregation function and group by for cluster_initializing_shards detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['cluster'])"
}

variable "cluster_initializing_shards_transformation_function" {
  description = "Transformation function for cluster_initializing_shards detector (mean, min, max)"
  type        = string
  default     = "mean"
}

variable "cluster_initializing_shards_transformation_window" {
  description = "Transformation window for cluster_initializing_shards detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "cluster_initializing_shards_threshold_critical" {
  description = "Critical threshold for cluster_initializing_shards detector"
  type        = number
  default     = 2
}

variable "cluster_initializing_shards_threshold_warning" {
  description = "Warning threshold for cluster_initializing_shards detector"
  type        = number
  default     = 1
}

# Cluster_relocating_shards detectors

variable "cluster_relocating_shards_disabled" {
  description = "Disable all alerting rules for cluster_relocating_shards detector"
  type        = bool
  default     = null
}

variable "cluster_relocating_shards_disabled_critical" {
  description = "Disable critical alerting rule for cluster_relocating_shards detector"
  type        = bool
  default     = null
}

variable "cluster_relocating_shards_disabled_warning" {
  description = "Disable warning alerting rule for cluster_relocating_shards detector"
  type        = bool
  default     = null
}

variable "cluster_relocating_shards_notifications" {
  description = "Notification recipients list for every alerting rules of cluster_relocating_shards detector"
  type        = list
  default     = []
}

variable "cluster_relocating_shards_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of cluster_relocating_shards detector"
  type        = list
  default     = []
}

variable "cluster_relocating_shards_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of cluster_relocating_shards detector"
  type        = list
  default     = []
}

variable "cluster_relocating_shards_aggregation_function" {
  description = "Aggregation function and group by for cluster_relocating_shards detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['cluster'])"
}

variable "cluster_relocating_shards_transformation_function" {
  description = "Transformation function for cluster_relocating_shards detector (mean, min, max)"
  type        = string
  default     = "mean"
}

variable "cluster_relocating_shards_transformation_window" {
  description = "Transformation window for cluster_relocating_shards detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "cluster_relocating_shards_threshold_critical" {
  description = "Critical threshold for cluster_relocating_shards detector"
  type        = number
  default     = 2
}

variable "cluster_relocating_shards_threshold_warning" {
  description = "Warning threshold for cluster_relocating_shards detector"
  type        = number
  default     = 1
}

# Cluster_unassigned_shards detectors

variable "cluster_unassigned_shards_disabled" {
  description = "Disable all alerting rules for cluster_unassigned_shards detector"
  type        = bool
  default     = null
}

variable "cluster_unassigned_shards_disabled_critical" {
  description = "Disable critical alerting rule for cluster_unassigned_shards detector"
  type        = bool
  default     = null
}

variable "cluster_unassigned_shards_disabled_warning" {
  description = "Disable warning alerting rule for cluster_unassigned_shards detector"
  type        = bool
  default     = null
}

variable "cluster_unassigned_shards_notifications" {
  description = "Notification recipients list for every alerting rules of cluster_unassigned_shards detector"
  type        = list
  default     = []
}

variable "cluster_unassigned_shards_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of cluster_unassigned_shards detector"
  type        = list
  default     = []
}

variable "cluster_unassigned_shards_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of cluster_unassigned_shards detector"
  type        = list
  default     = []
}

variable "cluster_unassigned_shards_aggregation_function" {
  description = "Aggregation function and group by for cluster_unassigned_shards detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['cluster'])"
}

variable "cluster_unassigned_shards_transformation_function" {
  description = "Transformation function for cluster_unassigned_shards detector (mean, min, max)"
  type        = string
  default     = "mean"
}

variable "cluster_unassigned_shards_transformation_window" {
  description = "Transformation window for cluster_unassigned_shards detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "cluster_unassigned_shards_threshold_critical" {
  description = "Critical threshold for cluster_unassigned_shards detector"
  type        = number
  default     = 2
}

variable "cluster_unassigned_shards_threshold_warning" {
  description = "Warning threshold for cluster_unassigned_shards detector"
  type        = number
  default     = 1
}

# Jvm_heap_memory_usage detectors

variable "jvm_heap_memory_usage_disabled" {
  description = "Disable all alerting rules for jvm_heap_memory_usage detector"
  type        = bool
  default     = null
}

variable "jvm_heap_memory_usage_disabled_critical" {
  description = "Disable critical alerting rule for jvm_heap_memory_usage detector"
  type        = bool
  default     = null
}

variable "jvm_heap_memory_usage_disabled_warning" {
  description = "Disable warning alerting rule for jvm_heap_memory_usage detector"
  type        = bool
  default     = null
}

variable "jvm_heap_memory_usage_notifications" {
  description = "Notification recipients list for every alerting rules of jvm_heap_memory_usage detector"
  type        = list
  default     = []
}

variable "jvm_heap_memory_usage_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of jvm_heap_memory_usage detector"
  type        = list
  default     = []
}

variable "jvm_heap_memory_usage_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of jvm_heap_memory_usage detector"
  type        = list
  default     = []
}

variable "jvm_heap_memory_usage_aggregation_function" {
  description = "Aggregation function and group by for jvm_heap_memory_usage detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['node_name'])"
}

variable "jvm_heap_memory_usage_transformation_function" {
  description = "Transformation function for jvm_heap_memory_usage detector (mean, min, max)"
  type        = string
  default     = "mean"
}

variable "jvm_heap_memory_usage_transformation_window" {
  description = "Transformation window for jvm_heap_memory_usage detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "jvm_heap_memory_usage_threshold_critical" {
  description = "Critical threshold for jvm_heap_memory_usage detector"
  type        = number
  default     = 90
}

variable "jvm_heap_memory_usage_threshold_warning" {
  description = "Warning threshold for jvm_heap_memory_usage detector"
  type        = number
  default     = 80
}

# Jvm_memory_young_usage detectors

variable "jvm_memory_young_usage_disabled" {
  description = "Disable all alerting rules for jvm_memory_young_usage detector"
  type        = bool
  default     = null
}

variable "jvm_memory_young_usage_disabled_critical" {
  description = "Disable critical alerting rule for jvm_memory_young_usage detector"
  type        = bool
  default     = null
}

variable "jvm_memory_young_usage_disabled_warning" {
  description = "Disable warning alerting rule for jvm_memory_young_usage detector"
  type        = bool
  default     = null
}

variable "jvm_memory_young_usage_notifications" {
  description = "Notification recipients list for every alerting rules of jvm_memory_young_usage detector"
  type        = list
  default     = []
}

variable "jvm_memory_young_usage_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of jvm_memory_young_usage detector"
  type        = list
  default     = []
}

variable "jvm_memory_young_usage_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of jvm_memory_young_usage detector"
  type        = list
  default     = []
}

variable "jvm_memory_young_usage_aggregation_function" {
  description = "Aggregation function and group by for jvm_memory_young_usage detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['node_name'])"
}

variable "jvm_memory_young_usage_transformation_function" {
  description = "Transformation function for jvm_memory_young_usage detector (mean, min, max)"
  type        = string
  default     = "mean"
}

variable "jvm_memory_young_usage_transformation_window" {
  description = "Transformation window for jvm_memory_young_usage detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "10m"
}

variable "jvm_memory_young_usage_threshold_critical" {
  description = "Critical threshold for jvm_memory_young_usage detector"
  type        = number
  default     = 90
}

variable "jvm_memory_young_usage_threshold_warning" {
  description = "Warning threshold for jvm_memory_young_usage detector"
  type        = number
  default     = 80
}

# Jvm_memory_old_usage detectors

variable "jvm_memory_old_usage_disabled" {
  description = "Disable all alerting rules for jvm_memory_old_usage detector"
  type        = bool
  default     = null
}

variable "jvm_memory_old_usage_disabled_critical" {
  description = "Disable critical alerting rule for jvm_memory_old_usage detector"
  type        = bool
  default     = null
}

variable "jvm_memory_old_usage_disabled_warning" {
  description = "Disable warning alerting rule for jvm_memory_old_usage detector"
  type        = bool
  default     = null
}

variable "jvm_memory_old_usage_notifications" {
  description = "Notification recipients list for every alerting rules of jvm_memory_old_usage detector"
  type        = list
  default     = []
}

variable "jvm_memory_old_usage_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of jvm_memory_old_usage detector"
  type        = list
  default     = []
}

variable "jvm_memory_old_usage_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of jvm_memory_old_usage detector"
  type        = list
  default     = []
}

variable "jvm_memory_old_usage_aggregation_function" {
  description = "Aggregation function and group by for jvm_memory_old_usage detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['node_name'])"
}

variable "jvm_memory_old_usage_transformation_function" {
  description = "Transformation function for jvm_memory_old_usage detector (mean, min, max)"
  type        = string
  default     = "mean"
}

variable "jvm_memory_old_usage_transformation_window" {
  description = "Transformation window for jvm_memory_old_usage detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "10m"
}

variable "jvm_memory_old_usage_threshold_critical" {
  description = "Critical threshold for jvm_memory_old_usage detector"
  type        = number
  default     = 90
}

variable "jvm_memory_old_usage_threshold_warning" {
  description = "Warning threshold for jvm_memory_old_usage detector"
  type        = number
  default     = 80
}

# Jvm_gc_old_collection_latency detectors

variable "jvm_gc_old_collection_latency_disabled" {
  description = "Disable all alerting rules for jvm_gc_old_collection_latency detector"
  type        = bool
  default     = null
}

variable "jvm_gc_old_collection_latency_disabled_critical" {
  description = "Disable critical alerting rule for jvm_gc_old_collection_latency detector"
  type        = bool
  default     = null
}

variable "jvm_gc_old_collection_latency_disabled_warning" {
  description = "Disable warning alerting rule for jvm_gc_old_collection_latency detector"
  type        = bool
  default     = null
}

variable "jvm_gc_old_collection_latency_notifications" {
  description = "Notification recipients list for every alerting rules of jvm_gc_old_collection_latency detector"
  type        = list
  default     = []
}

variable "jvm_gc_old_collection_latency_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of jvm_gc_old_collection_latency detector"
  type        = list
  default     = []
}

variable "jvm_gc_old_collection_latency_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of jvm_gc_old_collection_latency detector"
  type        = list
  default     = []
}

variable "jvm_gc_old_collection_latency_aggregation_function" {
  description = "Aggregation function and group by for jvm_gc_old_collection_latency detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['node_name'])"
}

variable "jvm_gc_old_collection_latency_transformation_function" {
  description = "Transformation function for jvm_gc_old_collection_latency detector (mean, min, max)"
  type        = string
  default     = "mean"
}

variable "jvm_gc_old_collection_latency_transformation_window" {
  description = "Transformation window for jvm_gc_old_collection_latency detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "15m"
}

variable "jvm_gc_old_collection_latency_threshold_critical" {
  description = "Critical threshold for jvm_gc_old_collection_latency detector"
  type        = number
  default     = 300
}

variable "jvm_gc_old_collection_latency_threshold_warning" {
  description = "Warning threshold for jvm_gc_old_collection_latency detector"
  type        = number
  default     = 200
}

variable "jvm_gc_old_collection_latency_aperiodic_duration" {
  description = "Duration for the jvm_gc_old_collection_latency block"
  type        = string
  default     = "10m"
}

variable "jvm_gc_old_collection_latency_aperiodic_percentage" {
  description = "Percentage for the jvm_gc_old_collection_latency block"
  type        = number
  default     = 0.9
}

# Jvm_gc_young_collection_latency detectors

variable "jvm_gc_young_collection_latency_disabled" {
  description = "Disable all alerting rules for jvm_gc_young_collection_latency detector"
  type        = bool
  default     = null
}

variable "jvm_gc_young_collection_latency_disabled_critical" {
  description = "Disable critical alerting rule for jvm_gc_young_collection_latency detector"
  type        = bool
  default     = null
}

variable "jvm_gc_young_collection_latency_disabled_warning" {
  description = "Disable warning alerting rule for jvm_gc_young_collection_latency detector"
  type        = bool
  default     = null
}

variable "jvm_gc_young_collection_latency_notifications" {
  description = "Notification recipients list for every alerting rules of jvm_gc_young_collection_latency detector"
  type        = list
  default     = []
}

variable "jvm_gc_young_collection_latency_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of jvm_gc_young_collection_latency detector"
  type        = list
  default     = []
}

variable "jvm_gc_young_collection_latency_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of jvm_gc_young_collection_latency detector"
  type        = list
  default     = []
}

variable "jvm_gc_young_collection_latency_aggregation_function" {
  description = "Aggregation function and group by for jvm_gc_young_collection_latency detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['node_name'])"
}

variable "jvm_gc_young_collection_latency_transformation_function" {
  description = "Transformation function for jvm_gc_young_collection_latency detector (mean, min, max)"
  type        = string
  default     = "mean"
}

variable "jvm_gc_young_collection_latency_transformation_window" {
  description = "Transformation window for jvm_gc_young_collection_latency detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "15m"
}

variable "jvm_gc_young_collection_latency_threshold_critical" {
  description = "Critical threshold for jvm_gc_young_collection_latency detector"
  type        = number
  default     = 40
}

variable "jvm_gc_young_collection_latency_threshold_warning" {
  description = "Warning threshold for jvm_gc_young_collection_latency detector"
  type        = number
  default     = 20
}

variable "jvm_gc_young_collection_latency_aperiodic_duration" {
  description = "Duration for the jvm_gc_young_collection_latency block"
  type        = string
  default     = "10m"
}

variable "jvm_gc_young_collection_latency_aperiodic_percentage" {
  description = "Percentage for the jvm_gc_young_collection_latency block"
  type        = number
  default     = 0.9
}

# Indexing_latency detectors

variable "indexing_latency_disabled" {
  description = "Disable all alerting rules for indexing_latency detector"
  type        = bool
  default     = null
}

variable "indexing_latency_disabled_critical" {
  description = "Disable critical alerting rule for indexing_latency detector"
  type        = bool
  default     = null
}

variable "indexing_latency_disabled_warning" {
  description = "Disable warning alerting rule for indexing_latency detector"
  type        = bool
  default     = null
}

variable "indexing_latency_notifications" {
  description = "Notification recipients list for every alerting rules of indexing_latency detector"
  type        = list
  default     = []
}

variable "indexing_latency_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of indexing_latency detector"
  type        = list
  default     = []
}

variable "indexing_latency_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of indexing_latency detector"
  type        = list
  default     = []
}

variable "indexing_latency_aggregation_function" {
  description = "Aggregation function and group by for indexing_latency detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['node_name'])"
}

variable "indexing_latency_transformation_function" {
  description = "Transformation function for indexing_latency detector (mean, min, max)"
  type        = string
  default     = "mean"
}

variable "indexing_latency_transformation_window" {
  description = "Transformation window for indexing_latency detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "10m"
}

variable "indexing_latency_threshold_critical" {
  description = "Critical threshold for indexing_latency detector"
  type        = number
  default     = 30
}

variable "indexing_latency_threshold_warning" {
  description = "Warning threshold for indexing_latency detector"
  type        = number
  default     = 15
}

variable "indexing_latency_aperiodic_duration" {
  description = "Duration for the indexing_latency block"
  type        = string
  default     = "10m"
}

variable "indexing_latency_aperiodic_percentage" {
  description = "Percentage for the indexing_latency block"
  type        = number
  default     = 0.9
}

# Flush_latency detectors

variable "flush_latency_disabled" {
  description = "Disable all alerting rules for flush_latency detector"
  type        = bool
  default     = null
}

variable "flush_latency_disabled_critical" {
  description = "Disable critical alerting rule for flush_latency detector"
  type        = bool
  default     = null
}

variable "flush_latency_disabled_warning" {
  description = "Disable warning alerting rule for flush_latency detector"
  type        = bool
  default     = null
}

variable "flush_latency_notifications" {
  description = "Notification recipients list for every alerting rules of flush_latency detector"
  type        = list
  default     = []
}

variable "flush_latency_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of flush_latency detector"
  type        = list
  default     = []
}

variable "flush_latency_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of flush_latency detector"
  type        = list
  default     = []
}

variable "flush_latency_aggregation_function" {
  description = "Aggregation function and group by for flush_latency detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['node_name'])"
}

variable "flush_latency_transformation_function" {
  description = "Transformation function for flush_latency detector (mean, min, max)"
  type        = string
  default     = "mean"
}

variable "flush_latency_transformation_window" {
  description = "Transformation window for flush_latency detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "15m"
}

variable "flush_latency_threshold_critical" {
  description = "Critical threshold for flush_latency detector"
  type        = number
  default     = 150
}

variable "flush_latency_threshold_warning" {
  description = "Warning threshold for flush_latency detector"
  type        = number
  default     = 100
}

variable "flush_latency_aperiodic_duration" {
  description = "Duration for the flush_latency block"
  type        = string
  default     = "10m"
}

variable "flush_latency_aperiodic_percentage" {
  description = "Percentage for the flush_latency block"
  type        = number
  default     = 0.9
}

# Http_connections_anomaly detectors

variable "http_connections_anomaly_disabled" {
  description = "Disable all alerting rules for http_connections_anomaly detector"
  type        = bool
  default     = null
}

variable "http_connections_anomaly_disabled_critical" {
  description = "Disable critical alerting rule for http_connections_anomaly detector"
  type        = bool
  default     = null
}

variable "http_connections_anomaly_disabled_warning" {
  description = "Disable warning alerting rule for http_connections_anomaly detector"
  type        = bool
  default     = null
}

variable "http_connections_anomaly_notifications" {
  description = "Notification recipients list for every alerting rules of http_connections_anomaly detector"
  type        = list
  default     = []
}

variable "http_connections_anomaly_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of http_connections_anomaly detector"
  type        = list
  default     = []
}

variable "http_connections_anomaly_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of http_connections_anomaly detector"
  type        = list
  default     = []
}

variable "http_connections_anomaly_aggregation_function" {
  description = "Aggregation function and group by for http_connections_anomaly detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['node_name'])"
}

variable "http_connections_anomaly_transformation_function" {
  description = "Transformation function for http_connections_anomaly detector (mean, min, max)"
  type        = string
  default     = "mean"
}

variable "http_connections_anomaly_transformation_window" {
  description = "Transformation window for http_connections_anomaly detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "15m"
}

variable "http_connections_anomaly_window_to_compare" {
  description = "Length of current window (being tested for anomalous values), and historical windows (used to establish a baseline)"
  type        = string
  default     = "15m"
}

variable "http_connections_anomaly_space_between_windows" {
  description = "Time range reflecting the periodicity of the data stream"
  type        = string
  default     = "1d"
}

variable "http_connections_anomaly_num_windows" {
  description = "Number of previous periods used to define baseline, must be > 0"
  type        = number
  default     = 4
}

variable "http_connections_anomaly_fire_growth_rate_threshold" {
  description = "Change over historical norm required to fire, should be >= 0"
  type        = number
  default     = 0.2
}

variable "http_connections_anomaly_clear_growth_rate_threshold" {
  description = "Change over historical norm required to clear, should be >= 0"
  type        = number
  default     = 0.1
}

variable "http_connections_anomaly_orientation" {
  description = "Specifies whether detect fires when signal is above, below, or out-of-band (Options:  above, below, out_of_band)"
  type        = string
  default     = "above"
}

variable "http_connections_anomaly_threshold_critical" {
  description = "Critical threshold for http_connections_anomaly detector"
  type        = number
  default     = 1
}

# Search_query_latency detectors

variable "search_query_latency_disabled" {
  description = "Disable all alerting rules for search_query_latency detector"
  type        = bool
  default     = null
}

variable "search_query_latency_disabled_critical" {
  description = "Disable critical alerting rule for search_query_latency detector"
  type        = bool
  default     = null
}

variable "search_query_latency_disabled_warning" {
  description = "Disable warning alerting rule for search_query_latency detector"
  type        = bool
  default     = null
}

variable "search_query_latency_notifications" {
  description = "Notification recipients list for every alerting rules of search_query_latency detector"
  type        = list
  default     = []
}

variable "search_query_latency_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of search_query_latency detector"
  type        = list
  default     = []
}

variable "search_query_latency_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of search_query_latency detector"
  type        = list
  default     = []
}

variable "search_query_latency_aggregation_function" {
  description = "Aggregation function and group by for search_query_latency detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['node_name'])"
}

variable "search_query_latency_transformation_function" {
  description = "Transformation function for search_query_latency detector (mean, min, max)"
  type        = string
  default     = "mean"
}

variable "search_query_latency_transformation_window" {
  description = "Transformation window for search_query_latency detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "15m"
}

variable "search_query_latency_threshold_critical" {
  description = "Critical threshold for search_query_latency detector"
  type        = number
  default     = 20
}

variable "search_query_latency_threshold_warning" {
  description = "Warning threshold for search_query_latency detector"
  type        = number
  default     = 10
}

variable "search_query_latency_aperiodic_duration" {
  description = "Duration for the search_query_latency block"
  type        = string
  default     = "10m"
}

variable "search_query_latency_aperiodic_percentage" {
  description = "Percentage for the search_query_latency block"
  type        = number
  default     = 0.9
}

# Fetch_latency detectors

variable "fetch_latency_disabled" {
  description = "Disable all alerting rules for fetch_latency detector"
  type        = bool
  default     = null
}

variable "fetch_latency_disabled_critical" {
  description = "Disable critical alerting rule for fetch_latency detector"
  type        = bool
  default     = null
}

variable "fetch_latency_disabled_warning" {
  description = "Disable warning alerting rule for fetch_latency detector"
  type        = bool
  default     = null
}

variable "fetch_latency_notifications" {
  description = "Notification recipients list for every alerting rules of fetch_latency detector"
  type        = list
  default     = []
}

variable "fetch_latency_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of fetch_latency detector"
  type        = list
  default     = []
}

variable "fetch_latency_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of fetch_latency detector"
  type        = list
  default     = []
}

variable "fetch_latency_aggregation_function" {
  description = "Aggregation function and group by for fetch_latency detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['node_name'])"
}

variable "fetch_latency_transformation_function" {
  description = "Transformation function for fetch_latency detector (mean, min, max)"
  type        = string
  default     = "min"
}

variable "fetch_latency_transformation_window" {
  description = "Transformation window for fetch_latency detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "15m"
}

variable "fetch_latency_threshold_critical" {
  description = "Critical threshold for fetch_latency detector"
  type        = number
  default     = 20
}

variable "fetch_latency_threshold_warning" {
  description = "Warning threshold for fetch_latency detector"
  type        = number
  default     = 10
}

variable "fetch_latency_aperiodic_duration" {
  description = "Duration for the fetch_latency block"
  type        = string
  default     = "10m"
}

variable "fetch_latency_aperiodic_percentage" {
  description = "Percentage for the fetch_latency block"
  type        = number
  default     = 0.9
}

# Search_query_change detectors

variable "search_query_change_disabled" {
  description = "Disable all alerting rules for search_query_change detector"
  type        = bool
  default     = null
}

variable "search_query_change_disabled_critical" {
  description = "Disable critical alerting rule for search_query_change detector"
  type        = bool
  default     = null
}

variable "search_query_change_disabled_warning" {
  description = "Disable warning alerting rule for search_query_change detector"
  type        = bool
  default     = null
}

variable "search_query_change_notifications" {
  description = "Notification recipients list for every alerting rules of search_query_change detector"
  type        = list
  default     = []
}

variable "search_query_change_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of search_query_change detector"
  type        = list
  default     = []
}

variable "search_query_change_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of search_query_change detector"
  type        = list
  default     = []
}

variable "search_query_change_aggregation_function" {
  description = "Aggregation function and group by for search_query_change detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['cluster'])"
}


variable "search_query_change_timeshift" {
  description = "Time to calculate percent change over (1m, 1h, 1d)"
  type        = string
  default     = "10m"
}

variable "search_query_change_transformation_function" {
  description = "Transformation function for search_query_change detector (mean, min, max)"
  type        = string
  default     = "mean"
}

variable "search_query_change_transformation_window" {
  description = "Transformation window for search_query_change detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "10m"
}

variable "search_query_change_threshold_critical" {
  description = "Critical threshold for search_query_change detector"
  type        = number
  default     = 100
}

variable "search_query_change_threshold_warning" {
  description = "Warning threshold for search_query_change detector"
  type        = number
  default     = 75
}

variable "search_query_change_aperiodic_duration" {
  description = "Duration for the search_query_change block"
  type        = string
  default     = "10m"
}

variable "search_query_change_aperiodic_percentage" {
  description = "Percentage for the search_query_change block"
  type        = number
  default     = 0.9
}

# Fetch_change detectors

variable "fetch_change_disabled" {
  description = "Disable all alerting rules for fetch_change detector"
  type        = bool
  default     = null
}

variable "fetch_change_disabled_critical" {
  description = "Disable critical alerting rule for fetch_change detector"
  type        = bool
  default     = null
}

variable "fetch_change_disabled_warning" {
  description = "Disable warning alerting rule for fetch_change detector"
  type        = bool
  default     = null
}

variable "fetch_change_notifications" {
  description = "Notification recipients list for every alerting rules of fetch_change detector"
  type        = list
  default     = []
}

variable "fetch_change_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of fetch_change detector"
  type        = list
  default     = []
}

variable "fetch_change_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of fetch_change detector"
  type        = list
  default     = []
}

variable "fetch_change_aggregation_function" {
  description = "Aggregation function and group by for fetch_change detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['cluster'])"
}

variable "fetch_change_timeshift" {
  description = "Time to calculate percent change over (1m, 1h, 1d)"
  type        = string
  default     = "10m"
}

variable "fetch_change_transformation_function" {
  description = "Transformation function for fetch_change detector (mean, min, max)"
  type        = string
  default     = "mean"
}

variable "fetch_change_transformation_window" {
  description = "Transformation window for fetch_change detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "10m"
}

variable "fetch_change_threshold_critical" {
  description = "Critical threshold for fetch_change detector"
  type        = number
  default     = 100
}

variable "fetch_change_threshold_warning" {
  description = "Warning threshold for fetch_change detector"
  type        = number
  default     = 75
}

variable "fetch_change_aperiodic_duration" {
  description = "Duration for the fetch_change block"
  type        = string
  default     = "10m"
}

variable "fetch_change_aperiodic_percentage" {
  description = "Percentage for the fetch_change block"
  type        = number
  default     = 0.9
}

# Field_data_evictions_change detectors

variable "field_data_evictions_change_disabled" {
  description = "Disable all alerting rules for field_data_evictions_change detector"
  type        = bool
  default     = null
}

variable "field_data_evictions_change_disabled_critical" {
  description = "Disable critical alerting rule for field_data_evictions_change detector"
  type        = bool
  default     = null
}

variable "field_data_evictions_change_disabled_warning" {
  description = "Disable warning alerting rule for field_data_evictions_change detector"
  type        = bool
  default     = null
}

variable "field_data_evictions_change_notifications" {
  description = "Notification recipients list for every alerting rules of field_data_evictions_change detector"
  type        = list
  default     = []
}

variable "field_data_evictions_change_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of field_data_evictions_change detector"
  type        = list
  default     = []
}

variable "field_data_evictions_change_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of field_data_evictions_change detector"
  type        = list
  default     = []
}

variable "field_data_evictions_change_aggregation_function" {
  description = "Aggregation function and group by for field_data_evictions_change detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['node_name'])"
}

variable "field_data_evictions_change_timeshift" {
  description = "Time to calculate percent change over (1m, 1h, 1d)"
  type        = string
  default     = "15m"
}


variable "field_data_evictions_change_transformation_function" {
  description = "Transformation function for field_data_evictions_change detector (mean, min, max)"
  type        = string
  default     = "mean"
}

variable "field_data_evictions_change_transformation_window" {
  description = "Transformation window for field_data_evictions_change detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "15m"
}

variable "field_data_evictions_change_threshold_critical" {
  description = "Critical threshold for field_data_evictions_change detector"
  type        = number
  default     = 120
}

variable "field_data_evictions_change_threshold_warning" {
  description = "Warning threshold for field_data_evictions_change detector"
  type        = number
  default     = 60
}

variable "field_data_evictions_change_aperiodic_duration" {
  description = "Duration for the field_data_evictions_change block"
  type        = string
  default     = "10m"
}

variable "field_data_evictions_change_aperiodic_percentage" {
  description = "Percentage for the field_data_evictions_change block"
  type        = number
  default     = 0.9
}

# Query_cache_evictions_change detectors

variable "query_cache_evictions_change_disabled" {
  description = "Disable all alerting rules for query_cache_evictions_change detector"
  type        = bool
  default     = null
}

variable "query_cache_evictions_change_disabled_critical" {
  description = "Disable critical alerting rule for query_cache_evictions_change detector"
  type        = bool
  default     = null
}

variable "query_cache_evictions_change_disabled_warning" {
  description = "Disable warning alerting rule for query_cache_evictions_change detector"
  type        = bool
  default     = null
}

variable "query_cache_evictions_change_notifications" {
  description = "Notification recipients list for every alerting rules of query_cache_evictions_change detector"
  type        = list
  default     = []
}

variable "query_cache_evictions_change_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of query_cache_evictions_change detector"
  type        = list
  default     = []
}

variable "query_cache_evictions_change_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of query_cache_evictions_change detector"
  type        = list
  default     = []
}

variable "query_cache_evictions_change_aggregation_function" {
  description = "Aggregation function and group by for query_cache_evictions_change detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['node_name'])"
}

variable "query_cache_evictions_change_timeshift" {
  description = "Time to calculate percent change over (1m, 1h, 1d)"
  type        = string
  default     = "15m"
}

variable "query_cache_evictions_change_transformation_function" {
  description = "Transformation function for query_cache_evictions_change detector (mean, min, max)"
  type        = string
  default     = "mean"
}

variable "query_cache_evictions_change_transformation_window" {
  description = "Transformation window for query_cache_evictions_change detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "15m"
}

variable "query_cache_evictions_change_threshold_critical" {
  description = "Critical threshold for query_cache_evictions_change detector"
  type        = number
  default     = 120
}

variable "query_cache_evictions_change_threshold_warning" {
  description = "Warning threshold for query_cache_evictions_change detector"
  type        = number
  default     = 60
}

variable "query_cache_evictions_change_aperiodic_duration" {
  description = "Duration for the query_cache_evictions_change block"
  type        = string
  default     = "10m"
}

variable "query_cache_evictions_change_aperiodic_percentage" {
  description = "Percentage for the query_cache_evictions_change block"
  type        = number
  default     = 0.9
}

# Request_cache_evictions_change detectors

variable "request_cache_evictions_change_disabled" {
  description = "Disable all alerting rules for request_cache_evictions_change detector"
  type        = bool
  default     = null
}

variable "request_cache_evictions_change_disabled_critical" {
  description = "Disable critical alerting rule for request_cache_evictions_change detector"
  type        = bool
  default     = null
}

variable "request_cache_evictions_change_disabled_warning" {
  description = "Disable warning alerting rule for request_cache_evictions_change detector"
  type        = bool
  default     = null
}

variable "request_cache_evictions_change_notifications" {
  description = "Notification recipients list for every alerting rules of request_cache_evictions_change detector"
  type        = list
  default     = []
}

variable "request_cache_evictions_change_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of request_cache_evictions_change detector"
  type        = list
  default     = []
}

variable "request_cache_evictions_change_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of request_cache_evictions_change detector"
  type        = list
  default     = []
}

variable "request_cache_evictions_change_aggregation_function" {
  description = "Aggregation function and group by for request_cache_evictions_change detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['node_name'])"
}

variable "request_cache_evictions_change_timeshift" {
  description = "Time to calculate percent change over (1m, 1h, 1d)"
  type        = string
  default     = "15m"
}

variable "request_cache_evictions_change_transformation_function" {
  description = "Transformation function for request_cache_evictions_change detector (mean, min, max)"
  type        = string
  default     = "mean"
}

variable "request_cache_evictions_change_transformation_window" {
  description = "Transformation window for request_cache_evictions_change detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "15m"
}

variable "request_cache_evictions_change_threshold_critical" {
  description = "Critical threshold for request_cache_evictions_change detector"
  type        = number
  default     = 120
}

variable "request_cache_evictions_change_threshold_warning" {
  description = "Warning threshold for request_cache_evictions_change detector"
  type        = number
  default     = 60
}

variable "request_cache_evictions_change_aperiodic_duration" {
  description = "Duration for the request_cache_evictions_change block"
  type        = string
  default     = "10m"
}

variable "request_cache_evictions_change_aperiodic_percentage" {
  description = "Percentage for the request_cache_evictions_change block"
  type        = number
  default     = 0.9
}

# Task_time_in_queue_change detectors

variable "task_time_in_queue_change_disabled" {
  description = "Disable all alerting rules for task_time_in_queue_change detector"
  type        = bool
  default     = null
}

variable "task_time_in_queue_change_disabled_critical" {
  description = "Disable critical alerting rule for task_time_in_queue_change detector"
  type        = bool
  default     = null
}

variable "task_time_in_queue_change_disabled_warning" {
  description = "Disable warning alerting rule for task_time_in_queue_change detector"
  type        = bool
  default     = null
}

variable "task_time_in_queue_change_notifications" {
  description = "Notification recipients list for every alerting rules of task_time_in_queue_change detector"
  type        = list
  default     = []
}

variable "task_time_in_queue_change_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of task_time_in_queue_change detector"
  type        = list
  default     = []
}

variable "task_time_in_queue_change_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of task_time_in_queue_change detector"
  type        = list
  default     = []
}

variable "task_time_in_queue_change_aggregation_function" {
  description = "Aggregation function and group by for task_time_in_queue_change detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['cluster'])"
}

variable "task_time_in_queue_change_timeshift" {
  description = "Time to calculate percent change over (1m, 1h, 1d)"
  type        = string
  default     = "10m"
}

variable "task_time_in_queue_change_transformation_function" {
  description = "Transformation function for task_time_in_queue_change detector (mean, min, max)"
  type        = string
  default     = "mean"
}

variable "task_time_in_queue_change_transformation_window" {
  description = "Transformation window for task_time_in_queue_change detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "10m"
}

variable "task_time_in_queue_change_threshold_critical" {
  description = "Critical threshold for task_time_in_queue_change detector"
  type        = number
  default     = 200
}

variable "task_time_in_queue_change_threshold_warning" {
  description = "Warning threshold for task_time_in_queue_change detector"
  type        = number
  default     = 100
}

variable "task_time_in_queue_change_aperiodic_duration" {
  description = "Duration for the task_time_in_queue_change block"
  type        = string
  default     = "10m"
}

variable "task_time_in_queue_change_aperiodic_percentage" {
  description = "Percentage for the task_time_in_queue_change block"
  type        = number
  default     = 0.9
}
