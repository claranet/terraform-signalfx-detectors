# heartbeat detector

variable "heartbeat_notifications" {
  description = "Notification recipients list per severity overridden for heartbeat detector"
  type        = map(list(string))
  default     = {}
}

variable "heartbeat_aggregation_function" {
  description = "Aggregation function and group by for heartbeat detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
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
  default     = ""
}

variable "cluster_status_transformation_function" {
  description = "Transformation function for cluster_status detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".mean(over='5m')"
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
  default     = 1
}

variable "cluster_status_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "cluster_status_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "cluster_status_threshold_major" {
  description = "Major threshold for cluster_status detector"
  type        = number
  default     = 2
}

variable "cluster_status_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
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
  default     = ""
}

variable "cluster_initializing_shards_transformation_function" {
  description = "Transformation function for cluster_initializing_shards detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='15m')"
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
  default     = 0
}

variable "cluster_initializing_shards_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "cluster_initializing_shards_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "cluster_initializing_shards_threshold_major" {
  description = "Major threshold for cluster_initializing_shards detector"
  type        = number
  default     = -1
}

variable "cluster_initializing_shards_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
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
  default     = ""
}

variable "cluster_relocating_shards_transformation_function" {
  description = "Transformation function for cluster_relocating_shards detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='15m')"
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

variable "cluster_relocating_shards_disabled_critical" {
  description = "Disable critical alerting rule for cluster_relocating_shards detector"
  type        = bool
  default     = null
}

variable "cluster_relocating_shards_disabled_major" {
  description = "Disable major alerting rule for cluster_relocating_shards detector"
  type        = bool
  default     = null
}

variable "cluster_relocating_shards_threshold_critical" {
  description = "Critical threshold for cluster_relocating_shards detector"
  type        = number
  default     = 1
}

variable "cluster_relocating_shards_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "cluster_relocating_shards_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "cluster_relocating_shards_threshold_major" {
  description = "Major threshold for cluster_relocating_shards detector"
  type        = number
  default     = 0
}

variable "cluster_relocating_shards_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "cluster_relocating_shards_at_least_percentage_major" {
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
  default     = ""
}

variable "cluster_unassigned_shards_transformation_function" {
  description = "Transformation function for cluster_unassigned_shards detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='10m')"
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

variable "cluster_unassigned_shards_disabled_critical" {
  description = "Disable critical alerting rule for cluster_unassigned_shards detector"
  type        = bool
  default     = null
}

variable "cluster_unassigned_shards_disabled_major" {
  description = "Disable major alerting rule for cluster_unassigned_shards detector"
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
  default     = null
}

variable "cluster_unassigned_shards_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "cluster_unassigned_shards_threshold_major" {
  description = "Major threshold for cluster_unassigned_shards detector"
  type        = number
  default     = -1
}

variable "cluster_unassigned_shards_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "cluster_unassigned_shards_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# cluster_pending_tasks detector

variable "cluster_pending_tasks_notifications" {
  description = "Notification recipients list per severity overridden for cluster_pending_tasks detector"
  type        = map(list(string))
  default     = {}
}

variable "cluster_pending_tasks_aggregation_function" {
  description = "Aggregation function and group by for cluster_pending_tasks detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "cluster_pending_tasks_transformation_function" {
  description = "Transformation function for cluster_pending_tasks detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='15m')"
}

variable "cluster_pending_tasks_max_delay" {
  description = "Enforce max delay for cluster_pending_tasks detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "cluster_pending_tasks_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "cluster_pending_tasks_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "cluster_pending_tasks_disabled" {
  description = "Disable all alerting rules for cluster_pending_tasks detector"
  type        = bool
  default     = null
}

variable "cluster_pending_tasks_disabled_critical" {
  description = "Disable critical alerting rule for cluster_pending_tasks detector"
  type        = bool
  default     = null
}

variable "cluster_pending_tasks_disabled_major" {
  description = "Disable major alerting rule for cluster_pending_tasks detector"
  type        = bool
  default     = null
}

