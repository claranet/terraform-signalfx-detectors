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

# AWS Lambda detectors specific

# Pct_errors detectors

variable "pct_errors_disabled" {
  description = "Disable all alerting rules for pct_errors detector"
  type        = bool
  default     = null
}

variable "pct_errors_disabled_critical" {
  description = "Disable critical alerting rule for pct_errors detector"
  type        = bool
  default     = null
}

variable "pct_errors_disabled_warning" {
  description = "Disable warning alerting rule for pct_errors detector"
  type        = bool
  default     = null
}

variable "pct_errors_notifications" {
  description = "Notification recipients list for every alerting rules of pct_errors detector"
  type        = list
  default     = []
}

variable "pct_errors_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of pct_errors detector"
  type        = list
  default     = []
}

variable "pct_errors_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of pct_errors detector"
  type        = list
  default     = []
}

variable "pct_errors_aggregation_function" {
  description = "Aggregation function and group by for pct_errors detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".sum(by=['FunctionName'])"
}

variable "pct_errors_transformation_function" {
  description = "Transformation function for pct_errors detector (mean, min, max)"
  type        = string
  default     = "sum"
}

variable "pct_errors_transformation_window" {
  description = "Transformation window for pct_errors detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "1h"
}

variable "pct_errors_threshold_critical" {
  description = "Critical threshold for pct_errors detector"
  type        = number
  default     = 30
}

variable "pct_errors_threshold_warning" {
  description = "Warning threshold for pct_errors detector"
  type        = number
  default     = 20
}

variable "pct_errors_aperiodic_duration" {
  description = "Duration for the pct_errors block"
  type        = string
  default     = "10m"
}

variable "pct_errors_aperiodic_percentage" {
  description = "Percentage for the pct_errors block"
  type        = number
  default     = 0.9
}

# Errors detectors

variable "errors_disabled" {
  description = "Disable all alerting rules for errors detector"
  type        = bool
  default     = true
}

variable "errors_disabled_critical" {
  description = "Disable critical alerting rule for errors detector"
  type        = bool
  default     = null
}

variable "errors_disabled_warning" {
  description = "Disable warning alerting rule for errors detector"
  type        = bool
  default     = null
}

variable "errors_notifications" {
  description = "Notification recipients list for every alerting rules of errors detector"
  type        = list
  default     = []
}

variable "errors_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of errors detector"
  type        = list
  default     = []
}

variable "errors_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of errors detector"
  type        = list
  default     = []
}

variable "errors_aggregation_function" {
  description = "Aggregation function and group by for errors detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".sum(by=['FunctionName'])"
}

variable "errors_transformation_function" {
  description = "Transformation function for errors detector (mean, min, max)"
  type        = string
  default     = "sum"
}

variable "errors_transformation_window" {
  description = "Transformation window for errors detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "1h"
}

variable "errors_threshold_critical" {
  description = "Critical threshold for errors detector"
  type        = number
  default     = 3
}

variable "errors_threshold_warning" {
  description = "Warning threshold for errors detector"
  type        = number
  default     = 1
}

variable "errors_aperiodic_duration" {
  description = "Duration for the errors block"
  type        = string
  default     = "10m"
}

variable "errors_aperiodic_percentage" {
  description = "Percentage for the errors block"
  type        = number
  default     = 0.9
}

# Throttles detectors

variable "throttles_disabled" {
  description = "Disable all alerting rules for throttles detector"
  type        = bool
  default     = null
}

variable "throttles_disabled_critical" {
  description = "Disable critical alerting rule for throttles detector"
  type        = bool
  default     = null
}

variable "throttles_disabled_warning" {
  description = "Disable warning alerting rule for throttles detector"
  type        = bool
  default     = null
}

variable "throttles_notifications" {
  description = "Notification recipients list for every alerting rules of throttles detector"
  type        = list
  default     = []
}

variable "throttles_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of throttles detector"
  type        = list
  default     = []
}

variable "throttles_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of throttles detector"
  type        = list
  default     = []
}

variable "throttles_aggregation_function" {
  description = "Aggregation function and group by for throttles detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".sum(by=['FunctionName'])"
}

variable "throttles_transformation_function" {
  description = "Transformation function for throttles detector (mean, min, max)"
  type        = string
  default     = "sum"
}

variable "throttles_transformation_window" {
  description = "Transformation window for throttles detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "1h"
}

variable "throttles_threshold_critical" {
  description = "Critical threshold for throttles detector"
  type        = number
  default     = 3
}

variable "throttles_threshold_warning" {
  description = "Warning threshold for throttles detector"
  type        = number
  default     = 1
}

variable "throttles_aperiodic_duration" {
  description = "Duration for the throttles block"
  type        = string
  default     = "10m"
}

variable "throttles_aperiodic_percentage" {
  description = "Percentage for the throttles block"
  type        = number
  default     = 0.9
}

# invocations detectors

variable "invocations_disabled" {
  description = "Disable all alerting rules for invocations detector"
  type        = bool
  default     = true
}

variable "invocations_disabled_critical" {
  description = "Disable critical alerting rule for invocations detector"
  type        = bool
  default     = null
}

variable "invocations_disabled_warning" {
  description = "Disable warning alerting rule for invocations detector"
  type        = bool
  default     = null
}

variable "invocations_notifications" {
  description = "Notification recipients list for every alerting rules of invocations detector"
  type        = list
  default     = []
}

variable "invocations_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of invocations detector"
  type        = list
  default     = []
}

variable "invocations_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of invocations detector"
  type        = list
  default     = []
}

variable "invocations_aggregation_function" {
  description = "Aggregation function and group by for invocations detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".sum(by=['FunctionName'])"
}

variable "invocations_transformation_function" {
  description = "Transformation function for invocations detector (mean, min, max)"
  type        = string
  default     = "sum"
}

variable "invocations_transformation_window" {
  description = "Transformation window for invocations detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "30m"
}

variable "invocations_threshold_critical" {
  description = "Critical threshold for invocations detector"
  type        = number
  default     = 1
}

variable "invocations_threshold_warning" {
  description = "Warning threshold for invocations detector"
  type        = number
  default     = 2
}

variable "invocations_aperiodic_duration" {
  description = "Duration for the invocations block"
  type        = string
  default     = "10m"
}

variable "invocations_aperiodic_percentage" {
  description = "Percentage for the invocations block"
  type        = number
  default     = 0.9
}
