# max_capacity detector

variable "max_capacity_notifications" {
  description = "Notification recipients list per severity overridden for max_capacity detector"
  type        = map(list(string))
  default     = {}
}

variable "max_capacity_aggregation_function" {
  description = "Aggregation function and group by for max_capacity detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "max_capacity_transformation_function" {
  description = "Transformation function for max_capacity detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "max_capacity_above_filter" {
  description = "Transformation function for max_capacity detector (i.e. \".mean(over='5m')\")"
  type        = number
  default     = 2
}

variable "max_capacity_max_delay" {
  description = "Enforce max delay for max_capacity detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "max_capacity_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "max_capacity_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "max_capacity_disabled" {
  description = "Disable all alerting rules for max_capacity detector"
  type        = bool
  default     = null
}

variable "max_capacity_disabled_critical" {
  description = "Disable critical alerting rule for max_capacity detector"
  type        = bool
  default     = null
}

variable "max_capacity_disabled_major" {
  description = "Disable major alerting rule for max_capacity detector"
  type        = bool
  default     = null
}

variable "max_capacity_threshold_critical" {
  description = "Critical threshold for max_capacity detector in %"
  type        = number
  default     = 90
}

variable "max_capacity_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "5m"
}

variable "max_capacity_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 0.9
}
variable "max_capacity_threshold_major" {
  description = "Major threshold for max_capacity detector in %"
  type        = number
  default     = 80
}

variable "max_capacity_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "5m"
}

variable "max_capacity_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 0.9
}