variable "cluster_pending_tasks_threshold_critical" {
  description = "Critical threshold for cluster_pending_tasks detector"
  type        = number
  default     = 5
}

variable "cluster_pending_tasks_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "cluster_pending_tasks_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "cluster_pending_tasks_threshold_major" {
  description = "Major threshold for cluster_pending_tasks detector"
  type        = number
  default     = 0
}

variable "cluster_pending_tasks_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "cluster_pending_tasks_at_least_percentage_major" {
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
  default     = ""
}

variable "cpu_usage_transformation_function" {
  description = "Transformation function for cpu_usage detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='30m')"
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
  default     = null
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
  default     = null
}

variable "cpu_usage_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# file_descriptors_usage detector

variable "file_descriptors_usage_notifications" {
  description = "Notification recipients list per severity overridden for file_descriptors_usage detector"
  type        = map(list(string))
  default     = {}
}

variable "file_descriptors_usage_aggregation_function" {
  description = "Aggregation function and group by for file_descriptors_usage detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "file_descriptors_usage_transformation_function" {
  description = "Transformation function for file_descriptors_usage detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".max(over='15m')"
}

variable "file_descriptors_usage_max_delay" {
  description = "Enforce max delay for file_descriptors_usage detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "file_descriptors_usage_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "file_descriptors_usage_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "file_descriptors_usage_disabled" {
  description = "Disable all alerting rules for file_descriptors_usage detector"
  type        = bool
  default     = null
}

variable "file_descriptors_usage_disabled_critical" {
  description = "Disable critical alerting rule for file_descriptors_usage detector"
  type        = bool
  default     = null
}

variable "file_descriptors_usage_disabled_major" {
  description = "Disable major alerting rule for file_descriptors_usage detector"
  type        = bool
  default     = null
}

variable "file_descriptors_usage_threshold_critical" {
  description = "Critical threshold for file_descriptors_usage detector"
  type        = number
  default     = 95
}

variable "file_descriptors_usage_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "file_descriptors_usage_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "file_descriptors_usage_threshold_major" {
  description = "Major threshold for file_descriptors_usage detector"
  type        = number
  default     = 90
}

variable "file_descriptors_usage_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "file_descriptors_usage_at_least_percentage_major" {
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
  default     = ""
}

variable "jvm_heap_memory_usage_transformation_function" {
  description = "Transformation function for jvm_heap_memory_usage detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".mean(over='5m')"
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
  default     = null
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
  default     = null
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
  default     = ""
}

variable "jvm_memory_young_usage_transformation_function" {
  description = "Transformation function for jvm_memory_young_usage detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".mean(over='10m')"
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
  default     = null
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
  default     = null
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
  default     = ""
}

variable "jvm_memory_old_usage_transformation_function" {
  description = "Transformation function for jvm_memory_old_usage detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".mean(over='10m')"
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
  default     = null
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
  default     = null
}

variable "jvm_memory_old_usage_at_least_percentage_minor" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# old-generation_garbage_collections_latency detector

variable "old-generation_garbage_collections_latency_notifications" {
  description = "Notification recipients list per severity overridden for old-generation_garbage_collections_latency detector"
  type        = map(list(string))
  default     = {}
}

variable "old-generation_garbage_collections_latency_aggregation_function" {
  description = "Aggregation function and group by for old-generation_garbage_collections_latency detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "old-generation_garbage_collections_latency_transformation_function" {
  description = "Transformation function for old-generation_garbage_collections_latency detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".mean(over='15m')"
}

variable "old-generation_garbage_collections_latency_max_delay" {
  description = "Enforce max delay for old-generation_garbage_collections_latency detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "old-generation_garbage_collections_latency_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "old-generation_garbage_collections_latency_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "old-generation_garbage_collections_latency_disabled" {
  description = "Disable all alerting rules for old-generation_garbage_collections_latency detector"
  type        = bool
  default     = null
}

variable "old-generation_garbage_collections_latency_disabled_major" {
  description = "Disable major alerting rule for old-generation_garbage_collections_latency detector"
  type        = bool
  default     = null
}

