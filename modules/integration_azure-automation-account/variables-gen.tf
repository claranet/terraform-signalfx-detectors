# jobs detector

variable "jobs_notifications" {
  description = "Notification recipients list per severity overridden for jobs detector"
  type        = map(list(string))
  default     = {}
}

variable "jobs_aggregation_function" {
  description = "Aggregation function and group by for jobs detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "jobs_transformation_function" {
  description = "Transformation function for jobs detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "jobs_max_delay" {
  description = "Enforce max delay for jobs detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "jobs_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "jobs_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "jobs_disabled" {
  description = "Disable all alerting rules for jobs detector"
  type        = bool
  default     = null
}

variable "jobs_threshold_critical" {
  description = "Critical threshold for jobs detector"
  type        = number
  default     = 1
}

variable "jobs_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "1h"
}

variable "jobs_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
