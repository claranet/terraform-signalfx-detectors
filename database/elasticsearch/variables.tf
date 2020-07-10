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

# Cluster_status detectors

variable "cluster_status_disabled" {
  description = "Disable all alerting rules for cluster_status_not_green detector"
  type        = bool
  default     = null
}

variable "cluster_status_disabled_critical" {
  description = "Disable critical alerting rule for cluster_status_not_green detector"
  type        = bool
  default     = null
}

variable "cluster_status_disabled_warning" {
  description = "Disable warning alerting rule for cluster_status_not_green detector"
  type        = bool
  default     = null
}

variable "cluster_status_notifications" {
  description = "Notification recipients list for every alerting rules of cluster_status_not_green detector"
  type        = list
  default     = []
}

variable "cluster_status_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of cluster_status_not_green detector"
  type        = list
  default     = []
}

variable "cluster_status_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of cluster_status_not_green detector"
  type        = list
  default     = []
}

variable "cluster_status_aggregation_function" {
  description = "Aggregation function and group by for cluster_status_not_green detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "cluster_status_transformation_function" {
  description = "Transformation function for cluster_status_not_green detector (i.e. \".mean(over='5m')\"))"
  type        = string
  default     = ".mean(over='5m')"
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
  default     = ""
}

variable "cluster_initializing_shards_transformation_function" {
  description = "Transformation function for cluster_initializing_shards detector (i.e. \".mean(over='5m')\"))"
  type        = string
  default     = ".min(over='15m')"
}

variable "cluster_initializing_shards_threshold_critical" {
  description = "Critical threshold for cluster_initializing_shards detector"
  type        = number
  default     = 1
}

variable "cluster_initializing_shards_threshold_warning" {
  description = "Warning threshold for cluster_initializing_shards detector"
  type        = number
  default     = 0
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
  default     = true
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
  default     = ""
}

variable "cluster_relocating_shards_transformation_function" {
  description = "Transformation function for cluster_relocating_shards detector (i.e. \".mean(over='5m')\"))"
  type        = string
  default     = ".min(over='15m')"
}

variable "cluster_relocating_shards_threshold_critical" {
  description = "Critical threshold for cluster_relocating_shards detector"
  type        = number
  default     = 0
}

variable "cluster_relocating_shards_threshold_warning" {
  description = "Warning threshold for cluster_relocating_shards detector"
  type        = number
  default     = -1
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
  default     = true
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
  default     = ""
}

variable "cluster_unassigned_shards_transformation_function" {
  description = "Transformation function for cluster_unassigned_shards detector (i.e. \".mean(over='5m')\"))"
  type        = string
  default     = ".min(over='10m')"
}

variable "cluster_unassigned_shards_threshold_critical" {
  description = "Critical threshold for cluster_unassigned_shards detector"
  type        = number
  default     = 0
}

variable "cluster_unassigned_shards_threshold_warning" {
  description = "Warning threshold for cluster_unassigned_shards detector"
  type        = number
  default     = -1
}

# pending_tasks detectors

variable "pending_tasks_disabled" {
  description = "Disable all alerting rules for pending_tasks detector"
  type        = bool
  default     = null
}

variable "pending_tasks_disabled_critical" {
  description = "Disable critical alerting rule for pending_tasks detector"
  type        = bool
  default     = null
}

variable "pending_tasks_disabled_warning" {
  description = "Disable warning alerting rule for pending_tasks detector"
  type        = bool
  default     = null
}

variable "pending_tasks_notifications" {
  description = "Notification recipients list for every alerting rules of pending_tasks detector"
  type        = list
  default     = []
}

variable "pending_tasks_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of pending_tasks detector"
  type        = list
  default     = []
}

variable "pending_tasks_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of pending_tasks detector"
  type        = list
  default     = []
}

variable "pending_tasks_aggregation_function" {
  description = "Aggregation function and group by for pending_tasks detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "pending_tasks_transformation_function" {
  description = "Transformation function for pending_tasks detector (i.e. \".mean(over='5m')\"))"
  type        = string
  default     = ".mean(over='15m')"
}

variable "pending_tasks_threshold_critical" {
  description = "Critical threshold for pending_tasks detector"
  type        = number
  default     = 5
}

variable "pending_tasks_threshold_warning" {
  description = "Warning threshold for pending_tasks detector"
  type        = number
  default     = 0
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
  default     = ""
}

