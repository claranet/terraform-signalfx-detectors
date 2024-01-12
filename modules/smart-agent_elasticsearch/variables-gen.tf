# heartbeat detector

variable "heartbeat_notifications" {
  description = "Notification recipients list per severity overridden for heartbeat detector"
  type        = map(list(string))
  default     = {}
}

variable "heartbeat_aggregation_function" {
  description = "Aggregation function and group by for heartbeat detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['cluster'])"
}

variable "heartbeat_max_delay" {
  description = "Enforce max delay for heartbeat detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = 900
}

variable "heartbeat_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "heartbeat_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "heartbeat_disabled" {
  description = "Disable all alerting rules for heartbeat detector"
  type        = bool
  default     = null
}

variable "heartbeat_timeframe" {
  description = "Timeframe for heartbeat detector (i.e. \"10m\")"
  type        = string
  default     = "10m"
}

# cluster_status detector

variable "cluster_status_notifications" {
  description = "Notification recipients list per severity overridden for cluster_status detector"
  type        = map(list(string))
  default     = {}
}

variable "cluster_status_aggregation_function" {
  description = "Aggregation function and group by for cluster_status detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".max(by=['cluster'])"
}

variable "cluster_status_transformation_function" {
  description = "Transformation function for cluster_status detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "cluster_status_max_delay" {
  description = "Enforce max delay for cluster_status detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "cluster_status_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "cluster_status_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "cluster_status_disabled" {
  description = "Disable all alerting rules for cluster_status detector"
  type        = bool
  default     = null
}

variable "cluster_status_disabled_critical" {
  description = "Disable critical alerting rule for cluster_status detector"
  type        = bool
  default     = null
}

variable "cluster_status_disabled_major" {
  description = "Disable major alerting rule for cluster_status detector"
  type        = bool
  default     = null
}

variable "cluster_status_threshold_critical" {
  description = "Critical threshold for cluster_status detector"
  type        = number
  default     = 2
}

variable "cluster_status_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "5m"
}

variable "cluster_status_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "cluster_status_threshold_major" {
  description = "Major threshold for cluster_status detector"
  type        = number
  default     = 1
}

variable "cluster_status_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "5m"
}

variable "cluster_status_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# cluster_initializing_shards detector

variable "cluster_initializing_shards_notifications" {
  description = "Notification recipients list per severity overridden for cluster_initializing_shards detector"
  type        = map(list(string))
  default     = {}
}

variable "cluster_initializing_shards_aggregation_function" {
  description = "Aggregation function and group by for cluster_initializing_shards detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".max(by=['cluster'])"
}

variable "cluster_initializing_shards_transformation_function" {
  description = "Transformation function for cluster_initializing_shards detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "cluster_initializing_shards_max_delay" {
  description = "Enforce max delay for cluster_initializing_shards detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "cluster_initializing_shards_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "cluster_initializing_shards_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

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

variable "cluster_initializing_shards_threshold_critical" {
  description = "Critical threshold for cluster_initializing_shards detector"
  type        = number
  default     = 1
}

variable "cluster_initializing_shards_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "15m"
}

variable "cluster_initializing_shards_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "cluster_initializing_shards_threshold_major" {
  description = "Major threshold for cluster_initializing_shards detector"
  type        = number
  default     = 0
}

variable "cluster_initializing_shards_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "15m"
}

variable "cluster_initializing_shards_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# cluster_relocating_shards detector

variable "cluster_relocating_shards_notifications" {
  description = "Notification recipients list per severity overridden for cluster_relocating_shards detector"
  type        = map(list(string))
  default     = {}
}

variable "cluster_relocating_shards_aggregation_function" {
  description = "Aggregation function and group by for cluster_relocating_shards detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".max(by=['cluster'])"
}

variable "cluster_relocating_shards_transformation_function" {
  description = "Transformation function for cluster_relocating_shards detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "cluster_relocating_shards_max_delay" {
  description = "Enforce max delay for cluster_relocating_shards detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "cluster_relocating_shards_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "cluster_relocating_shards_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "cluster_relocating_shards_disabled" {
  description = "Disable all alerting rules for cluster_relocating_shards detector"
  type        = bool
  default     = null
}

variable "cluster_relocating_shards_threshold_critical" {
  description = "Critical threshold for cluster_relocating_shards detector"
  type        = number
  default     = 0
}

