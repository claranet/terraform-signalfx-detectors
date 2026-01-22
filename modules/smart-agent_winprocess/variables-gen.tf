# status detector

variable "status_notifications" {
  description = "Notification recipients list per severity overridden for status detector"
  type        = map(list(string))
  default     = {}
}

variable "status_aggregation_function" {
  description = "Aggregation function and group by for status detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "status_transformation_function" {
  description = "Transformation function for status detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".mean(over='15m')"
}

variable "status_max_delay" {
  description = "Enforce max delay for status detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "status_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "status_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "status_disabled" {
  description = "Disable all alerting rules for status detector"
  type        = bool
  default     = null
}

variable "status_threshold_critical" {
  description = "Critical threshold for status detector"
  type        = number
  default     = 4
}

variable "status_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "status_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
