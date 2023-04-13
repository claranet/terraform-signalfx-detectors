# failed_updates detector

variable "failed_updates_notifications" {
  description = "Notification recipients list per severity overridden for failed_updates detector"
  type        = map(list(string))
  default     = {}
}

variable "failed_updates_aggregation_function" {
  description = "Aggregation function and group by for failed_updates detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "failed_updates_transformation_function" {
  description = "Transformation function for failed_updates detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "failed_updates_max_delay" {
  description = "Enforce max delay for failed_updates detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = 900
}

variable "failed_updates_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "failed_updates_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "failed_updates_disabled" {
  description = "Disable all alerting rules for failed_updates detector"
  type        = bool
  default     = null
}

variable "failed_updates_threshold_critical" {
  description = "Critical threshold for failed_updates detector"
  type        = number
  default     = 0
}

variable "failed_updates_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "2h"
}

variable "failed_updates_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
