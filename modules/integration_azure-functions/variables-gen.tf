# errors detector

variable "errors_notifications" {
  description = "Notification recipients list per severity overridden for errors detector"
  type        = map(list(string))
  default     = {}
}

variable "errors_aggregation_function" {
  description = "Aggregation function and group by for errors detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "errors_transformation_function" {
  description = "Transformation function for errors detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "errors_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "errors_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "errors_disabled" {
  description = "Disable all alerting rules for errors detector"
  type        = bool
  default     = null
}

variable "errors_disabled_critical" {
  description = "Disable critical alerting rule for errors detector"
  type        = bool
  default     = null
}

variable "errors_disabled_major" {
  description = "Disable major alerting rule for errors detector"
  type        = bool
  default     = null
}

variable "errors_threshold_critical" {
  description = "Critical threshold for errors detector"
  type        = number
  default     = 30
}

variable "errors_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "900s"
}

variable "errors_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1.0
}

variable "errors_threshold_major" {
  description = "Major threshold for errors detector"
  type        = number
  default     = 0
}

variable "errors_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "900s"
}

variable "errors_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1.0
}

