# throttled_requests detector

variable "throttled_requests_notifications" {
  description = "Notification recipients list per severity overridden for throttled_requests detector"
  type        = map(list(string))
  default     = {}
}

variable "throttled_requests_aggregation_function" {
  description = "Aggregation function and group by for throttled_requests detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['azure_resource_name', 'azure_resource_group_name', 'azure_region'])"
}

variable "throttled_requests_transformation_function" {
  description = "Transformation function for throttled_requests detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='15m')"
}

variable "throttled_requests_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "throttled_requests_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "throttled_requests_disabled" {
  description = "Disable all alerting rules for throttled_requests detector"
  type        = bool
  default     = null
}

variable "throttled_requests_disabled_critical" {
  description = "Disable critical alerting rule for throttled_requests detector"
  type        = bool
  default     = null
}

variable "throttled_requests_disabled_major" {
  description = "Disable major alerting rule for throttled_requests detector"
  type        = bool
  default     = null
}

variable "throttled_requests_disabled_warning" {
  description = "Disable warning alerting rule for throttled_requests detector"
  type        = bool
  default     = null
}

variable "throttled_requests_threshold_critical" {
  description = "Critical threshold for throttled_requests detector in %"
  type        = number
  default     = 30
}

variable "throttled_requests_threshold_major" {
  description = "Major threshold for throttled_requests detector in %"
  type        = number
  default     = 15
}

variable "throttled_requests_threshold_warning" {
  description = "Warning threshold for throttled_requests detector in %"
  type        = number
  default     = 0
}