variable "cluster_relocating_shards_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "15m"
}

variable "cluster_relocating_shards_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# cluster_unassigned_shards detector

variable "cluster_unassigned_shards_notifications" {
  description = "Notification recipients list per severity overridden for cluster_unassigned_shards detector"
  type        = map(list(string))
  default     = {}
}

variable "cluster_unassigned_shards_aggregation_function" {
  description = "Aggregation function and group by for cluster_unassigned_shards detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".max(by=['cluster'])"
}

variable "cluster_unassigned_shards_transformation_function" {
  description = "Transformation function for cluster_unassigned_shards detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "cluster_unassigned_shards_max_delay" {
  description = "Enforce max delay for cluster_unassigned_shards detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "cluster_unassigned_shards_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "cluster_unassigned_shards_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "cluster_unassigned_shards_disabled" {
  description = "Disable all alerting rules for cluster_unassigned_shards detector"
  type        = bool
  default     = null
}

variable "cluster_unassigned_shards_threshold_critical" {
  description = "Critical threshold for cluster_unassigned_shards detector"
  type        = number
  default     = 0
}

variable "cluster_unassigned_shards_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "10m"
}

variable "cluster_unassigned_shards_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# pending_tasks detector

variable "pending_tasks_notifications" {
  description = "Notification recipients list per severity overridden for pending_tasks detector"
  type        = map(list(string))
  default     = {}
}

variable "pending_tasks_aggregation_function" {
  description = "Aggregation function and group by for pending_tasks detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".max(by=['cluster'])"
}

variable "pending_tasks_transformation_function" {
  description = "Transformation function for pending_tasks detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "pending_tasks_max_delay" {
  description = "Enforce max delay for pending_tasks detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "pending_tasks_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "pending_tasks_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

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

variable "pending_tasks_threshold_critical" {
  description = "Critical threshold for pending_tasks detector"
  type        = number
  default     = 5
}

variable "pending_tasks_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "15m"
}

variable "pending_tasks_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "pending_tasks_threshold_major" {
  description = "Major threshold for pending_tasks detector"
  type        = number
  default     = 0
}

variable "pending_tasks_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "15m"
}

variable "pending_tasks_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# cpu_usage detector

variable "cpu_usage_notifications" {
  description = "Notification recipients list per severity overridden for cpu_usage detector"
  type        = map(list(string))
  default     = {}
}

variable "cpu_usage_aggregation_function" {
  description = "Aggregation function and group by for cpu_usage detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".max(by=['cluster'])"
}

variable "cpu_usage_transformation_function" {
  description = "Transformation function for cpu_usage detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "cpu_usage_max_delay" {
  description = "Enforce max delay for cpu_usage detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "cpu_usage_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "cpu_usage_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

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

variable "cpu_usage_threshold_critical" {
  description = "Critical threshold for cpu_usage detector"
  type        = number
  default     = 95
}

variable "cpu_usage_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "30m"
}

variable "cpu_usage_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "cpu_usage_threshold_major" {
  description = "Major threshold for cpu_usage detector"
  type        = number
  default     = 85
}

variable "cpu_usage_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "30m"
}

variable "cpu_usage_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# file_descriptors detector

variable "file_descriptors_notifications" {
  description = "Notification recipients list per severity overridden for file_descriptors detector"
  type        = map(list(string))
  default     = {}
}

variable "file_descriptors_aggregation_function" {
  description = "Aggregation function and group by for file_descriptors detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".max(by=['cluster'])"
}

variable "file_descriptors_transformation_function" {
  description = "Transformation function for file_descriptors detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "file_descriptors_max_delay" {
  description = "Enforce max delay for file_descriptors detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "file_descriptors_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "file_descriptors_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

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

variable "file_descriptors_threshold_critical" {
  description = "Critical threshold for file_descriptors detector"
  type        = number
  default     = 95
}

variable "file_descriptors_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "15m"
}

variable "file_descriptors_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "file_descriptors_threshold_major" {
  description = "Major threshold for file_descriptors detector"
  type        = number
  default     = 90
}

variable "file_descriptors_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "15m"
}

variable "file_descriptors_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# jvm_heap_memory_usage detector

