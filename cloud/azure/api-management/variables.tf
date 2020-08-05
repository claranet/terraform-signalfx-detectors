# Global

variable "environment" {
  description = "Infrastructure environment"
  type        = string
}

# SignalFx module specific

variable "notifications" {
  description = "Notification recipients list for every detectors"
  type        = list(string)
}

variable "prefixes" {
  description = "Prefixes list to prepend between brackets on every monitors names before environment"
  type        = list(string)
  default     = []
}

variable "filter_custom_includes" {
  description = "List of tags to include when custom filtering is used"
  type        = list(string)
  default     = []
}

variable "filter_custom_excludes" {
  description = "List of tags to exclude when custom filtering is used"
  type        = list(string)
  default     = []
}

variable "detectors_disabled" {
  description = "Disable all detectors in this module"
  type        = bool
  default     = false
}

# Azure api management detectors specific

variable "heartbeat_disabled" {
  description = "Disable all alerting rules for heartbeat detector"
  type        = bool
  default     = null
}

variable "heartbeat_notifications" {
  description = "Notification recipients list for every alerting rules of heartbeat detector"
  type        = list(string)
  default     = []
}

variable "heartbeat_timeframe" {
  description = "Timeframe for system not reporting detector (i.e. \"10m\")"
  type        = string
  default     = "20m"
}

# Failed_requests detectors

variable "failed_requests_disabled" {
  description = "Disable all alerting rules for failed_requests detector"
  type        = bool
  default     = null
}

variable "failed_requests_disabled_critical" {
  description = "Disable critical alerting rule for failed_requests detector"
  type        = bool
  default     = null
}

variable "failed_requests_disabled_warning" {
  description = "Disable warning alerting rule for failed_requests detector"
  type        = bool
  default     = null
}

variable "failed_requests_notifications" {
  description = "Notification recipients list for every alerting rules of failed_requests detector"
  type        = list(string)
  default     = []
}

variable "failed_requests_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of failed_requests detector"
  type        = list(string)
  default     = []
}

variable "failed_requests_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of failed_requests detector"
  type        = list(string)
  default     = []
}

variable "failed_requests_aggregation_function" {
  description = "Aggregation function and group by for failed_requests detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['azure_resource_name', 'azure_resource_group_name', 'azure_region'])"
}

variable "failed_requests_timer" {
  description = "Evaluation window for failed_requests detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "failed_requests_threshold_critical" {
  description = "Critical threshold for failed_requests detector"
  type        = number
  default     = 90
}

variable "failed_requests_threshold_warning" {
  description = "Warning threshold for failed_requests detector"
  type        = number
  default     = 50
}

# Unauthorized_requests detectors

variable "unauthorized_requests_disabled" {
  description = "Disable all alerting rules for unauthorized_requests detector"
  type        = bool
  default     = null
}

variable "unauthorized_requests_disabled_critical" {
  description = "Disable critical alerting rule for unauthorized_requests detector"
  type        = bool
  default     = null
}

variable "unauthorized_requests_disabled_warning" {
  description = "Disable warning alerting rule for unauthorized_requests detector"
  type        = bool
  default     = null
}

variable "unauthorized_requests_notifications" {
  description = "Notification recipients list for every alerting rules of unauthorized_requests detector"
  type        = list(string)
  default     = []
}

variable "unauthorized_requests_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of unauthorized_requests detector"
  type        = list(string)
  default     = []
}

variable "unauthorized_requests_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of unauthorized_requests detector"
  type        = list(string)
  default     = []
}

variable "unauthorized_requests_aggregation_function" {
  description = "Aggregation function and group by for unauthorized_requests detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['azure_resource_name', 'azure_resource_group_name', 'azure_region'])"
}

variable "unauthorized_requests_timer" {
  description = "Evaluation window for unauthorized_requests detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "unauthorized_requests_threshold_critical" {
  description = "Critical threshold for unauthorized_requests detector"
  type        = number
  default     = 90
}

variable "unauthorized_requests_threshold_warning" {
  description = "Warning threshold for unauthorized_requests detector"
  type        = number
  default     = 50
}

# successful_requests detectors

variable "successful_requests_disabled" {
  description = "Disable all alerting rules for successful_requests detector"
  type        = bool
  default     = null
}

variable "successful_requests_disabled_critical" {
  description = "Disable critical alerting rule for successful_requests detector"
  type        = bool
  default     = null
}

variable "successful_requests_disabled_warning" {
  description = "Disable warning alerting rule for successful_requests detector"
  type        = bool
  default     = null
}

variable "successful_requests_notifications" {
  description = "Notification recipients list for every alerting rules of successful_requests detector"
  type        = list(string)
  default     = []
}

variable "successful_requests_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of successful_requests detector"
  type        = list(string)
  default     = []
}

variable "successful_requests_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of successful_requests detector"
  type        = list(string)
  default     = []
}

variable "successful_requests_aggregation_function" {
  description = "Aggregation function and group by for successful_requests detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['azure_resource_name', 'azure_resource_group_name', 'azure_region'])"
}

variable "successful_requests_timer" {
  description = "Evaluation window for successful_requests detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "successful_requests_threshold_critical" {
  description = "Critical threshold for successful_requests detector"
  type        = number
  default     = 10
}

variable "successful_requests_threshold_warning" {
  description = "Warning threshold for successful_requests detector"
  type        = number
  default     = 30
}
