# backup detector

variable "backup_notifications" {
  description = "Notification recipients list per severity overridden for backup detector"
  type        = map(list(string))
  default     = {}
}

variable "backup_aggregation_function" {
  description = "Aggregation function and group by for backup detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "backup_transformation_function" {
  description = "Transformation function for backup detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "backup_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "backup_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "backup_disabled" {
  description = "Disable all alerting rules for backup detector"
  type        = bool
  default     = null
}

variable "backup_threshold_critical" {
  description = "Critical threshold for backup detector in count"
  type        = number
  default     = 0
}

variable "backup_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "1d"
}

variable "backup_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 0.9
}