variable "jvm_heap_memory_usage_transformation_function" {
  description = "Transformation function for jvm_heap_memory_usage detector (i.e. \".mean(over='5m')\"))"
  type        = string
  default     = ".mean(over='5m')"
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

# cpu_usage detectors

variable "cpu_usage_disabled" {
  description = "Disable all alerting rules for cpu_usage detector"
  type        = bool
  default     = null
}

variable "cpu_usage_disabled_critical" {
  description = "Disable critical alerting rule for cpu_usage detector"
  type        = bool
  default     = null
}

variable "cpu_usage_disabled_warning" {
  description = "Disable warning alerting rule for cpu_usage detector"
  type        = bool
  default     = null
}

variable "cpu_usage_notifications" {
  description = "Notification recipients list for every alerting rules of cpu_usage detector"
  type        = list
  default     = []
}

variable "cpu_usage_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of cpu_usage detector"
  type        = list
  default     = []
}

variable "cpu_usage_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of cpu_usage detector"
  type        = list
  default     = []
}

variable "cpu_usage_aggregation_function" {
  description = "Aggregation function and group by for cpu_usage detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "cpu_usage_transformation_function" {
  description = "Transformation function for cpu_usage detector (i.e. \".mean(over='5m')\"))"
  type        = string
  default     = ".min(over='30m')"
}

variable "cpu_usage_threshold_critical" {
  description = "Critical threshold for cpu_usage detector"
  type        = number
  default     = 95
}

variable "cpu_usage_threshold_warning" {
  description = "Warning threshold for cpu_usage detector"
  type        = number
  default     = 85
}

# file_descriptors detectors

variable "file_descriptors_disabled" {
  description = "Disable all alerting rules for file_descriptors detector"
  type        = bool
  default     = null
}

variable "file_descriptors_disabled_critical" {
  description = "Disable critical alerting rule for file_descriptors detector"
  type        = bool
  default     = null
}

variable "file_descriptors_disabled_warning" {
  description = "Disable warning alerting rule for file_descriptors detector"
  type        = bool
  default     = null
}

variable "file_descriptors_notifications" {
  description = "Notification recipients list for every alerting rules of file_descriptors detector"
  type        = list
  default     = []
}

variable "file_descriptors_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of file_descriptors detector"
  type        = list
  default     = []
}

variable "file_descriptors_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of file_descriptors detector"
  type        = list
  default     = []
}

variable "file_descriptors_aggregation_function" {
  description = "Aggregation function and group by for file_descriptors detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "file_descriptors_transformation_function" {
  description = "Transformation function for file_descriptors detector (i.e. \".mean(over='5m')\"))"
  type        = string
  default     = ".max(over='15m')"
}

variable "file_descriptors_threshold_critical" {
  description = "Critical threshold for file_descriptors detector"
  type        = number
  default     = 95
}

variable "file_descriptors_threshold_warning" {
  description = "Warning threshold for file_descriptors detector"
  type        = number
  default     = 90
}

# Jvm_memory_young_usage detectors

variable "jvm_memory_young_usage_disabled" {
  description = "Disable all alerting rules for jvm_memory_young_usage detector"
  type        = bool
  default     = null
}

variable "jvm_memory_young_usage_disabled_warning" {
  description = "Disable warning alerting rule for jvm_memory_young_usage detector"
  type        = bool
  default     = null
}

variable "jvm_memory_young_usage_disabled_major" {
  description = "Disable major alerting rule for jvm_memory_young_usage detector"
  type        = bool
  default     = null
}

variable "jvm_memory_young_usage_notifications" {
  description = "Notification recipients list for every alerting rules of jvm_memory_young_usage detector"
  type        = list
  default     = []
}

variable "jvm_memory_young_usage_notifications_major" {
  description = "Notification recipients list for major alerting rule of jvm_memory_young_usage detector"
  type        = list
  default     = []
}

variable "jvm_memory_young_usage_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of jvm_memory_young_usage detector"
  type        = list
  default     = []
}

variable "jvm_memory_young_usage_aggregation_function" {
  description = "Aggregation function and group by for jvm_memory_young_usage detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "jvm_memory_young_usage_transformation_function" {
  description = "Transformation function for jvm_memory_young_usage detector (i.e. \".mean(over='5m')\"))"
  type        = string
  default     = ".mean(over='10m')"
}

variable "jvm_memory_young_usage_threshold_warning" {
  description = "warning threshold for jvm_memory_young_usage detector"
  type        = number
  default     = 90
}

