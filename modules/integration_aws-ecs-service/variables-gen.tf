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

# cpu_utilization detector

variable "cpu_utilization_notifications" {
  description = "Notification recipients list per severity overridden for cpu_utilization detector"
  type        = map(list(string))
  default     = {}
}

variable "cpu_utilization_aggregation_function" {
  description = "Aggregation function and group by for cpu_utilization detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "cpu_utilization_transformation_function" {
  description = "Transformation function for cpu_utilization detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "cpu_utilization_max_delay" {
  description = "Enforce max delay for cpu_utilization detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "cpu_utilization_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "cpu_utilization_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "cpu_utilization_disabled" {
  description = "Disable all alerting rules for cpu_utilization detector"
  type        = bool
  default     = null
}

variable "cpu_utilization_disabled_critical" {
  description = "Disable critical alerting rule for cpu_utilization detector"
  type        = bool
  default     = null
}

variable "cpu_utilization_disabled_major" {
  description = "Disable major alerting rule for cpu_utilization detector"
  type        = bool
  default     = null
}

variable "cpu_utilization_threshold_critical" {
  description = "Critical threshold for cpu_utilization detector in %"
  type        = number
  default     = 90
}

variable "cpu_utilization_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "30m"
}

variable "cpu_utilization_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "cpu_utilization_threshold_major" {
  description = "Major threshold for cpu_utilization detector in %"
  type        = number
  default     = 80
}

variable "cpu_utilization_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "5m"
}

variable "cpu_utilization_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# memory_utilization detector

variable "memory_utilization_notifications" {
  description = "Notification recipients list per severity overridden for memory_utilization detector"
  type        = map(list(string))
  default     = {}
}

variable "memory_utilization_aggregation_function" {
  description = "Aggregation function and group by for memory_utilization detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "memory_utilization_transformation_function" {
  description = "Transformation function for memory_utilization detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "memory_utilization_max_delay" {
  description = "Enforce max delay for memory_utilization detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "memory_utilization_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "memory_utilization_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "memory_utilization_disabled" {
  description = "Disable all alerting rules for memory_utilization detector"
  type        = bool
  default     = null
}

variable "memory_utilization_disabled_critical" {
  description = "Disable critical alerting rule for memory_utilization detector"
  type        = bool
  default     = null
}

variable "memory_utilization_disabled_major" {
  description = "Disable major alerting rule for memory_utilization detector"
  type        = bool
  default     = null
}

variable "memory_utilization_threshold_critical" {
  description = "Critical threshold for memory_utilization detector in %"
  type        = number
  default     = 90
}

variable "memory_utilization_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "30m"
}

variable "memory_utilization_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "memory_utilization_threshold_major" {
  description = "Major threshold for memory_utilization detector in %"
  type        = number
  default     = 85
}

variable "memory_utilization_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "5m"
}

variable "memory_utilization_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
