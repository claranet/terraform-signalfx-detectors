# Global

variable "environment" {
  description = "Infrastructure environment"
  type        = string
}

# SignalFx module specific

variable "notifications" {
  description = "Notification recipients list for every detectors"
  type        = list
}

variable "prefixes" {
  description = "Prefixes list to prepend between brackets on every monitors names before environment"
  type        = list
  default     = []
}

variable "filter_custom_includes" {
  description = "List of tags to include when custom filtering is used"
  type        = list
  default     = []
}

variable "filter_custom_excludes" {
  description = "List of tags to exclude when custom filtering is used"
  type        = list
  default     = []
}

variable "detectors_disabled" {
  description = "Disable all detectors in this module"
  type        = bool
  default     = false
}

# Azure stream analytics detectors specific

variable "heartbeat_disabled" {
  description = "Disable all alerting rules for heartbeat detector"
  type        = bool
  default     = null
}

variable "heartbeat_notifications" {
  description = "Notification recipients list for every alerting rules of heartbeat detector"
  type        = list
  default     = []
}

variable "heartbeat_timeframe" {
  description = "Timeframe for system not reporting detector (i.e. \"10m\")"
  type        = string
  default     = "20m"
}

# SU_utilization detectors

variable "su_utilization_disabled" {
  description = "Disable all alerting rules for su_utilization detector"
  type        = bool
  default     = null
}

variable "su_utilization_disabled_critical" {
  description = "Disable critical alerting rule for su_utilization detector"
  type        = bool
  default     = null
}

variable "su_utilization_disabled_warning" {
  description = "Disable warning alerting rule for su_utilization detector"
  type        = bool
  default     = null
}

variable "su_utilization_notifications" {
  description = "Notification recipients list for every alerting rules of su_utilization detector"
  type        = list
  default     = []
}

variable "su_utilization_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of su_utilization detector"
  type        = list
  default     = []
}

variable "su_utilization_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of su_utilization detector"
  type        = list
  default     = []
}

variable "su_utilization_aggregation_function" {
  description = "Aggregation function and group by for su_utilization detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['azure_resource_name', 'azure_resource_group_name', 'azure_region'])"
}

variable "su_utilization_transformation_function" {
  description = "Transformation function for su_utilization detector (mean, min, max)"
  type        = string
  default     = "min"
}

variable "su_utilization_transformation_window" {
  description = "Transformation window for su_utilization detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "su_utilization_threshold_critical" {
  description = "Critical threshold for su_utilization detector"
  type        = number
  default     = 95
}

variable "su_utilization_threshold_warning" {
  description = "Warning threshold for su_utilization detector"
  type        = number
  default     = 80
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
  type        = list
  default     = []
}

variable "failed_requests_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of failed_requests detector"
  type        = list
  default     = []
}

variable "failed_requests_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of failed_requests detector"
  type        = list
  default     = []
}

variable "failed_requests_aggregation_function" {
  description = "Aggregation function and group by for failed_requests detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['azure_resource_name', 'azure_resource_group_name', 'azure_region'])"
}

variable "failed_requests_transformation_function" {
  description = "Transformation function for failed_requests detector (mean, min, max)"
  type        = string
  default     = "min"
}

variable "failed_requests_transformation_window" {
  description = "Transformation window for failed_requests detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "failed_requests_threshold_critical" {
  description = "Critical threshold for failed_requests detector"
  type        = number
  default     = 10
}

variable "failed_requests_threshold_warning" {
  description = "Warning threshold for failed_requests detector"
  type        = number
  default     = 0
}

variable "failed_requests_aperiodic_duration" {
  description = "Duration for the failed_requests block"
  type        = string
  default     = "10m"
}

variable "failed_requests_aperiodic_percentage" {
  description = "Percentage for the failed_requests block"
  type        = number
  default     = 0.9
}

variable "failed_requests_clear_duration" {
  description = "Duration for the failed_requests clear condition"
  type        = string
  default     = "15m"
}

# Conversion_errors detectors

variable "conversion_errors_disabled" {
  description = "Disable all alerting rules for conversion_errors detector"
  type        = bool
  default     = null
}

variable "conversion_errors_disabled_critical" {
  description = "Disable critical alerting rule for conversion_errors detector"
  type        = bool
  default     = null
}

variable "conversion_errors_disabled_warning" {
  description = "Disable warning alerting rule for conversion_errors detector"
  type        = bool
  default     = null
}

variable "conversion_errors_notifications" {
  description = "Notification recipients list for every alerting rules of conversion_errors detector"
  type        = list
  default     = []
}

variable "conversion_errors_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of conversion_errors detector"
  type        = list
  default     = []
}

variable "conversion_errors_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of conversion_errors detector"
  type        = list
  default     = []
}

variable "conversion_errors_aggregation_function" {
  description = "Aggregation function and group by for conversion_errors detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['azure_resource_name', 'azure_resource_group_name', 'azure_region'])"
}

variable "conversion_errors_transformation_function" {
  description = "Transformation function for conversion_errors detector (mean, min, max)"
  type        = string
  default     = "min"
}

variable "conversion_errors_transformation_window" {
  description = "Transformation window for conversion_errors detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "conversion_errors_threshold_critical" {
  description = "Critical threshold for conversion_errors detector"
  type        = number
  default     = 10
}

variable "conversion_errors_threshold_warning" {
  description = "Warning threshold for conversion_errors detector"
  type        = number
  default     = 0
}

# Runtime_errors detectors

variable "runtime_errors_disabled" {
  description = "Disable all alerting rules for runtime_errors detector"
  type        = bool
  default     = null
}

variable "runtime_errors_disabled_critical" {
  description = "Disable critical alerting rule for runtime_errors detector"
  type        = bool
  default     = null
}

variable "runtime_errors_disabled_warning" {
  description = "Disable warning alerting rule for runtime_errors detector"
  type        = bool
  default     = null
}

variable "runtime_errors_notifications" {
  description = "Notification recipients list for every alerting rules of runtime_errors detector"
  type        = list
  default     = []
}

variable "runtime_errors_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of runtime_errors detector"
  type        = list
  default     = []
}

variable "runtime_errors_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of runtime_errors detector"
  type        = list
  default     = []
}

variable "runtime_errors_aggregation_function" {
  description = "Aggregation function and group by for runtime_errors detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['azure_resource_name', 'azure_resource_group_name', 'azure_region'])"
}

variable "runtime_errors_transformation_function" {
  description = "Transformation function for runtime_errors detector (mean, min, max)"
  type        = string
  default     = "min"
}

variable "runtime_errors_transformation_window" {
  description = "Transformation window for runtime_errors detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "runtime_errors_threshold_critical" {
  description = "Critical threshold for runtime_errors detector"
  type        = number
  default     = 10
}

variable "runtime_errors_threshold_warning" {
  description = "Warning threshold for runtime_errors detector"
  type        = number
  default     = 0
}
