# heartbeat detector

variable "heartbeat_notifications" {
  description = "Notification recipients list per severity overridden for heartbeat detector"
  type        = map(list(string))
  default     = {}
}

variable "heartbeat_aggregation_function" {
  description = "Aggregation function and group by for heartbeat detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['databaseresourceid'])"
}

variable "heartbeat_transformation_function" {
  description = "Transformation function for heartbeat detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "heartbeat_max_delay" {
  description = "Enforce max delay for heartbeat detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
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
  description = "Timeframe for heartbeat detector (i.e. \"25m\")."
  type        = string
  default     = "25m"
}

# cpu detector

variable "cpu_notifications" {
  description = "Notification recipients list per severity overridden for cpu detector"
  type        = map(list(string))
  default     = {}
}

variable "cpu_aggregation_function" {
  description = "Aggregation function and group by for cpu detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".sum(by=['azure_resource_name', 'azure_resource_group_name', 'azure_region'])"
}

variable "cpu_transformation_function" {
  description = "Transformation function for cpu detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "cpu_max_delay" {
  description = "Enforce max delay for cpu detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "cpu_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "cpu_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "cpu_disabled" {
  description = "Disable all alerting rules for cpu detector"
  type        = bool
  default     = null
}

variable "cpu_disabled_critical" {
  description = "Disable critical alerting rule for cpu detector"
  type        = bool
  default     = null
}

variable "cpu_disabled_major" {
  description = "Disable major alerting rule for cpu detector"
  type        = bool
  default     = null
}

variable "cpu_threshold_critical" {
  description = "Critical threshold for cpu detector in %"
  type        = number
  default     = 90
}

variable "cpu_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "15m"
}

variable "cpu_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "cpu_threshold_major" {
  description = "Major threshold for cpu detector in %"
  type        = number
  default     = 80
}

variable "cpu_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "15m"
}

variable "cpu_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# storage_usage detector

variable "storage_usage_notifications" {
  description = "Notification recipients list per severity overridden for storage_usage detector"
  type        = map(list(string))
  default     = {}
}

variable "storage_usage_aggregation_function" {
  description = "Aggregation function and group by for storage_usage detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['azure_resource_name', 'azure_resource_group_name', 'azure_region'])"
}

variable "storage_usage_transformation_function" {
  description = "Transformation function for storage_usage detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "storage_usage_max_delay" {
  description = "Enforce max delay for storage_usage detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "storage_usage_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "storage_usage_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "storage_usage_disabled" {
  description = "Disable all alerting rules for storage_usage detector"
  type        = bool
  default     = null
}

variable "storage_usage_disabled_critical" {
  description = "Disable critical alerting rule for storage_usage detector"
  type        = bool
  default     = null
}

variable "storage_usage_disabled_major" {
  description = "Disable major alerting rule for storage_usage detector"
  type        = bool
  default     = null
}

variable "storage_usage_threshold_critical" {
  description = "Critical threshold for storage_usage detector in %"
  type        = number
  default     = 90
}

variable "storage_usage_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "15m"
}

variable "storage_usage_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "storage_usage_threshold_major" {
  description = "Major threshold for storage_usage detector in %"
  type        = number
  default     = 80
}

variable "storage_usage_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "15m"
}

variable "storage_usage_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# dtu_consumption detector

variable "dtu_consumption_notifications" {
  description = "Notification recipients list per severity overridden for dtu_consumption detector"
  type        = map(list(string))
  default     = {}
}

variable "dtu_consumption_aggregation_function" {
  description = "Aggregation function and group by for dtu_consumption detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".sum(by=['azure_resource_name', 'azure_resource_group_name', 'azure_region'])"
}

variable "dtu_consumption_transformation_function" {
  description = "Transformation function for dtu_consumption detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "dtu_consumption_max_delay" {
  description = "Enforce max delay for dtu_consumption detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "dtu_consumption_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "dtu_consumption_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "dtu_consumption_disabled" {
  description = "Disable all alerting rules for dtu_consumption detector"
  type        = bool
  default     = null
}

variable "dtu_consumption_disabled_critical" {
  description = "Disable critical alerting rule for dtu_consumption detector"
  type        = bool
  default     = null
}

variable "dtu_consumption_disabled_major" {
  description = "Disable major alerting rule for dtu_consumption detector"
  type        = bool
  default     = null
}

variable "dtu_consumption_threshold_critical" {
  description = "Critical threshold for dtu_consumption detector in %"
  type        = number
  default     = 90
}

variable "dtu_consumption_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "15m"
}

variable "dtu_consumption_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "dtu_consumption_threshold_major" {
  description = "Major threshold for dtu_consumption detector in %"
  type        = number
  default     = 85
}

variable "dtu_consumption_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "15m"
}

variable "dtu_consumption_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
