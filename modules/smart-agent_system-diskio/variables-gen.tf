# disk_iotime detector

variable "disk_iotime_notifications" {
  description = "Notification recipients list per severity overridden for disk_iotime detector"
  type        = map(list(string))
  default     = {}
}

variable "disk_iotime_aggregation_function" {
  description = "Aggregation function and group by for disk_iotime detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "disk_iotime_transformation_function" {
  description = "Transformation function for disk_iotime detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "disk_iotime_max_delay" {
  description = "Enforce max delay for disk_iotime detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "disk_iotime_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "disk_iotime_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "disk_iotime_disabled" {
  description = "Disable all alerting rules for disk_iotime detector"
  type        = bool
  default     = null
}

variable "disk_iotime_disabled_critical" {
  description = "Disable critical alerting rule for disk_iotime detector"
  type        = bool
  default     = null
}

variable "disk_iotime_disabled_major" {
  description = "Disable major alerting rule for disk_iotime detector"
  type        = bool
  default     = null
}

variable "disk_iotime_threshold_critical" {
  description = "Critical threshold for disk_iotime detector in %"
  type        = number
  default     = 95
}

variable "disk_iotime_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "30m"
}

variable "disk_iotime_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "disk_iotime_threshold_major" {
  description = "Major threshold for disk_iotime detector in %"
  type        = number
  default     = 70
}

variable "disk_iotime_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "30m"
}

variable "disk_iotime_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# disk_weightediotime detector

variable "disk_weightediotime_notifications" {
  description = "Notification recipients list per severity overridden for disk_weightediotime detector"
  type        = map(list(string))
  default     = {}
}

variable "disk_weightediotime_aggregation_function" {
  description = "Aggregation function and group by for disk_weightediotime detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "disk_weightediotime_transformation_function" {
  description = "Transformation function for disk_weightediotime detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "disk_weightediotime_max_delay" {
  description = "Enforce max delay for disk_weightediotime detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "disk_weightediotime_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "disk_weightediotime_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "disk_weightediotime_disabled" {
  description = "Disable all alerting rules for disk_weightediotime detector"
  type        = bool
  default     = null
}

variable "disk_weightediotime_disabled_critical" {
  description = "Disable critical alerting rule for disk_weightediotime detector"
  type        = bool
  default     = null
}

variable "disk_weightediotime_disabled_major" {
  description = "Disable major alerting rule for disk_weightediotime detector"
  type        = bool
  default     = null
}

variable "disk_weightediotime_threshold_critical" {
  description = "Critical threshold for disk_weightediotime detector in %"
  type        = number
  default     = 95
}

variable "disk_weightediotime_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "30m"
}

variable "disk_weightediotime_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "disk_weightediotime_threshold_major" {
  description = "Major threshold for disk_weightediotime detector in %"
  type        = number
  default     = 70
}

variable "disk_weightediotime_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "30m"
}

variable "disk_weightediotime_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
