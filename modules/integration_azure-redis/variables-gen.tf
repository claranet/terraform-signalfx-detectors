# heartbeat detector

variable "heartbeat_notifications" {
  description = "Notification recipients list per severity overridden for heartbeat detector"
  type        = map(list(string))
  default     = {}
}

variable "heartbeat_aggregation_function" {
  description = "Aggregation function and group by for heartbeat detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['azure_resource_name', 'azure_resource_group_name', 'azure_region'])"
}

variable "heartbeat_transformation_function" {
  description = "Transformation function for heartbeat detector (i.e. \".mean(over='5m')\")"
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

# evicted_keys detector

variable "evicted_keys_notifications" {
  description = "Notification recipients list per severity overridden for evicted_keys detector"
  type        = map(list(string))
  default     = {}
}

variable "evicted_keys_aggregation_function" {
  description = "Aggregation function and group by for evicted_keys detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['azure_resource_name', 'azure_resource_group_name', 'azure_region'])"
}

variable "evicted_keys_transformation_function" {
  description = "Transformation function for evicted_keys detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "evicted_keys_max_delay" {
  description = "Enforce max delay for evicted_keys detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "evicted_keys_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "evicted_keys_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "evicted_keys_disabled" {
  description = "Disable all alerting rules for evicted_keys detector"
  type        = bool
  default     = null
}

variable "evicted_keys_disabled_critical" {
  description = "Disable critical alerting rule for evicted_keys detector"
  type        = bool
  default     = null
}

variable "evicted_keys_disabled_major" {
  description = "Disable major alerting rule for evicted_keys detector"
  type        = bool
  default     = null
}

variable "evicted_keys_threshold_critical" {
  description = "Critical threshold for evicted_keys detector"
  type        = number
  default     = 100
}

variable "evicted_keys_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "5m"
}

variable "evicted_keys_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "evicted_keys_threshold_major" {
  description = "Major threshold for evicted_keys detector"
  type        = number
  default     = 0
}

variable "evicted_keys_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "5m"
}

variable "evicted_keys_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# processor_time detector

variable "processor_time_notifications" {
  description = "Notification recipients list per severity overridden for processor_time detector"
  type        = map(list(string))
  default     = {}
}

variable "processor_time_aggregation_function" {
  description = "Aggregation function and group by for processor_time detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['shardid', 'azure_resource_name', 'azure_resource_group_name', 'azure_region'])"
}

variable "processor_time_transformation_function" {
  description = "Transformation function for processor_time detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "processor_time_max_delay" {
  description = "Enforce max delay for processor_time detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "processor_time_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "processor_time_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "processor_time_disabled" {
  description = "Disable all alerting rules for processor_time detector"
  type        = bool
  default     = null
}

variable "processor_time_disabled_critical" {
  description = "Disable critical alerting rule for processor_time detector"
  type        = bool
  default     = null
}

variable "processor_time_disabled_major" {
  description = "Disable major alerting rule for processor_time detector"
  type        = bool
  default     = null
}

variable "processor_time_threshold_critical" {
  description = "Critical threshold for processor_time detector in %"
  type        = number
  default     = 80
}

variable "processor_time_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "5m"
}

variable "processor_time_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "processor_time_threshold_major" {
  description = "Major threshold for processor_time detector in %"
  type        = number
  default     = 60
}

variable "processor_time_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "5m"
}

variable "processor_time_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# load detector

variable "load_notifications" {
  description = "Notification recipients list per severity overridden for load detector"
  type        = map(list(string))
  default     = {}
}

variable "load_aggregation_function" {
  description = "Aggregation function and group by for load detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['shardid', 'azure_resource_name', 'azure_resource_group_name', 'azure_region'])"
}

variable "load_transformation_function" {
  description = "Transformation function for load detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "load_max_delay" {
  description = "Enforce max delay for load detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "load_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "load_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "load_disabled" {
  description = "Disable all alerting rules for load detector"
  type        = bool
  default     = null
}

variable "load_disabled_critical" {
  description = "Disable critical alerting rule for load detector"
  type        = bool
  default     = null
}

variable "load_disabled_major" {
  description = "Disable major alerting rule for load detector"
  type        = bool
  default     = null
}

variable "load_threshold_critical" {
  description = "Critical threshold for load detector in %"
  type        = number
  default     = 90
}

variable "load_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "5m"
}

variable "load_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "load_threshold_major" {
  description = "Major threshold for load detector in %"
  type        = number
  default     = 70
}

variable "load_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "5m"
}

variable "load_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
