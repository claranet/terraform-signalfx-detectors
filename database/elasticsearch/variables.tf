# Module specific

# Heartbeat detector

variable "heartbeat_disabled" {
  description = "Disable all alerting rules for heartbeat detector"
  type        = bool
  default     = null
}

variable "heartbeat_notifications" {
  description = "Notification recipients list per severity overridden for heartbeat detector"
  type        = map(list(string))
  default     = {}
}

variable "heartbeat_timeframe" {
  description = "Timeframe for heartbeat detector (i.e. \"10m\")"
  type        = string
  default     = "20m"
}

variable "heartbeat_aggregation_function" {
  description = "Aggregation function and group by for heartbeat detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

# Cluster_status detector

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

variable "cluster_status_disabled_major" {
  description = "Disable major alerting rule for cluster_status_not_green detector"
  type        = bool
  default     = null
}

variable "cluster_status_notifications" {
  description = "Notification recipients list per severity overridden for cluster_status_not_green detector"
  type        = map(list(string))
  default     = {}
}

variable "cluster_status_aggregation_function" {
  description = "Aggregation function and group by for cluster_status_not_green detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "cluster_status_transformation_function" {
  description = "Transformation function for cluster_status_not_green detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".mean(over='5m')"
}

# Cluster_initializing_shards detector

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

variable "cluster_initializing_shards_disabled_major" {
  description = "Disable major alerting rule for cluster_initializing_shards detector"
  type        = bool
  default     = null
}

variable "cluster_initializing_shards_notifications" {
  description = "Notification recipients list per severity overridden for cluster_initializing_shards detector"
  type        = map(list(string))
  default     = {}
}

variable "cluster_initializing_shards_aggregation_function" {
  description = "Aggregation function and group by for cluster_initializing_shards detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "cluster_initializing_shards_transformation_function" {
  description = "Transformation function for cluster_initializing_shards detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='15m')"
}

variable "cluster_initializing_shards_threshold_critical" {
  description = "Critical threshold for cluster_initializing_shards detector"
  type        = number
  default     = 1
}

variable "cluster_initializing_shards_threshold_major" {
  description = "Major threshold for cluster_initializing_shards detector"
  type        = number
  default     = 0
}

# Cluster_relocating_shards detector

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

variable "cluster_relocating_shards_disabled_major" {
  description = "Disable major alerting rule for cluster_relocating_shards detector"
  type        = bool
  default     = true
}

variable "cluster_relocating_shards_notifications" {
  description = "Notification recipients list per severity overridden for cluster_relocating_shards detector"
  type        = map(list(string))
  default     = {}
}

variable "cluster_relocating_shards_aggregation_function" {
  description = "Aggregation function and group by for cluster_relocating_shards detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "cluster_relocating_shards_transformation_function" {
  description = "Transformation function for cluster_relocating_shards detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='15m')"
}

variable "cluster_relocating_shards_threshold_critical" {
  description = "Critical threshold for cluster_relocating_shards detector"
  type        = number
  default     = 0
}

variable "cluster_relocating_shards_threshold_major" {
  description = "Major threshold for cluster_relocating_shards detector"
  type        = number
  default     = -1
}

# Cluster_unassigned_shards detector

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

variable "cluster_unassigned_shards_disabled_major" {
  description = "Disable major alerting rule for cluster_unassigned_shards detector"
  type        = bool
  default     = true
}

variable "cluster_unassigned_shards_notifications" {
  description = "Notification recipients list per severity overridden for cluster_unassigned_shards detector"
  type        = map(list(string))
  default     = {}
}

variable "cluster_unassigned_shards_aggregation_function" {
  description = "Aggregation function and group by for cluster_unassigned_shards detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "cluster_unassigned_shards_transformation_function" {
  description = "Transformation function for cluster_unassigned_shards detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='10m')"
}

variable "cluster_unassigned_shards_threshold_critical" {
  description = "Critical threshold for cluster_unassigned_shards detector"
  type        = number
  default     = 0
}

variable "cluster_unassigned_shards_threshold_major" {
  description = "Major threshold for cluster_unassigned_shards detector"
  type        = number
  default     = -1
}

# pending_tasks detector

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

variable "pending_tasks_disabled_major" {
  description = "Disable major alerting rule for pending_tasks detector"
  type        = bool
  default     = null
}

variable "pending_tasks_notifications" {
  description = "Notification recipients list per severity overridden for pending_tasks detector"
  type        = map(list(string))
  default     = {}
}

variable "pending_tasks_aggregation_function" {
  description = "Aggregation function and group by for pending_tasks detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "pending_tasks_transformation_function" {
  description = "Transformation function for pending_tasks detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".mean(over='15m')"
}

variable "pending_tasks_threshold_critical" {
  description = "Critical threshold for pending_tasks detector"
  type        = number
  default     = 5
}

variable "pending_tasks_threshold_major" {
  description = "Major threshold for pending_tasks detector"
  type        = number
  default     = 0
}

# Jvm_heap_memory_usage detector

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

variable "jvm_heap_memory_usage_disabled_major" {
  description = "Disable major alerting rule for jvm_heap_memory_usage detector"
  type        = bool
  default     = null
}

variable "jvm_heap_memory_usage_notifications" {
  description = "Notification recipients list per severity overridden for jvm_heap_memory_usage detector"
  type        = map(list(string))
  default     = {}
}

variable "jvm_heap_memory_usage_aggregation_function" {
  description = "Aggregation function and group by for jvm_heap_memory_usage detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "jvm_heap_memory_usage_transformation_function" {
  description = "Transformation function for jvm_heap_memory_usage detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".mean(over='5m')"
}

variable "jvm_heap_memory_usage_threshold_critical" {
  description = "Critical threshold for jvm_heap_memory_usage detector"
  type        = number
  default     = 90
}

variable "jvm_heap_memory_usage_threshold_major" {
  description = "Major threshold for jvm_heap_memory_usage detector"
  type        = number
  default     = 80
}

# cpu_usage detector

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

variable "cpu_usage_disabled_major" {
  description = "Disable major alerting rule for cpu_usage detector"
  type        = bool
  default     = null
}

variable "cpu_usage_notifications" {
  description = "Notification recipients list per severity overridden for cpu_usage detector"
  type        = map(list(string))
  default     = {}
}

variable "cpu_usage_aggregation_function" {
  description = "Aggregation function and group by for cpu_usage detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "cpu_usage_transformation_function" {
  description = "Transformation function for cpu_usage detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='30m')"
}

variable "cpu_usage_threshold_critical" {
  description = "Critical threshold for cpu_usage detector"
  type        = number
  default     = 95
}

variable "cpu_usage_threshold_major" {
  description = "Major threshold for cpu_usage detector"
  type        = number
  default     = 85
}

# file_descriptors detector

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

variable "file_descriptors_disabled_major" {
  description = "Disable major alerting rule for file_descriptors detector"
  type        = bool
  default     = null
}

variable "file_descriptors_notifications" {
  description = "Notification recipients list per severity overridden for file_descriptors detector"
  type        = map(list(string))
  default     = {}
}

variable "file_descriptors_aggregation_function" {
  description = "Aggregation function and group by for file_descriptors detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "file_descriptors_transformation_function" {
  description = "Transformation function for file_descriptors detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".max(over='15m')"
}

variable "file_descriptors_threshold_critical" {
  description = "Critical threshold for file_descriptors detector"
  type        = number
  default     = 95
}

variable "file_descriptors_threshold_major" {
  description = "Major threshold for file_descriptors detector"
  type        = number
  default     = 90
}

# Jvm_memory_young_usage detector

variable "jvm_memory_young_usage_disabled" {
  description = "Disable all alerting rules for jvm_memory_young_usage detector"
  type        = bool
  default     = null
}

variable "jvm_memory_young_usage_disabled_major" {
  description = "Disable major alerting rule for jvm_memory_young_usage detector"
  type        = bool
  default     = null
}

variable "jvm_memory_young_usage_disabled_minor" {
  description = "Disable minor alerting rule for jvm_memory_young_usage detector"
  type        = bool
  default     = null
}

variable "jvm_memory_young_usage_notifications" {
  description = "Notification recipients list per severity overridden for jvm_memory_young_usage detector"
  type        = map(list(string))
  default     = {}
}

variable "jvm_memory_young_usage_aggregation_function" {
  description = "Aggregation function and group by for jvm_memory_young_usage detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "jvm_memory_young_usage_transformation_function" {
  description = "Transformation function for jvm_memory_young_usage detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".mean(over='10m')"
}

variable "jvm_memory_young_usage_threshold_major" {
  description = "major threshold for jvm_memory_young_usage detector"
  type        = number
  default     = 90
}

variable "jvm_memory_young_usage_threshold_minor" {
  description = "minor threshold for jvm_memory_young_usage detector"
  type        = number
  default     = 80
}

# Jvm_memory_old_usage detector

variable "jvm_memory_old_usage_disabled" {
  description = "Disable all alerting rules for jvm_memory_old_usage detector"
  type        = bool
  default     = null
}

variable "jvm_memory_old_usage_disabled_major" {
  description = "Disable major alerting rule for jvm_memory_old_usage detector"
  type        = bool
  default     = null
}

variable "jvm_memory_old_usage_disabled_minor" {
  description = "Disable minor alerting rule for jvm_memory_old_usage detector"
  type        = bool
  default     = null
}

variable "jvm_memory_old_usage_notifications" {
  description = "Notification recipients list per severity overridden for jvm_memory_old_usage detector"
  type        = map(list(string))
  default     = {}
}

variable "jvm_memory_old_usage_aggregation_function" {
  description = "Aggregation function and group by for jvm_memory_old_usage detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "jvm_memory_old_usage_transformation_function" {
  description = "Transformation function for jvm_memory_old_usage detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".mean(over='10m')"
}

variable "jvm_memory_old_usage_threshold_major" {
  description = "major threshold for jvm_memory_old_usage detector"
  type        = number
  default     = 90
}

variable "jvm_memory_old_usage_threshold_minor" {
  description = "minor threshold for jvm_memory_old_usage detector"
  type        = number
  default     = 80
}

# Jvm_gc_old_collection_latency detector

variable "jvm_gc_old_collection_latency_disabled" {
  description = "Disable all alerting rules for jvm_gc_old_collection_latency detector"
  type        = bool
  default     = null
}

variable "jvm_gc_old_collection_latency_disabled_major" {
  description = "Disable major alerting rule for jvm_gc_old_collection_latency detector"
  type        = bool
  default     = null
}

variable "jvm_gc_old_collection_latency_disabled_minor" {
  description = "Disable minor alerting rule for jvm_gc_old_collection_latency detector"
  type        = bool
  default     = null
}

variable "jvm_gc_old_collection_latency_notifications" {
  description = "Notification recipients list per severity overridden for jvm_gc_old_collection_latency detector"
  type        = map(list(string))
  default     = {}
}

variable "jvm_gc_old_collection_latency_aggregation_function" {
  description = "Aggregation function and group by for jvm_gc_old_collection_latency detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "jvm_gc_old_collection_latency_transformation_function" {
  description = "Transformation function for jvm_gc_old_collection_latency detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".mean(over='15m')"
}

variable "jvm_gc_old_collection_latency_threshold_major" {
  description = "major threshold for jvm_gc_old_collection_latency detector"
  type        = number
  default     = 300
}

variable "jvm_gc_old_collection_latency_threshold_minor" {
  description = "minor threshold for jvm_gc_old_collection_latency detector"
  type        = number
  default     = 200
}

# Jvm_gc_young_collection_latency detector

variable "jvm_gc_young_collection_latency_disabled" {
  description = "Disable all alerting rules for jvm_gc_young_collection_latency detector"
  type        = bool
  default     = null
}

variable "jvm_gc_young_collection_latency_disabled_major" {
  description = "Disable major alerting rule for jvm_gc_young_collection_latency detector"
  type        = bool
  default     = null
}

variable "jvm_gc_young_collection_latency_disabled_minor" {
  description = "Disable minor alerting rule for jvm_gc_young_collection_latency detector"
  type        = bool
  default     = null
}

variable "jvm_gc_young_collection_latency_notifications" {
  description = "Notification recipients list per severity overridden for jvm_gc_young_collection_latency detector"
  type        = map(list(string))
  default     = {}
}

variable "jvm_gc_young_collection_latency_aggregation_function" {
  description = "Aggregation function and group by for jvm_gc_young_collection_latency detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "jvm_gc_young_collection_latency_transformation_function" {
  description = "Transformation function for jvm_gc_young_collection_latency detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".mean(over='15m')"
}

variable "jvm_gc_young_collection_latency_threshold_major" {
  description = "major threshold for jvm_gc_young_collection_latency detector"
  type        = number
  default     = 40
}

variable "jvm_gc_young_collection_latency_threshold_minor" {
  description = "minor threshold for jvm_gc_young_collection_latency detector"
  type        = number
  default     = 20
}

# Indexing_latency detector

variable "indexing_latency_disabled" {
  description = "Disable all alerting rules for indexing_latency detector"
  type        = bool
  default     = null
}

variable "indexing_latency_disabled_major" {
  description = "Disable major alerting rule for indexing_latency detector"
  type        = bool
  default     = null
}

variable "indexing_latency_disabled_minor" {
  description = "Disable minor alerting rule for indexing_latency detector"
  type        = bool
  default     = null
}

variable "indexing_latency_notifications" {
  description = "Notification recipients list per severity overridden for indexing_latency detector"
  type        = map(list(string))
  default     = {}
}

variable "indexing_latency_aggregation_function" {
  description = "Aggregation function and group by for indexing_latency detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "indexing_latency_transformation_function" {
  description = "Transformation function for indexing_latency detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".mean(over='15m')"
}

variable "indexing_latency_threshold_major" {
  description = "major threshold for indexing_latency detector"
  type        = number
  default     = 30
}

variable "indexing_latency_threshold_minor" {
  description = "minor threshold for indexing_latency detector"
  type        = number
  default     = 15
}

# Flush_latency detector

variable "flush_latency_disabled" {
  description = "Disable all alerting rules for flush_latency detector"
  type        = bool
  default     = null
}

variable "flush_latency_disabled_major" {
  description = "Disable major alerting rule for flush_latency detector"
  type        = bool
  default     = null
}

variable "flush_latency_disabled_minor" {
  description = "Disable minor alerting rule for flush_latency detector"
  type        = bool
  default     = null
}

variable "flush_latency_notifications" {
  description = "Notification recipients list per severity overridden for flush_latency detector"
  type        = map(list(string))
  default     = {}
}

variable "flush_latency_aggregation_function" {
  description = "Aggregation function and group by for flush_latency detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "flush_latency_transformation_function" {
  description = "Transformation function for flush_latency detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".mean(over='15m')"
}

variable "flush_latency_threshold_major" {
  description = "major threshold for flush_latency detector"
  type        = number
  default     = 150
}

variable "flush_latency_threshold_minor" {
  description = "minor threshold for flush_latency detector"
  type        = number
  default     = 100
}

# Search_latency detector

variable "search_latency_disabled" {
  description = "Disable all alerting rules for search_latency detector"
  type        = bool
  default     = null
}

variable "search_latency_disabled_major" {
  description = "Disable major alerting rule for search_latency detector"
  type        = bool
  default     = null
}

variable "search_latency_disabled_minor" {
  description = "Disable minor alerting rule for search_latency detector"
  type        = bool
  default     = null
}

variable "search_latency_notifications" {
  description = "Notification recipients list per severity overridden for search_latency detector"
  type        = map(list(string))
  default     = {}
}

variable "search_latency_aggregation_function" {
  description = "Aggregation function and group by for search_latency detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "search_latency_transformation_function" {
  description = "Transformation function for search_latency detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='30m')"
}

variable "search_latency_threshold_major" {
  description = "major threshold for search_latency detector"
  type        = number
  default     = 20
}

variable "search_latency_threshold_minor" {
  description = "minor threshold for search_latency detector"
  type        = number
  default     = 10
}

# Fetch_latency detector

variable "fetch_latency_disabled" {
  description = "Disable all alerting rules for fetch_latency detector"
  type        = bool
  default     = null
}

variable "fetch_latency_disabled_major" {
  description = "Disable major alerting rule for fetch_latency detector"
  type        = bool
  default     = null
}

variable "fetch_latency_disabled_minor" {
  description = "Disable minor alerting rule for fetch_latency detector"
  type        = bool
  default     = null
}

variable "fetch_latency_notifications" {
  description = "Notification recipients list per severity overridden for fetch_latency detector"
  type        = map(list(string))
  default     = {}
}

variable "fetch_latency_aggregation_function" {
  description = "Aggregation function and group by for fetch_latency detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "fetch_latency_transformation_function" {
  description = "Transformation function for fetch_latency detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='15m')"
}

variable "fetch_latency_threshold_major" {
  description = "major threshold for fetch_latency detector"
  type        = number
  default     = 20
}

variable "fetch_latency_threshold_minor" {
  description = "minor threshold for fetch_latency detector"
  type        = number
  default     = 10
}

# Field_data_evictions_change detector

variable "field_data_evictions_change_disabled" {
  description = "Disable all alerting rules for field_data_evictions_change detector"
  type        = bool
  default     = null
}

variable "field_data_evictions_change_disabled_major" {
  description = "Disable major alerting rule for field_data_evictions_change detector"
  type        = bool
  default     = null
}

variable "field_data_evictions_change_disabled_minor" {
  description = "Disable minor alerting rule for field_data_evictions_change detector"
  type        = bool
  default     = null
}

variable "field_data_evictions_change_notifications" {
  description = "Notification recipients list per severity overridden for field_data_evictions_change detector"
  type        = map(list(string))
  default     = {}
}

variable "field_data_evictions_change_aggregation_function" {
  description = "Aggregation function and group by for field_data_evictions_change detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "field_data_evictions_change_transformation_function" {
  description = "Transformation function for field_data_evictions_change detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".mean(over='15m')"
}

variable "field_data_evictions_change_threshold_major" {
  description = "major threshold for field_data_evictions_change detector"
  type        = number
  default     = 120
}

variable "field_data_evictions_change_threshold_minor" {
  description = "minor threshold for field_data_evictions_change detector"
  type        = number
  default     = 60
}

# Task_time_in_queue_change detector

variable "task_time_in_queue_change_disabled" {
  description = "Disable all alerting rules for task_time_in_queue_change detector"
  type        = bool
  default     = null
}

variable "task_time_in_queue_change_disabled_major" {
  description = "Disable major alerting rule for task_time_in_queue_change detector"
  type        = bool
  default     = null
}

variable "task_time_in_queue_change_disabled_minor" {
  description = "Disable minor alerting rule for task_time_in_queue_change detector"
  type        = bool
  default     = null
}

variable "task_time_in_queue_change_notifications" {
  description = "Notification recipients list per severity overridden for task_time_in_queue_change detector"
  type        = map(list(string))
  default     = {}
}

variable "task_time_in_queue_change_aggregation_function" {
  description = "Aggregation function and group by for task_time_in_queue_change detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "task_time_in_queue_change_transformation_function" {
  description = "Transformation function for task_time_in_queue_change detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".mean(over='15m')"
}

variable "task_time_in_queue_change_threshold_major" {
  description = "major threshold for task_time_in_queue_change detector"
  type        = number
  default     = 200
}

variable "task_time_in_queue_change_threshold_minor" {
  description = "minor threshold for task_time_in_queue_change detector"
  type        = number
  default     = 100
}

