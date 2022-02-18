# heartbeat detector

variable "heartbeat_notifications" {
  description = "Notification recipients list per severity overridden for heartbeat detector"
  type        = map(list(string))
  default     = {}
}

variable "heartbeat_aggregation_function" {
  description = "Aggregation function and group by for heartbeat detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['ClusterIdentifier'])"
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

variable "cpu_usage_disabled_major" {
  description = "Disable major alerting rule for cpu_usage detector"
  type        = bool
  default     = null
}

variable "cpu_usage_disabled_critical" {
  description = "Disable critical alerting rule for cpu_usage detector"
  type        = bool
  default     = null
}

variable "cpu_usage_threshold_major" {
  description = "Major threshold for cpu_usage detector in %"
  type        = number
  default     = 80
}

variable "cpu_usage_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "15m"
}

variable "cpu_usage_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "cpu_usage_threshold_critical" {
  description = "Critical threshold for cpu_usage detector in %"
  type        = number
  default     = 90
}

variable "cpu_usage_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "15m"
}

variable "cpu_usage_at_least_percentage_critical" {
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
  default     = ""
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

variable "storage_usage_disabled_major" {
  description = "Disable major alerting rule for storage_usage detector"
  type        = bool
  default     = null
}

variable "storage_usage_disabled_critical" {
  description = "Disable critical alerting rule for storage_usage detector"
  type        = bool
  default     = null
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
