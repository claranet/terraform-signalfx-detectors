# dbload detector

variable "dbload_notifications" {
  description = "Notification recipients list per severity overridden for dbload detector"
  type        = map(list(string))
  default     = {}
}

variable "dbload_aggregation_function" {
  description = "Aggregation function and group by for dbload detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "dbload_transformation_function" {
  description = "Transformation function for dbload detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "dbload_max_delay" {
  description = "Enforce max delay for dbload detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "dbload_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "dbload_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "dbload_disabled" {
  description = "Disable all alerting rules for dbload detector"
  type        = bool
  default     = null
}

variable "dbload_disabled_critical" {
  description = "Disable critical alerting rule for dbload detector"
  type        = bool
  default     = null
}

variable "dbload_disabled_major" {
  description = "Disable major alerting rule for dbload detector"
  type        = bool
  default     = null
}

variable "dbload_threshold_critical" {
  description = "Critical threshold for dbload detector"
  type        = number
  default     = 16
}

variable "dbload_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "5m"
}

variable "dbload_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "dbload_threshold_major" {
  description = "Major threshold for dbload detector"
  type        = number
  default     = 8
}

variable "dbload_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "5m"
}

variable "dbload_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
