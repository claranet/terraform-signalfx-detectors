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

# Azure api management detectors specific

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
  default     = ".mean(by=['azure_region', 'azure_resource_id', 'azure_resource_name'])"
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
  default     = 90
}

variable "failed_requests_threshold_warning" {
  description = "Warning threshold for failed_requests detector"
  type        = number
  default     = 50
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

# Other_requests detectors

variable "other_requests_disabled" {
  description = "Disable all alerting rules for other_requests detector"
  type        = bool
  default     = null
}

variable "other_requests_disabled_critical" {
  description = "Disable critical alerting rule for other_requests detector"
  type        = bool
  default     = null
}

variable "other_requests_disabled_warning" {
  description = "Disable warning alerting rule for other_requests detector"
  type        = bool
  default     = null
}

variable "other_requests_notifications" {
  description = "Notification recipients list for every alerting rules of other_requests detector"
  type        = list
  default     = []
}

variable "other_requests_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of other_requests detector"
  type        = list
  default     = []
}

variable "other_requests_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of other_requests detector"
  type        = list
  default     = []
}

variable "other_requests_aggregation_function" {
  description = "Aggregation function and group by for other_requests detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['azure_region', 'azure_resource_id', 'azure_resource_name'])"
}

variable "other_requests_transformation_function" {
  description = "Transformation function for other_requests detector (mean, min, max)"
  type        = string
  default     = "min"
}

variable "other_requests_transformation_window" {
  description = "Transformation window for other_requests detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "other_requests_threshold_critical" {
  description = "Critical threshold for other_requests detector"
  type        = number
  default     = 90
}

variable "other_requests_threshold_warning" {
  description = "Warning threshold for other_requests detector"
  type        = number
  default     = 50
}

variable "other_requests_aperiodic_duration" {
  description = "Duration for the other_requests block"
  type        = string
  default     = "10m"
}

variable "other_requests_aperiodic_percentage" {
  description = "Percentage for the other_requests block"
  type        = number
  default     = 0.9
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
  type        = list
  default     = []
}

variable "unauthorized_requests_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of unauthorized_requests detector"
  type        = list
  default     = []
}

variable "unauthorized_requests_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of unauthorized_requests detector"
  type        = list
  default     = []
}

variable "unauthorized_requests_aggregation_function" {
  description = "Aggregation function and group by for unauthorized_requests detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['azure_region', 'azure_resource_id', 'azure_resource_name'])"
}

variable "unauthorized_requests_transformation_function" {
  description = "Transformation function for unauthorized_requests detector (mean, min, max)"
  type        = string
  default     = "min"
}

variable "unauthorized_requests_transformation_window" {
  description = "Transformation window for unauthorized_requests detector (i.e. 5m, 20m, 1h, 1d)"
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

variable "unauthorized_requests_aperiodic_duration" {
  description = "Duration for the unauthorized_requests block"
  type        = string
  default     = "10m"
}

variable "unauthorized_requests_aperiodic_percentage" {
  description = "Percentage for the unauthorized_requests block"
  type        = number
  default     = 0.9
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
  type        = list
  default     = []
}

variable "successful_requests_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of successful_requests detector"
  type        = list
  default     = []
}

variable "successful_requests_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of successful_requests detector"
  type        = list
  default     = []
}

variable "successful_requests_aggregation_function" {
  description = "Aggregation function and group by for successful_requests detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['azure_region', 'azure_resource_id', 'azure_resource_name'])"
}

variable "successful_requests_transformation_function" {
  description = "Transformation function for successful_requests detector (mean, min, max)"
  type        = string
  default     = "max"
}

variable "successful_requests_transformation_window" {
  description = "Transformation window for successful_requests detector (i.e. 5m, 20m, 1h, 1d)"
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
