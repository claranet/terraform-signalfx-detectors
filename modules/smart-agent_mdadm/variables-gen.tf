# disk_failed detector

variable "disk_failed_notifications" {
  description = "Notification recipients list per severity overridden for disk_failed detector"
  type        = map(list(string))
  default     = {}
}

variable "disk_failed_aggregation_function" {
  description = "Aggregation function and group by for disk_failed detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "disk_failed_transformation_function" {
  description = "Transformation function for disk_failed detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='1m')"
}

variable "disk_failed_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "disk_failed_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "disk_failed_disabled" {
  description = "Disable all alerting rules for disk_failed detector"
  type        = bool
  default     = null
}

variable "disk_failed_disabled_critical" {
  description = "Disable critical alerting rule for disk_failed detector"
  type        = bool
  default     = null
}

variable "disk_failed_disabled_major" {
  description = "Disable major alerting rule for disk_failed detector"
  type        = bool
  default     = null
}

variable "disk_failed_threshold_critical" {
  description = "Critical threshold for disk_failed detector"
  type        = number
  default     = 1
}

variable "disk_failed_threshold_major" {
  description = "Major threshold for disk_failed detector"
  type        = number
  default     = 0
}

# disk_missing detector

variable "disk_missing_notifications" {
  description = "Notification recipients list per severity overridden for disk_missing detector"
  type        = map(list(string))
  default     = {}
}

variable "disk_missing_aggregation_function" {
  description = "Aggregation function and group by for disk_missing detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "disk_missing_transformation_function" {
  description = "Transformation function for disk_missing detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='1m')"
}

variable "disk_missing_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "disk_missing_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "disk_missing_disabled" {
  description = "Disable all alerting rules for disk_missing detector"
  type        = bool
  default     = null
}

variable "disk_missing_disabled_critical" {
  description = "Disable critical alerting rule for disk_missing detector"
  type        = bool
  default     = null
}

variable "disk_missing_disabled_major" {
  description = "Disable major alerting rule for disk_missing detector"
  type        = bool
  default     = null
}

variable "disk_missing_threshold_critical" {
  description = "Critical threshold for disk_missing detector"
  type        = number
  default     = 1
}

variable "disk_missing_threshold_major" {
  description = "Major threshold for disk_missing detector"
  type        = number
  default     = 0
}