variable "jvm_memory_young_usage_threshold_major" {
  description = "major threshold for jvm_memory_young_usage detector"
  type        = number
  default     = 80
}

# Jvm_memory_old_usage detectors

variable "jvm_memory_old_usage_disabled" {
  description = "Disable all alerting rules for jvm_memory_old_usage detector"
  type        = bool
  default     = null
}

variable "jvm_memory_old_usage_disabled_warning" {
  description = "Disable warning alerting rule for jvm_memory_old_usage detector"
  type        = bool
  default     = null
}

variable "jvm_memory_old_usage_disabled_major" {
  description = "Disable major alerting rule for jvm_memory_old_usage detector"
  type        = bool
  default     = null
}

variable "jvm_memory_old_usage_notifications" {
  description = "Notification recipients list for every alerting rules of jvm_memory_old_usage detector"
  type        = list
  default     = []
}

variable "jvm_memory_old_usage_notifications_major" {
  description = "Notification recipients list for major alerting rule of jvm_memory_old_usage detector"
  type        = list
  default     = []
}

variable "jvm_memory_old_usage_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of jvm_memory_old_usage detector"
  type        = list
  default     = []
}

variable "jvm_memory_old_usage_aggregation_function" {
  description = "Aggregation function and group by for jvm_memory_old_usage detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "jvm_memory_old_usage_transformation_function" {
  description = "Transformation function for jvm_memory_old_usage detector (i.e. \".mean(over='5m')\"))"
  type        = string
  default     = ".mean(over='10m')"
}

variable "jvm_memory_old_usage_threshold_warning" {
  description = "warning threshold for jvm_memory_old_usage detector"
  type        = number
  default     = 90
}

variable "jvm_memory_old_usage_threshold_major" {
  description = "major threshold for jvm_memory_old_usage detector"
  type        = number
  default     = 80
}

# Jvm_gc_old_collection_latency detectors

variable "jvm_gc_old_collection_latency_disabled" {
  description = "Disable all alerting rules for jvm_gc_old_collection_latency detector"
  type        = bool
  default     = null
}

variable "jvm_gc_old_collection_latency_disabled_warning" {
  description = "Disable warning alerting rule for jvm_gc_old_collection_latency detector"
  type        = bool
  default     = null
}

variable "jvm_gc_old_collection_latency_disabled_major" {
  description = "Disable major alerting rule for jvm_gc_old_collection_latency detector"
  type        = bool
  default     = null
}

variable "jvm_gc_old_collection_latency_notifications" {
  description = "Notification recipients list for every alerting rules of jvm_gc_old_collection_latency detector"
  type        = list
  default     = []
}

variable "jvm_gc_old_collection_latency_notifications_major" {
  description = "Notification recipients list for major alerting rule of jvm_gc_old_collection_latency detector"
  type        = list
  default     = []
}

variable "jvm_gc_old_collection_latency_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of jvm_gc_old_collection_latency detector"
  type        = list
  default     = []
}

variable "jvm_gc_old_collection_latency_aggregation_function" {
  description = "Aggregation function and group by for jvm_gc_old_collection_latency detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "jvm_gc_old_collection_latency_transformation_function" {
  description = "Transformation function for jvm_gc_old_collection_latency detector (i.e. \".mean(over='5m')\"))"
  type        = string
  default     = ".mean(over='15m')"
}

variable "jvm_gc_old_collection_latency_threshold_warning" {
  description = "warning threshold for jvm_gc_old_collection_latency detector"
  type        = number
  default     = 300
}

variable "jvm_gc_old_collection_latency_threshold_major" {
  description = "major threshold for jvm_gc_old_collection_latency detector"
  type        = number
  default     = 200
}

# Jvm_gc_young_collection_latency detectors

variable "jvm_gc_young_collection_latency_disabled" {
  description = "Disable all alerting rules for jvm_gc_young_collection_latency detector"
  type        = bool
  default     = null
}

variable "jvm_gc_young_collection_latency_disabled_warning" {
  description = "Disable warning alerting rule for jvm_gc_young_collection_latency detector"
  type        = bool
  default     = null
}

variable "jvm_gc_young_collection_latency_disabled_major" {
  description = "Disable major alerting rule for jvm_gc_young_collection_latency detector"
  type        = bool
  default     = null
}

