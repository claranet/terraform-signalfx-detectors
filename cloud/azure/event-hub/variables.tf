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

# Azure eventhub detectors specific

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

# Eventhub_failed_requests detectors

variable "eventhub_failed_requests_disabled" {
  description = "Disable all alerting rules for eventhub_failed_requests detector"
  type        = bool
  default     = null
}

variable "eventhub_failed_requests_disabled_critical" {
  description = "Disable critical alerting rule for eventhub_failed_requests detector"
  type        = bool
  default     = null
}

variable "eventhub_failed_requests_disabled_warning" {
  description = "Disable warning alerting rule for eventhub_failed_requests detector"
  type        = bool
  default     = null
}

variable "eventhub_failed_requests_notifications" {
  description = "Notification recipients list for every alerting rules of eventhub_failed_requests detector"
  type        = list(string)
  default     = []
}

variable "eventhub_failed_requests_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of eventhub_failed_requests detector"
  type        = list(string)
  default     = []
}

variable "eventhub_failed_requests_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of eventhub_failed_requests detector"
  type        = list(string)
  default     = []
}

variable "eventhub_failed_requests_aggregation_function" {
  description = "Aggregation function and group by for eventhub_failed_requests detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['azure_resource_name', 'azure_resource_group_name', 'azure_region'])"
}

variable "eventhub_failed_requests_transformation_function" {
  description = "Transformation function for eventhub_failed_requests detector (mean, min, max)"
  type        = string
  default     = "min"
}

variable "eventhub_failed_requests_transformation_window" {
  description = "Transformation window for eventhub_failed_requests detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "eventhub_failed_requests_threshold_critical" {
  description = "Critical threshold for eventhub_failed_requests detector"
  type        = number
  default     = 90
}

variable "eventhub_failed_requests_threshold_warning" {
  description = "Warning threshold for eventhub_failed_requests detector"
  type        = number
  default     = 50
}

variable "eventhub_failed_requests_aperiodic_duration" {
  description = "Duration for the eventhub_failed_requests block"
  type        = string
  default     = "10m"
}

variable "eventhub_failed_requests_aperiodic_percentage" {
  description = "Percentage for the eventhub_failed_requests block"
  type        = number
  default     = 0.9
}

# Eventhub_errors detectors

variable "eventhub_errors_disabled" {
  description = "Disable all alerting rules for eventhub_errors detector"
  type        = bool
  default     = null
}

variable "eventhub_errors_disabled_critical" {
  description = "Disable critical alerting rule for eventhub_errors detector"
  type        = bool
  default     = null
}

variable "eventhub_errors_disabled_warning" {
  description = "Disable warning alerting rule for eventhub_errors detector"
  type        = bool
  default     = null
}

variable "eventhub_errors_notifications" {
  description = "Notification recipients list for every alerting rules of eventhub_errors detector"
  type        = list(string)
  default     = []
}

variable "eventhub_errors_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of eventhub_errors detector"
  type        = list(string)
  default     = []
}

variable "eventhub_errors_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of eventhub_errors detector"
  type        = list(string)
  default     = []
}

variable "eventhub_errors_aggregation_function" {
  description = "Aggregation function and group by for eventhub_errors detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['azure_resource_name', 'azure_resource_group_name', 'azure_region'])"
}

variable "eventhub_errors_transformation_function" {
  description = "Transformation function for eventhub_errors detector (mean, min, max)"
  type        = string
  default     = "min"
}

variable "eventhub_errors_transformation_window" {
  description = "Transformation window for eventhub_errors detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "eventhub_errors_threshold_critical" {
  description = "Critical threshold for eventhub_errors detector"
  type        = number
  default     = 90
}

variable "eventhub_errors_threshold_warning" {
  description = "Warning threshold for eventhub_errors detector"
  type        = number
  default     = 50
}

variable "eventhub_errors_aperiodic_duration" {
  description = "Duration for the eventhub_errors block"
  type        = string
  default     = "10m"
}

variable "eventhub_errors_aperiodic_percentage" {
  description = "Percentage for the eventhub_errors block"
  type        = number
  default     = 0.9
}
