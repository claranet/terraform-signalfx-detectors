# cpu_utilizations detector

variable "cpu_utilizations_notifications" {
  description = "Notification recipients list per severity overridden for cpu_utilizations detector"
  type        = map(list(string))
  default     = {}
}

variable "cpu_utilizations_aggregation_function" {
  description = "Aggregation function and group by for cpu_utilizations detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "cpu_utilizations_transformation_function" {
  description = "Transformation function for cpu_utilizations detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='30m')"
}

variable "cpu_utilizations_max_delay" {
  description = "Enforce max delay for cpu_utilizations detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "cpu_utilizations_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "cpu_utilizations_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "cpu_utilizations_disabled" {
  description = "Disable all alerting rules for cpu_utilizations detector"
  type        = bool
  default     = null
}

variable "cpu_utilizations_disabled_critical" {
  description = "Disable critical alerting rule for cpu_utilizations detector"
  type        = bool
  default     = null
}

variable "cpu_utilizations_disabled_major" {
  description = "Disable major alerting rule for cpu_utilizations detector"
  type        = bool
  default     = null
}

variable "cpu_utilizations_threshold_critical" {
  description = "Critical threshold for cpu_utilizations detector in %"
  type        = number
  default     = 90
}

variable "cpu_utilizations_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "cpu_utilizations_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "cpu_utilizations_threshold_major" {
  description = "Major threshold for cpu_utilizations detector in %"
  type        = number
  default     = 85
}

variable "cpu_utilizations_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "cpu_utilizations_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# memory_utilizations detector

variable "memory_utilizations_notifications" {
  description = "Notification recipients list per severity overridden for memory_utilizations detector"
  type        = map(list(string))
  default     = {}
}

variable "memory_utilizations_aggregation_function" {
  description = "Aggregation function and group by for memory_utilizations detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "memory_utilizations_transformation_function" {
  description = "Transformation function for memory_utilizations detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='30m')"
}

variable "memory_utilizations_max_delay" {
  description = "Enforce max delay for memory_utilizations detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "memory_utilizations_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "memory_utilizations_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "memory_utilizations_disabled" {
  description = "Disable all alerting rules for memory_utilizations detector"
  type        = bool
  default     = null
}

variable "memory_utilizations_disabled_critical" {
  description = "Disable critical alerting rule for memory_utilizations detector"
  type        = bool
  default     = null
}

variable "memory_utilizations_disabled_major" {
  description = "Disable major alerting rule for memory_utilizations detector"
  type        = bool
  default     = null
}

variable "memory_utilizations_threshold_critical" {
  description = "Critical threshold for memory_utilizations detector in %"
  type        = number
  default     = 95
}

variable "memory_utilizations_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "memory_utilizations_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "memory_utilizations_threshold_major" {
  description = "Major threshold for memory_utilizations detector in %"
  type        = number
  default     = 90
}

variable "memory_utilizations_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "memory_utilizations_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