variable "jvm_heap_memory_usage_notifications" {
  description = "Notification recipients list per severity overridden for jvm_heap_memory_usage detector"
  type        = map(list(string))
  default     = {}
}

variable "jvm_heap_memory_usage_aggregation_function" {
  description = "Aggregation function and group by for jvm_heap_memory_usage detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".max(by=['cluster'])"
}

variable "jvm_heap_memory_usage_transformation_function" {
  description = "Transformation function for jvm_heap_memory_usage detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "jvm_heap_memory_usage_max_delay" {
  description = "Enforce max delay for jvm_heap_memory_usage detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "jvm_heap_memory_usage_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "jvm_heap_memory_usage_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

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

variable "jvm_heap_memory_usage_threshold_critical" {
  description = "Critical threshold for jvm_heap_memory_usage detector"
  type        = number
  default     = 90
}

variable "jvm_heap_memory_usage_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "5m"
}

variable "jvm_heap_memory_usage_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "jvm_heap_memory_usage_threshold_major" {
  description = "Major threshold for jvm_heap_memory_usage detector"
  type        = number
  default     = 80
}

variable "jvm_heap_memory_usage_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "5m"
}

variable "jvm_heap_memory_usage_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# jvm_memory_young_usage detector

variable "jvm_memory_young_usage_notifications" {
  description = "Notification recipients list per severity overridden for jvm_memory_young_usage detector"
  type        = map(list(string))
  default     = {}
}

variable "jvm_memory_young_usage_aggregation_function" {
  description = "Aggregation function and group by for jvm_memory_young_usage detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".max(by=['cluster'])"
}

variable "jvm_memory_young_usage_transformation_function" {
  description = "Transformation function for jvm_memory_young_usage detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "jvm_memory_young_usage_max_delay" {
  description = "Enforce max delay for jvm_memory_young_usage detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "jvm_memory_young_usage_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "jvm_memory_young_usage_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

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

variable "jvm_memory_young_usage_threshold_major" {
  description = "Major threshold for jvm_memory_young_usage detector"
  type        = number
  default     = 90
}

variable "jvm_memory_young_usage_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "10m"
}

variable "jvm_memory_young_usage_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "jvm_memory_young_usage_threshold_minor" {
  description = "Minor threshold for jvm_memory_young_usage detector"
  type        = number
  default     = 80
}

variable "jvm_memory_young_usage_lasting_duration_minor" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "10m"
}

variable "jvm_memory_young_usage_at_least_percentage_minor" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# jvm_memory_old_usage detector

variable "jvm_memory_old_usage_notifications" {
  description = "Notification recipients list per severity overridden for jvm_memory_old_usage detector"
  type        = map(list(string))
  default     = {}
}

variable "jvm_memory_old_usage_aggregation_function" {
  description = "Aggregation function and group by for jvm_memory_old_usage detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".max(by=['cluster'])"
}

variable "jvm_memory_old_usage_transformation_function" {
  description = "Transformation function for jvm_memory_old_usage detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "jvm_memory_old_usage_max_delay" {
  description = "Enforce max delay for jvm_memory_old_usage detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "jvm_memory_old_usage_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "jvm_memory_old_usage_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

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

variable "jvm_memory_old_usage_threshold_major" {
  description = "Major threshold for jvm_memory_old_usage detector"
  type        = number
  default     = 90
}

variable "jvm_memory_old_usage_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "10m"
}

variable "jvm_memory_old_usage_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "jvm_memory_old_usage_threshold_minor" {
  description = "Minor threshold for jvm_memory_old_usage detector"
  type        = number
  default     = 80
}

variable "jvm_memory_old_usage_lasting_duration_minor" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "10m"
}

variable "jvm_memory_old_usage_at_least_percentage_minor" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# jvm_gc_old_collection_latency detector

variable "jvm_gc_old_collection_latency_notifications" {
  description = "Notification recipients list per severity overridden for jvm_gc_old_collection_latency detector"
  type        = map(list(string))
  default     = {}
}

variable "jvm_gc_old_collection_latency_aggregation_function" {
  description = "Aggregation function and group by for jvm_gc_old_collection_latency detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".max(by=['cluster'])"
}

