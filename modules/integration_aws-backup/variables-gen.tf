# backup_failed detector

variable "backup_failed_notifications" {
  description = "Notification recipients list per severity overridden for backup_failed detector"
  type        = map(list(string))
  default     = {}
}

variable "backup_failed_aggregation_function" {
  description = "Aggregation function and group by for backup_failed detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "backup_failed_transformation_function" {
  description = "Transformation function for backup_failed detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='1d')"
}

variable "backup_failed_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "backup_failed_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "backup_failed_disabled" {
  description = "Disable all alerting rules for backup_failed detector"
  type        = bool
  default     = null
}

variable "backup_failed_threshold_critical" {
  description = "Critical threshold for backup_failed detector in count"
  type        = number
  default     = 0
}

variable "backup_failed_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "1d"
}

variable "backup_failed_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 0.9
}
# backup_not_started detector

variable "backup_not_started_notifications" {
  description = "Notification recipients list per severity overridden for backup_not_started detector"
  type        = map(list(string))
  default     = {}
}

variable "backup_not_started_aggregation_function" {
  description = "Aggregation function and group by for backup_not_started detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "backup_not_started_transformation_function" {
  description = "Transformation function for backup_not_started detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='1h')"
}

variable "backup_not_started_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "backup_not_started_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "backup_not_started_disabled" {
  description = "Disable all alerting rules for backup_not_started detector"
  type        = bool
  default     = null
}

variable "backup_not_started_threshold_critical" {
  description = "Critical threshold for backup_not_started detector in count"
  type        = number
  default     = 0
}

variable "backup_not_started_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "1d"
}

variable "backup_not_started_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 0.9
}
