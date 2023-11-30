# disk_io_usage detector

variable "disk_io_usage_notifications" {
  description = "Notification recipients list per severity overridden for disk_io_usage detector"
  type        = map(list(string))
  default     = {}
}

variable "disk_io_usage_aggregation_function" {
  description = "Aggregation function and group by for disk_io_usage detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "disk_io_usage_transformation_function" {
  description = "Transformation function for disk_io_usage detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "disk_io_usage_max_delay" {
  description = "Enforce max delay for disk_io_usage detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "disk_io_usage_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "disk_io_usage_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "disk_io_usage_disabled" {
  description = "Disable all alerting rules for disk_io_usage detector"
  type        = bool
  default     = null
}

variable "disk_io_usage_threshold_critical" {
  description = "Critical threshold for disk_io_usage detector in %"
  type        = number
  default     = 95
}

variable "disk_io_usage_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "30m"
}

variable "disk_io_usage_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# disk_weighted_io_usage detector

variable "disk_weighted_io_usage_notifications" {
  description = "Notification recipients list per severity overridden for disk_weighted_io_usage detector"
  type        = map(list(string))
  default     = {}
}

variable "disk_weighted_io_usage_aggregation_function" {
  description = "Aggregation function and group by for disk_weighted_io_usage detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "disk_weighted_io_usage_transformation_function" {
  description = "Transformation function for disk_weighted_io_usage detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "disk_weighted_io_usage_max_delay" {
  description = "Enforce max delay for disk_weighted_io_usage detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "disk_weighted_io_usage_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "disk_weighted_io_usage_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "disk_weighted_io_usage_disabled" {
  description = "Disable all alerting rules for disk_weighted_io_usage detector"
  type        = bool
  default     = null
}

variable "disk_weighted_io_usage_threshold_critical" {
  description = "Critical threshold for disk_weighted_io_usage detector in %"
  type        = number
  default     = 95
}

variable "disk_weighted_io_usage_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "30m"
}

variable "disk_weighted_io_usage_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