variable "jvm_gc_old_collection_latency_transformation_function" {
  description = "Transformation function for jvm_gc_old_collection_latency detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "jvm_gc_old_collection_latency_max_delay" {
  description = "Enforce max delay for jvm_gc_old_collection_latency detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "jvm_gc_old_collection_latency_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "jvm_gc_old_collection_latency_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

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

variable "jvm_gc_old_collection_latency_threshold_major" {
  description = "Major threshold for jvm_gc_old_collection_latency detector"
  type        = number
  default     = 300
}

variable "jvm_gc_old_collection_latency_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "15m"
}

variable "jvm_gc_old_collection_latency_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "jvm_gc_old_collection_latency_threshold_minor" {
  description = "Minor threshold for jvm_gc_old_collection_latency detector"
  type        = number
  default     = 200
}

variable "jvm_gc_old_collection_latency_lasting_duration_minor" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "15m"
}

variable "jvm_gc_old_collection_latency_at_least_percentage_minor" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# jvm_gc_young_collection_latency detector

variable "jvm_gc_young_collection_latency_notifications" {
  description = "Notification recipients list per severity overridden for jvm_gc_young_collection_latency detector"
  type        = map(list(string))
  default     = {}
}

variable "jvm_gc_young_collection_latency_aggregation_function" {
  description = "Aggregation function and group by for jvm_gc_young_collection_latency detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".max(by=['cluster'])"
}

variable "jvm_gc_young_collection_latency_transformation_function" {
  description = "Transformation function for jvm_gc_young_collection_latency detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "jvm_gc_young_collection_latency_max_delay" {
  description = "Enforce max delay for jvm_gc_young_collection_latency detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "jvm_gc_young_collection_latency_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "jvm_gc_young_collection_latency_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

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

variable "jvm_gc_young_collection_latency_threshold_major" {
  description = "Major threshold for jvm_gc_young_collection_latency detector"
  type        = number
  default     = 40
}

variable "jvm_gc_young_collection_latency_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "15m"
}

variable "jvm_gc_young_collection_latency_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "jvm_gc_young_collection_latency_threshold_minor" {
  description = "Minor threshold for jvm_gc_young_collection_latency detector"
  type        = number
  default     = 20
}

variable "jvm_gc_young_collection_latency_lasting_duration_minor" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "15m"
}

variable "jvm_gc_young_collection_latency_at_least_percentage_minor" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# indexing_latency detector

variable "indexing_latency_notifications" {
  description = "Notification recipients list per severity overridden for indexing_latency detector"
  type        = map(list(string))
  default     = {}
}

variable "indexing_latency_aggregation_function" {
  description = "Aggregation function and group by for indexing_latency detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".max(by=['cluster'])"
}

variable "indexing_latency_transformation_function" {
  description = "Transformation function for indexing_latency detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "indexing_latency_max_delay" {
  description = "Enforce max delay for indexing_latency detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "indexing_latency_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "indexing_latency_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

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

variable "indexing_latency_threshold_major" {
  description = "Major threshold for indexing_latency detector"
  type        = number
  default     = 30
}

variable "indexing_latency_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "1h"
}

variable "indexing_latency_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "indexing_latency_threshold_minor" {
  description = "Minor threshold for indexing_latency detector"
  type        = number
  default     = 15
}

variable "indexing_latency_lasting_duration_minor" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "1h"
}

variable "indexing_latency_at_least_percentage_minor" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# flush_latency detector

variable "flush_latency_notifications" {
  description = "Notification recipients list per severity overridden for flush_latency detector"
  type        = map(list(string))
  default     = {}
}

variable "flush_latency_aggregation_function" {
  description = "Aggregation function and group by for flush_latency detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".max(by=['cluster'])"
}

variable "flush_latency_transformation_function" {
  description = "Transformation function for flush_latency detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "flush_latency_max_delay" {
  description = "Enforce max delay for flush_latency detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "flush_latency_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "flush_latency_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

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

variable "flush_latency_threshold_major" {
  description = "Major threshold for flush_latency detector"
  type        = number
  default     = 150
}

variable "flush_latency_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "15m"
}

variable "flush_latency_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "flush_latency_threshold_minor" {
  description = "Minor threshold for flush_latency detector"
  type        = number
  default     = 100
}

variable "flush_latency_lasting_duration_minor" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "15m"
}

variable "flush_latency_at_least_percentage_minor" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# search_latency detector

