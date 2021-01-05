# check_memory detector

variable "check_memory_notifications" {
  description = "Notification recipients list per severity overridden for check_memory detector"
  type        = map(list(string))
  default     = {}
}

variable "check_memory_aggregation_function" {
  description = "Aggregation function and group by for check_memory detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "check_memory_transformation_function" {
  description = "Transformation function for check_memory detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='15m')"
}

variable "check_memory_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "check_memory_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "check_memory_disabled" {
  description = "Disable all alerting rules for check_memory detector"
  type        = bool
  default     = null
}

variable "check_memory_disabled_critical" {
  description = "Disable critical alerting rule for check_memory detector"
  type        = bool
  default     = null
}

variable "check_memory_disabled_major" {
  description = "Disable major alerting rule for check_memory detector"
  type        = bool
  default     = null
}

variable "check_memory_threshold_critical" {
  description = "Critical threshold for check_memory detector in %"
  type        = number
  default     = 90
}

variable "check_memory_threshold_major" {
  description = "Major threshold for check_memory detector in %"
  type        = number
  default     = 70
}