variable "jvm_gc_young_collection_latency_notifications" {
  description = "Notification recipients list for every alerting rules of jvm_gc_young_collection_latency detector"
  type        = list
  default     = []
}

variable "jvm_gc_young_collection_latency_notifications_major" {
  description = "Notification recipients list for major alerting rule of jvm_gc_young_collection_latency detector"
  type        = list
  default     = []
}

variable "jvm_gc_young_collection_latency_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of jvm_gc_young_collection_latency detector"
  type        = list
  default     = []
}

variable "jvm_gc_young_collection_latency_aggregation_function" {
  description = "Aggregation function and group by for jvm_gc_young_collection_latency detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "jvm_gc_young_collection_latency_transformation_function" {
  description = "Transformation function for jvm_gc_young_collection_latency detector (i.e. \".mean(over='5m')\"))"
  type        = string
  default     = ".mean(over='15m')"
}

variable "jvm_gc_young_collection_latency_threshold_warning" {
  description = "warning threshold for jvm_gc_young_collection_latency detector"
  type        = number
  default     = 40
}

variable "jvm_gc_young_collection_latency_threshold_major" {
  description = "major threshold for jvm_gc_young_collection_latency detector"
  type        = number
  default     = 20
}

# Indexing_latency detectors

variable "indexing_latency_disabled" {
  description = "Disable all alerting rules for indexing_latency detector"
  type        = bool
  default     = null
}

variable "indexing_latency_disabled_warning" {
  description = "Disable warning alerting rule for indexing_latency detector"
  type        = bool
  default     = null
}

variable "indexing_latency_disabled_major" {
  description = "Disable major alerting rule for indexing_latency detector"
  type        = bool
  default     = null
}

variable "indexing_latency_notifications" {
  description = "Notification recipients list for every alerting rules of indexing_latency detector"
  type        = list
  default     = []
}

variable "indexing_latency_notifications_major" {
  description = "Notification recipients list for major alerting rule of indexing_latency detector"
  type        = list
  default     = []
}

variable "indexing_latency_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of indexing_latency detector"
  type        = list
  default     = []
}

variable "indexing_latency_aggregation_function" {
  description = "Aggregation function and group by for indexing_latency detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "indexing_latency_transformation_function" {
  description = "Transformation function for indexing_latency detector (i.e. \".mean(over='5m')\"))"
  type        = string
  default     = ".mean(over='15m')"
}

variable "indexing_latency_threshold_warning" {
  description = "warning threshold for indexing_latency detector"
  type        = number
  default     = 30
}

variable "indexing_latency_threshold_major" {
  description = "major threshold for indexing_latency detector"
  type        = number
  default     = 15
}

# Flush_latency detectors

variable "flush_latency_disabled" {
  description = "Disable all alerting rules for flush_latency detector"
  type        = bool
  default     = null
}

variable "flush_latency_disabled_warning" {
  description = "Disable warning alerting rule for flush_latency detector"
  type        = bool
  default     = null
}

variable "flush_latency_disabled_major" {
  description = "Disable major alerting rule for flush_latency detector"
  type        = bool
  default     = null
}

variable "flush_latency_notifications" {
  description = "Notification recipients list for every alerting rules of flush_latency detector"
  type        = list
  default     = []
}

variable "flush_latency_notifications_major" {
  description = "Notification recipients list for major alerting rule of flush_latency detector"
  type        = list
  default     = []
}

variable "flush_latency_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of flush_latency detector"
  type        = list
  default     = []
}

variable "flush_latency_aggregation_function" {
  description = "Aggregation function and group by for flush_latency detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "flush_latency_transformation_function" {
  description = "Transformation function for flush_latency detector (i.e. \".mean(over='5m')\"))"
  type        = string
  default     = ".mean(over='15m')"
}

variable "flush_latency_threshold_warning" {
  description = "warning threshold for flush_latency detector"
  type        = number
  default     = 150
}

variable "flush_latency_threshold_major" {
  description = "major threshold for flush_latency detector"
  type        = number
  default     = 100
}

# Search_latency detectors

variable "search_latency_disabled" {
  description = "Disable all alerting rules for search_latency detector"
  type        = bool
  default     = null
}

variable "search_latency_disabled_warning" {
  description = "Disable warning alerting rule for search_latency detector"
  type        = bool
  default     = null
}

variable "search_latency_disabled_major" {
  description = "Disable major alerting rule for search_latency detector"
  type        = bool
  default     = null
}