variable "old-generation_garbage_collections_latency_disabled_minor" {
  description = "Disable minor alerting rule for old-generation_garbage_collections_latency detector"
  type        = bool
  default     = null
}

variable "old-generation_garbage_collections_latency_threshold_major" {
  description = "Major threshold for old-generation_garbage_collections_latency detector"
  type        = number
  default     = 300
}

variable "old-generation_garbage_collections_latency_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "old-generation_garbage_collections_latency_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "old-generation_garbage_collections_latency_threshold_minor" {
  description = "Minor threshold for old-generation_garbage_collections_latency detector"
  type        = number
  default     = 200
}

variable "old-generation_garbage_collections_latency_lasting_duration_minor" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "old-generation_garbage_collections_latency_at_least_percentage_minor" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# young-generation_garbage_collections_latency detector

variable "young-generation_garbage_collections_latency_notifications" {
  description = "Notification recipients list per severity overridden for young-generation_garbage_collections_latency detector"
  type        = map(list(string))
  default     = {}
}

variable "young-generation_garbage_collections_latency_aggregation_function" {
  description = "Aggregation function and group by for young-generation_garbage_collections_latency detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "young-generation_garbage_collections_latency_transformation_function" {
  description = "Transformation function for young-generation_garbage_collections_latency detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".mean(over='15m')"
}

variable "young-generation_garbage_collections_latency_max_delay" {
  description = "Enforce max delay for young-generation_garbage_collections_latency detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "young-generation_garbage_collections_latency_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "young-generation_garbage_collections_latency_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "young-generation_garbage_collections_latency_disabled" {
  description = "Disable all alerting rules for young-generation_garbage_collections_latency detector"
  type        = bool
  default     = null
}

variable "young-generation_garbage_collections_latency_disabled_major" {
  description = "Disable major alerting rule for young-generation_garbage_collections_latency detector"
  type        = bool
  default     = null
}

variable "young-generation_garbage_collections_latency_disabled_minor" {
  description = "Disable minor alerting rule for young-generation_garbage_collections_latency detector"
  type        = bool
  default     = null
}

variable "young-generation_garbage_collections_latency_threshold_major" {
  description = "Major threshold for young-generation_garbage_collections_latency detector"
  type        = number
  default     = 40
}

variable "young-generation_garbage_collections_latency_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "young-generation_garbage_collections_latency_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "young-generation_garbage_collections_latency_threshold_minor" {
  description = "Minor threshold for young-generation_garbage_collections_latency detector"
  type        = number
  default     = 20
}

variable "young-generation_garbage_collections_latency_lasting_duration_minor" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "young-generation_garbage_collections_latency_at_least_percentage_minor" {
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
  default     = ""
}

variable "indexing_latency_transformation_function" {
  description = "Transformation function for indexing_latency detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".mean(over='15m')"
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
  default     = null
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
  default     = null
}

variable "indexing_latency_at_least_percentage_minor" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# index_flushing_to_disk_latency detector

variable "index_flushing_to_disk_latency_notifications" {
  description = "Notification recipients list per severity overridden for index_flushing_to_disk_latency detector"
  type        = map(list(string))
  default     = {}
}

variable "index_flushing_to_disk_latency_aggregation_function" {
  description = "Aggregation function and group by for index_flushing_to_disk_latency detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "index_flushing_to_disk_latency_transformation_function" {
  description = "Transformation function for index_flushing_to_disk_latency detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".mean(over='15m')"
}

variable "index_flushing_to_disk_latency_max_delay" {
  description = "Enforce max delay for index_flushing_to_disk_latency detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "index_flushing_to_disk_latency_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "index_flushing_to_disk_latency_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "index_flushing_to_disk_latency_disabled" {
  description = "Disable all alerting rules for index_flushing_to_disk_latency detector"
  type        = bool
  default     = null
}

variable "index_flushing_to_disk_latency_disabled_major" {
  description = "Disable major alerting rule for index_flushing_to_disk_latency detector"
  type        = bool
  default     = null
}

