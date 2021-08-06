# health_checker_value detector

variable "health_checker_value_notifications" {
  description = "Notification recipients list per severity overridden for health_checker_value detector"
  type        = map(list(string))
  default     = {}
}

variable "health_checker_value_transformation_function" {
  description = "Transformation function for health_checker_value detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "health_checker_value_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "health_checker_value_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "health_checker_value_disabled" {
  description = "Disable all alerting rules for health_checker_value detector"
  type        = bool
  default     = null
}

variable "health_checker_value_threshold_critical" {
  description = "Critical threshold for health_checker_value detector"
  type        = number
  default     = 1
}

# health_checker_status detector

variable "health_checker_status_notifications" {
  description = "Notification recipients list per severity overridden for health_checker_status detector"
  type        = map(list(string))
  default     = {}
}

variable "health_checker_status_transformation_function" {
  description = "Transformation function for health_checker_status detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "health_checker_status_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "health_checker_status_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "health_checker_status_disabled" {
  description = "Disable all alerting rules for health_checker_status detector"
  type        = bool
  default     = null
}

variable "health_checker_status_threshold_critical" {
  description = "Critical threshold for health_checker_status detector"
  type        = number
  default     = 200
}