variable "search_latency_notifications" {
  description = "Notification recipients list for every alerting rules of search_latency detector"
  type        = list
  default     = []
}

variable "search_latency_notifications_major" {
  description = "Notification recipients list for major alerting rule of search_latency detector"
  type        = list
  default     = []
}

variable "search_latency_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of search_latency detector"
  type        = list
  default     = []
}

variable "search_latency_aggregation_function" {
  description = "Aggregation function and group by for search_latency detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "search_latency_transformation_function" {
  description = "Transformation function for search_latency detector (i.e. \".mean(over='5m')\"))"
  type        = string
  default     = ".mean(over='15m')"
}

variable "search_latency_threshold_warning" {
  description = "warning threshold for search_latency detector"
  type        = number
  default     = 20
}

variable "search_latency_threshold_major" {
  description = "major threshold for search_latency detector"
  type        = number
  default     = 10
}

# Fetch_latency detectors

variable "fetch_latency_disabled" {
  description = "Disable all alerting rules for fetch_latency detector"
  type        = bool
  default     = null
}

variable "fetch_latency_disabled_warning" {
  description = "Disable warning alerting rule for fetch_latency detector"
  type        = bool
  default     = null
}

variable "fetch_latency_disabled_major" {
  description = "Disable major alerting rule for fetch_latency detector"
  type        = bool
  default     = null
}

variable "fetch_latency_notifications" {
  description = "Notification recipients list for every alerting rules of fetch_latency detector"
  type        = list
  default     = []
}

variable "fetch_latency_notifications_major" {
  description = "Notification recipients list for major alerting rule of fetch_latency detector"
  type        = list
  default     = []
}

variable "fetch_latency_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of fetch_latency detector"
  type        = list
  default     = []
}

variable "fetch_latency_aggregation_function" {
  description = "Aggregation function and group by for fetch_latency detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "fetch_latency_transformation_function" {
  description = "Transformation function for fetch_latency detector (i.e. \".mean(over='5m')\"))"
  type        = string
  default     = ".min(over='15m')"
}

variable "fetch_latency_threshold_warning" {
  description = "warning threshold for fetch_latency detector"
  type        = number
  default     = 20
}

variable "fetch_latency_threshold_major" {
  description = "major threshold for fetch_latency detector"
  type        = number
  default     = 10
}

# Field_data_evictions_change detectors

variable "field_data_evictions_change_disabled" {
  description = "Disable all alerting rules for field_data_evictions_change detector"
  type        = bool
  default     = null
}

variable "field_data_evictions_change_disabled_warning" {
  description = "Disable warning alerting rule for field_data_evictions_change detector"
  type        = bool
  default     = null
}

variable "field_data_evictions_change_disabled_major" {
  description = "Disable major alerting rule for field_data_evictions_change detector"
  type        = bool
  default     = null
}

variable "field_data_evictions_change_notifications" {
  description = "Notification recipients list for every alerting rules of field_data_evictions_change detector"
  type        = list
  default     = []
}

variable "field_data_evictions_change_notifications_major" {
  description = "Notification recipients list for major alerting rule of field_data_evictions_change detector"
  type        = list
  default     = []
}

variable "field_data_evictions_change_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of field_data_evictions_change detector"
  type        = list
  default     = []
}

variable "field_data_evictions_change_aggregation_function" {
  description = "Aggregation function and group by for field_data_evictions_change detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "field_data_evictions_change_transformation_function" {
  description = "Transformation function for field_data_evictions_change detector (i.e. \".mean(over='5m')\"))"
  type        = string
  default     = ".mean(over='15m')"
}

variable "field_data_evictions_change_threshold_warning" {
  description = "warning threshold for field_data_evictions_change detector"
  type        = number
  default     = 120
}

variable "field_data_evictions_change_threshold_major" {
  description = "major threshold for field_data_evictions_change detector"
  type        = number
  default     = 60
}

# Query_cache_evictions_change detectors

variable "query_cache_evictions_change_disabled" {
  description = "Disable all alerting rules for query_cache_evictions_change detector"
  type        = bool
  default     = null
}

variable "query_cache_evictions_change_disabled_warning" {
  description = "Disable warning alerting rule for query_cache_evictions_change detector"
  type        = bool
  default     = null
}

variable "query_cache_evictions_change_disabled_major" {
  description = "Disable major alerting rule for query_cache_evictions_change detector"
  type        = bool
  default     = null
}