variable "index_flushing_to_disk_latency_disabled_minor" {
  description = "Disable minor alerting rule for index_flushing_to_disk_latency detector"
  type        = bool
  default     = null
}

variable "index_flushing_to_disk_latency_threshold_major" {
  description = "Major threshold for index_flushing_to_disk_latency detector"
  type        = number
  default     = 150
}

variable "index_flushing_to_disk_latency_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "index_flushing_to_disk_latency_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "index_flushing_to_disk_latency_threshold_minor" {
  description = "Minor threshold for index_flushing_to_disk_latency detector"
  type        = number
  default     = 100
}

variable "index_flushing_to_disk_latency_lasting_duration_minor" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "index_flushing_to_disk_latency_at_least_percentage_minor" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# search_query_latency detector

variable "search_query_latency_notifications" {
  description = "Notification recipients list per severity overridden for search_query_latency detector"
  type        = map(list(string))
  default     = {}
}

variable "search_query_latency_aggregation_function" {
  description = "Aggregation function and group by for search_query_latency detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "search_query_latency_transformation_function" {
  description = "Transformation function for search_query_latency detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='30m')"
}

variable "search_query_latency_max_delay" {
  description = "Enforce max delay for search_query_latency detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "search_query_latency_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "search_query_latency_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "search_query_latency_disabled" {
  description = "Disable all alerting rules for search_query_latency detector"
  type        = bool
  default     = null
}

variable "search_query_latency_disabled_major" {
  description = "Disable major alerting rule for search_query_latency detector"
  type        = bool
  default     = null
}

variable "search_query_latency_disabled_minor" {
  description = "Disable minor alerting rule for search_query_latency detector"
  type        = bool
  default     = null
}

variable "search_query_latency_threshold_major" {
  description = "Major threshold for search_query_latency detector"
  type        = number
  default     = 20
}

variable "search_query_latency_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "search_query_latency_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "search_query_latency_threshold_minor" {
  description = "Minor threshold for search_query_latency detector"
  type        = number
  default     = 10
}

variable "search_query_latency_lasting_duration_minor" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "search_query_latency_at_least_percentage_minor" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# search_fetch_latency detector

variable "search_fetch_latency_notifications" {
  description = "Notification recipients list per severity overridden for search_fetch_latency detector"
  type        = map(list(string))
  default     = {}
}

variable "search_fetch_latency_aggregation_function" {
  description = "Aggregation function and group by for search_fetch_latency detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "search_fetch_latency_transformation_function" {
  description = "Transformation function for search_fetch_latency detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='15m')"
}

variable "search_fetch_latency_max_delay" {
  description = "Enforce max delay for search_fetch_latency detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "search_fetch_latency_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "search_fetch_latency_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "search_fetch_latency_disabled" {
  description = "Disable all alerting rules for search_fetch_latency detector"
  type        = bool
  default     = null
}

variable "search_fetch_latency_disabled_major" {
  description = "Disable major alerting rule for search_fetch_latency detector"
  type        = bool
  default     = null
}

variable "search_fetch_latency_disabled_minor" {
  description = "Disable minor alerting rule for search_fetch_latency detector"
  type        = bool
  default     = null
}

variable "search_fetch_latency_threshold_major" {
  description = "Major threshold for search_fetch_latency detector"
  type        = number
  default     = 20
}

variable "search_fetch_latency_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "search_fetch_latency_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "search_fetch_latency_threshold_minor" {
  description = "Minor threshold for search_fetch_latency detector"
  type        = number
  default     = 10
}

variable "search_fetch_latency_lasting_duration_minor" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "search_fetch_latency_at_least_percentage_minor" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# fielddata_cache_evictions_rate_of_change detector

variable "fielddata_cache_evictions_rate_of_change_notifications" {
  description = "Notification recipients list per severity overridden for fielddata_cache_evictions_rate_of_change detector"
  type        = map(list(string))
  default     = {}
}

variable "fielddata_cache_evictions_rate_of_change_aggregation_function" {
  description = "Aggregation function and group by for fielddata_cache_evictions_rate_of_change detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "fielddata_cache_evictions_rate_of_change_transformation_function" {
  description = "Transformation function for fielddata_cache_evictions_rate_of_change detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".mean(over='15m')"
}

