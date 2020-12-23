# Module specific

# status_check detector

variable "status_check_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "status_check_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "status_check_disabled" {
  description = "Disable all alerting rules for status_check detector"
  type        = bool
  default     = null
}

variable "status_check_disabled_critical" {
  description = "Disable critical alerting rule for status_check detector"
  type        = bool
  default     = null
}

variable "status_check_disabled_warning" {
  description = "Disable warning alerting rule for status_check detector"
  type        = bool
  default     = null
}

variable "status_check_disabled_major" {
  description = "Disable major alerting rule for status_check detector"
  type        = bool
  default     = null
}

variable "status_check_notifications" {
  description = "Notification recipients list per severity overridden for status_check detector"
  type        = map(list(string))
  default     = {}
}

variable "status_check_aggregation_function" {
  description = "Aggregation function and group by for status_check detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "status_check_transformation_function" {
  description = "Transformation function for status_check detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "status_check_lasting_duration_seconds" {
  description = "Minimum duration that conditions must be true before raising alert (in seconds)"
  type        = string
  default     = "900"
}