variable "query_cache_evictions_change_notifications" {
  description = "Notification recipients list for every alerting rules of query_cache_evictions_change detector"
  type        = list
  default     = []
}

variable "query_cache_evictions_change_notifications_major" {
  description = "Notification recipients list for major alerting rule of query_cache_evictions_change detector"
  type        = list
  default     = []
}

variable "query_cache_evictions_change_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of query_cache_evictions_change detector"
  type        = list
  default     = []
}

variable "query_cache_evictions_change_aggregation_function" {
  description = "Aggregation function and group by for query_cache_evictions_change detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "query_cache_evictions_change_transformation_function" {
  description = "Transformation function for query_cache_evictions_change detector (i.e. \".mean(over='5m')\"))"
  type        = string
  default     = ".mean(over='15m')"
}

variable "query_cache_evictions_change_threshold_warning" {
  description = "warning threshold for query_cache_evictions_change detector"
  type        = number
  default     = 120
}

variable "query_cache_evictions_change_threshold_major" {
  description = "major threshold for query_cache_evictions_change detector"
  type        = number
  default     = 60
}

# Request_cache_evictions_change detectors

variable "request_cache_evictions_change_disabled" {
  description = "Disable all alerting rules for request_cache_evictions_change detector"
  type        = bool
  default     = null
}

variable "request_cache_evictions_change_disabled_warning" {
  description = "Disable warning alerting rule for request_cache_evictions_change detector"
  type        = bool
  default     = null
}

variable "request_cache_evictions_change_disabled_major" {
  description = "Disable major alerting rule for request_cache_evictions_change detector"
  type        = bool
  default     = null
}

variable "request_cache_evictions_change_notifications" {
  description = "Notification recipients list for every alerting rules of request_cache_evictions_change detector"
  type        = list
  default     = []
}

variable "request_cache_evictions_change_notifications_major" {
  description = "Notification recipients list for major alerting rule of request_cache_evictions_change detector"
  type        = list
  default     = []
}

variable "request_cache_evictions_change_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of request_cache_evictions_change detector"
  type        = list
  default     = []
}

variable "request_cache_evictions_change_aggregation_function" {
  description = "Aggregation function and group by for request_cache_evictions_change detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "request_cache_evictions_change_transformation_function" {
  description = "Transformation function for request_cache_evictions_change detector (i.e. \".mean(over='5m')\"))"
  type        = string
  default     = ".mean(over='15m')"
}

variable "request_cache_evictions_change_threshold_warning" {
  description = "warning threshold for request_cache_evictions_change detector"
  type        = number
  default     = 120
}

variable "request_cache_evictions_change_threshold_major" {
  description = "major threshold for request_cache_evictions_change detector"
  type        = number
  default     = 60
}

# Task_time_in_queue_change detectors

variable "task_time_in_queue_change_disabled" {
  description = "Disable all alerting rules for task_time_in_queue_change detector"
  type        = bool
  default     = null
}

variable "task_time_in_queue_change_disabled_warning" {
  description = "Disable warning alerting rule for task_time_in_queue_change detector"
  type        = bool
  default     = null
}

variable "task_time_in_queue_change_disabled_major" {
  description = "Disable major alerting rule for task_time_in_queue_change detector"
  type        = bool
  default     = null
}

variable "task_time_in_queue_change_notifications" {
  description = "Notification recipients list for every alerting rules of task_time_in_queue_change detector"
  type        = list
  default     = []
}

variable "task_time_in_queue_change_notifications_major" {
  description = "Notification recipients list for major alerting rule of task_time_in_queue_change detector"
  type        = list
  default     = []
}

variable "task_time_in_queue_change_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of task_time_in_queue_change detector"
  type        = list
  default     = []
}

variable "task_time_in_queue_change_aggregation_function" {
  description = "Aggregation function and group by for task_time_in_queue_change detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "task_time_in_queue_change_transformation_function" {
  description = "Transformation function for task_time_in_queue_change detector (i.e. \".mean(over='5m')\"))"
  type        = string
  default     = ".mean(over='15m')"
}

variable "task_time_in_queue_change_threshold_warning" {
  description = "warning threshold for task_time_in_queue_change detector"
  type        = number
  default     = 200
}

variable "task_time_in_queue_change_threshold_major" {
  description = "major threshold for task_time_in_queue_change detector"
  type        = number
  default     = 100
}