variable "search_latency_notifications" {
  description = "Notification recipients list per severity overridden for search_latency detector"
  type        = map(list(string))
  default     = {}
}

variable "search_latency_aggregation_function" {
  description = "Aggregation function and group by for search_latency detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".max(by=['cluster'])"
}

variable "search_latency_transformation_function" {
  description = "Transformation function for search_latency detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "search_latency_max_delay" {
  description = "Enforce max delay for search_latency detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "search_latency_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "search_latency_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

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

variable "search_latency_threshold_major" {
  description = "Major threshold for search_latency detector"
  type        = number
  default     = 20
}

variable "search_latency_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "30m"
}

variable "search_latency_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "search_latency_threshold_minor" {
  description = "Minor threshold for search_latency detector"
  type        = number
  default     = 10
}

variable "search_latency_lasting_duration_minor" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "30m"
}

variable "search_latency_at_least_percentage_minor" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# fetch_latency detector

variable "fetch_latency_notifications" {
  description = "Notification recipients list per severity overridden for fetch_latency detector"
  type        = map(list(string))
  default     = {}
}

variable "fetch_latency_aggregation_function" {
  description = "Aggregation function and group by for fetch_latency detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".max(by=['cluster'])"
}

variable "fetch_latency_transformation_function" {
  description = "Transformation function for fetch_latency detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "fetch_latency_max_delay" {
  description = "Enforce max delay for fetch_latency detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "fetch_latency_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "fetch_latency_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

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

variable "fetch_latency_threshold_major" {
  description = "Major threshold for fetch_latency detector"
  type        = number
  default     = 20
}

variable "fetch_latency_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "15m"
}

variable "fetch_latency_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "fetch_latency_threshold_minor" {
  description = "Minor threshold for fetch_latency detector"
  type        = number
  default     = 10
}

variable "fetch_latency_lasting_duration_minor" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "15m"
}

variable "fetch_latency_at_least_percentage_minor" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# field_data_evictions_change detector

variable "field_data_evictions_change_notifications" {
  description = "Notification recipients list per severity overridden for field_data_evictions_change detector"
  type        = map(list(string))
  default     = {}
}

variable "field_data_evictions_change_aggregation_function" {
  description = "Aggregation function and group by for field_data_evictions_change detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".max(by=['cluster'])"
}

variable "field_data_evictions_change_transformation_function" {
  description = "Transformation function for field_data_evictions_change detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "field_data_evictions_change_max_delay" {
  description = "Enforce max delay for field_data_evictions_change detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "field_data_evictions_change_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "field_data_evictions_change_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

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

variable "field_data_evictions_change_threshold_major" {
  description = "Major threshold for field_data_evictions_change detector"
  type        = number
  default     = 120
}

variable "field_data_evictions_change_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "15m"
}

variable "field_data_evictions_change_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "field_data_evictions_change_threshold_minor" {
  description = "Minor threshold for field_data_evictions_change detector"
  type        = number
  default     = 60
}

variable "field_data_evictions_change_lasting_duration_minor" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "15m"
}

variable "field_data_evictions_change_at_least_percentage_minor" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# task_time_in_queue_change detector

variable "task_time_in_queue_change_notifications" {
  description = "Notification recipients list per severity overridden for task_time_in_queue_change detector"
  type        = map(list(string))
  default     = {}
}

variable "task_time_in_queue_change_aggregation_function" {
  description = "Aggregation function and group by for task_time_in_queue_change detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".max(by=['cluster'])"
}

variable "task_time_in_queue_change_transformation_function" {
  description = "Transformation function for task_time_in_queue_change detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "task_time_in_queue_change_max_delay" {
  description = "Enforce max delay for task_time_in_queue_change detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "task_time_in_queue_change_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "task_time_in_queue_change_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

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

variable "task_time_in_queue_change_threshold_major" {
  description = "Major threshold for task_time_in_queue_change detector"
  type        = number
  default     = 200
}

variable "task_time_in_queue_change_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "15m"
}

variable "task_time_in_queue_change_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "task_time_in_queue_change_threshold_minor" {
  description = "Minor threshold for task_time_in_queue_change detector"
  type        = number
  default     = 100
}

variable "task_time_in_queue_change_lasting_duration_minor" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "15m"
}

variable "task_time_in_queue_change_at_least_percentage_minor" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
