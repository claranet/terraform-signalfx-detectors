# failed_jobs detector

variable "failed_jobs_notifications" {
  description = "Notification recipients list per severity overridden for failed_jobs detector"
  type        = map(list(string))
  default     = {}
}

variable "failed_jobs_aggregation_function" {
  description = "Aggregation function and group by for failed_jobs detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['runbook'])"
}

variable "failed_jobs_transformation_function" {
  description = "Transformation function for failed_jobs detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".max(over='1h')"
}

variable "failed_jobs_max_delay" {
  description = "Enforce max delay for failed_jobs detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "failed_jobs_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "failed_jobs_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "failed_jobs_disabled" {
  description = "Disable all alerting rules for failed_jobs detector"
  type        = bool
  default     = null
}

variable "failed_jobs_threshold_critical" {
  description = "Critical threshold for failed_jobs detector"
  type        = number
  default     = 0
}

variable "failed_jobs_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "failed_jobs_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