variable "fielddata_cache_evictions_rate_of_change_max_delay" {
  description = "Enforce max delay for fielddata_cache_evictions_rate_of_change detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "fielddata_cache_evictions_rate_of_change_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "fielddata_cache_evictions_rate_of_change_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "fielddata_cache_evictions_rate_of_change_disabled" {
  description = "Disable all alerting rules for fielddata_cache_evictions_rate_of_change detector"
  type        = bool
  default     = null
}

variable "fielddata_cache_evictions_rate_of_change_disabled_major" {
  description = "Disable major alerting rule for fielddata_cache_evictions_rate_of_change detector"
  type        = bool
  default     = null
}

variable "fielddata_cache_evictions_rate_of_change_disabled_minor" {
  description = "Disable minor alerting rule for fielddata_cache_evictions_rate_of_change detector"
  type        = bool
  default     = null
}

variable "fielddata_cache_evictions_rate_of_change_threshold_major" {
  description = "Major threshold for fielddata_cache_evictions_rate_of_change detector"
  type        = number
  default     = 120
}

variable "fielddata_cache_evictions_rate_of_change_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "fielddata_cache_evictions_rate_of_change_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "fielddata_cache_evictions_rate_of_change_threshold_minor" {
  description = "Minor threshold for fielddata_cache_evictions_rate_of_change detector"
  type        = number
  default     = 60
}

variable "fielddata_cache_evictions_rate_of_change_lasting_duration_minor" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "fielddata_cache_evictions_rate_of_change_at_least_percentage_minor" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# max_time_spent_by_task_in_queue_rate_of_change detector

variable "max_time_spent_by_task_in_queue_rate_of_change_notifications" {
  description = "Notification recipients list per severity overridden for max_time_spent_by_task_in_queue_rate_of_change detector"
  type        = map(list(string))
  default     = {}
}

variable "max_time_spent_by_task_in_queue_rate_of_change_aggregation_function" {
  description = "Aggregation function and group by for max_time_spent_by_task_in_queue_rate_of_change detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "max_time_spent_by_task_in_queue_rate_of_change_transformation_function" {
  description = "Transformation function for max_time_spent_by_task_in_queue_rate_of_change detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".mean(over='15m')"
}

variable "max_time_spent_by_task_in_queue_rate_of_change_max_delay" {
  description = "Enforce max delay for max_time_spent_by_task_in_queue_rate_of_change detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "max_time_spent_by_task_in_queue_rate_of_change_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "max_time_spent_by_task_in_queue_rate_of_change_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "max_time_spent_by_task_in_queue_rate_of_change_disabled" {
  description = "Disable all alerting rules for max_time_spent_by_task_in_queue_rate_of_change detector"
  type        = bool
  default     = null
}

variable "max_time_spent_by_task_in_queue_rate_of_change_disabled_major" {
  description = "Disable major alerting rule for max_time_spent_by_task_in_queue_rate_of_change detector"
  type        = bool
  default     = null
}

variable "max_time_spent_by_task_in_queue_rate_of_change_disabled_minor" {
  description = "Disable minor alerting rule for max_time_spent_by_task_in_queue_rate_of_change detector"
  type        = bool
  default     = null
}

variable "max_time_spent_by_task_in_queue_rate_of_change_threshold_major" {
  description = "Major threshold for max_time_spent_by_task_in_queue_rate_of_change detector"
  type        = number
  default     = 200
}

variable "max_time_spent_by_task_in_queue_rate_of_change_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "max_time_spent_by_task_in_queue_rate_of_change_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "max_time_spent_by_task_in_queue_rate_of_change_threshold_minor" {
  description = "Minor threshold for max_time_spent_by_task_in_queue_rate_of_change detector"
  type        = number
  default     = 100
}

variable "max_time_spent_by_task_in_queue_rate_of_change_lasting_duration_minor" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "max_time_spent_by_task_in_queue_rate_of_change_at_least_percentage_minor" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
