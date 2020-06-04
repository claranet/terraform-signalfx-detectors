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

# SQL Server detectors specific

# Dns_query_time detectors

variable "dns_query_time_disabled" {
  description = "Disable all alerting rules for dns_query_time detector"
  type        = bool
  default     = null
}

variable "dns_query_time_disabled_critical" {
  description = "Disable critical alerting rule for dns_query_time detector"
  type        = bool
  default     = null
}

variable "dns_query_time_disabled_warning" {
  description = "Disable warning alerting rule for dns_query_time detector"
  type        = bool
  default     = null
}

variable "dns_query_time_notifications" {
  description = "Notification recipients list for every alerting rules of dns_query_time detector"
  type        = list
  default     = []
}

variable "dns_query_time_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of dns_query_time detector"
  type        = list
  default     = []
}

variable "dns_query_time_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of dns_query_time detector"
  type        = list
  default     = []
}

variable "dns_query_time_aggregation_function" {
  description = "Aggregation function and group by for dns_query_time detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['domain'])"
}

variable "dns_query_time_transformation_function" {
  description = "Transformation function for dns_query_time detector (mean, min, max)"
  type        = string
  default     = "mean"
}

variable "dns_query_time_transformation_window" {
  description = "Transformation window for dns_query_time detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "dns_query_time_threshold_critical" {
  description = "Critical threshold for dns_query_time detector"
  type        = number
  default     = 30
}

variable "dns_query_time_threshold_warning" {
  description = "Warning threshold for dns_query_time detector"
  type        = number
  default     = 20
}

# Dns_error_code detectors

variable "dns_error_code_disabled" {
  description = "Disable all alerting rules for dns_error_code detector"
  type        = bool
  default     = null
}

variable "dns_error_code_disabled_critical" {
  description = "Disable critical alerting rule for dns_error_code detector"
  type        = bool
  default     = null
}

variable "dns_error_code_notifications" {
  description = "Notification recipients list for every alerting rules of dns_error_code detector"
  type        = list
  default     = []
}

variable "dns_error_code_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of dns_error_code detector"
  type        = list
  default     = []
}

variable "dns_error_code_aggregation_function" {
  description = "Aggregation function and group by for dns_error_code detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['domain'])"
}

variable "dns_error_code_transformation_function" {
  description = "Transformation function for dns_error_code detector (mean, min, max)"
  type        = string
  default     = "mean"
}

variable "dns_error_code_transformation_window" {
  description = "Transformation window for dns_error_code detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "dns_error_code_threshold_critical" {
  description = "Critical threshold for dns_error_code detector"
  type        = number
  default     = 0
}

# Dns_result_code detectors

variable "dns_result_code_disabled" {
  description = "Disable all alerting rules for dns_result_code detector"
  type        = bool
  default     = null
}

variable "dns_result_code_disabled_critical" {
  description = "Disable critical alerting rule for dns_result_code detector"
  type        = bool
  default     = null
}

variable "dns_result_code_notifications" {
  description = "Notification recipients list for every alerting rules of dns_result_code detector"
  type        = list
  default     = []
}

variable "dns_result_code_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of dns_result_code detector"
  type        = list
  default     = []
}

variable "dns_result_code_aggregation_function" {
  description = "Aggregation function and group by for dns_result_code detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['domain'])"
}

variable "dns_result_code_transformation_function" {
  description = "Transformation function for dns_result_code detector (mean, min, max)"
  type        = string
  default     = "mean"
}

variable "dns_result_code_transformation_window" {
  description = "Transformation window for dns_result_code detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "dns_result_code_threshold_critical" {
  description = "Critical threshold for dns_result_code detector"
  type        = number
  default     = 0
}
