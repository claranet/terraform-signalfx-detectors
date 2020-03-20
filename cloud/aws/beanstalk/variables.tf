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

# AWS beanstalk detectors specific

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

# Health detectors

variable "health_disabled" {
  description = "Disable all alerting rules for health detector"
  type        = bool
  default     = null
}

variable "health_disabled_critical" {
  description = "Disable critical alerting rule for health detector"
  type        = bool
  default     = null
}

variable "health_disabled_warning" {
  description = "Disable warning alerting rule for health detector"
  type        = bool
  default     = null
}

variable "health_notifications" {
  description = "Notification recipients list for every alerting rules of health detector"
  type        = list
  default     = []
}

variable "health_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of health detector"
  type        = list
  default     = []
}

variable "health_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of health detector"
  type        = list
  default     = []
}

variable "health_aggregation_function" {
  description = "Aggregation function and group by for health detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "health_transformation_function" {
  description = "Transformation function for health detector (mean, min, max)"
  type        = string
  default     = "min"
}

variable "health_transformation_window" {
  description = "Transformation window for health detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "10m"
}

variable "health_threshold_critical" {
  description = "Critical threshold for health detector"
  type        = number
  default     = 20
}

variable "health_threshold_warning" {
  description = "Warning threshold for health detector"
  type        = number
  default     = 15
}

# Latency_p90 detectors

variable "latency_p90_disabled" {
  description = "Disable all alerting rules for latency_p90 detector"
  type        = bool
  default     = null
}

variable "latency_p90_disabled_critical" {
  description = "Disable critical alerting rule for latency_p90 detector"
  type        = bool
  default     = null
}

variable "latency_p90_disabled_warning" {
  description = "Disable warning alerting rule for latency_p90 detector"
  type        = bool
  default     = null
}

variable "latency_p90_notifications" {
  description = "Notification recipients list for every alerting rules of latency_p90 detector"
  type        = list
  default     = []
}

variable "latency_p90_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of latency_p90 detector"
  type        = list
  default     = []
}

variable "latency_p90_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of latency_p90 detector"
  type        = list
  default     = []
}

variable "latency_p90_aggregation_function" {
  description = "Aggregation function and group by for latency_p90 detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".min(by=['EnvironmentName'])"
}

variable "latency_p90_transformation_function" {
  description = "Transformation function for latency_p90 detector (mean, min, max)"
  type        = string
  default     = "min"
}

variable "latency_p90_transformation_window" {
  description = "Transformation window for latency_p90 detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "15m"
}

variable "latency_p90_threshold_critical" {
  description = "Critical threshold for latency_p90 detector"
  type        = number
  default     = 0.5
}

variable "latency_p90_threshold_warning" {
  description = "Warning threshold for latency_p90 detector"
  type        = number
  default     = 0.3
}

# 5xx_error_rate detectors

variable "5xx_error_rate_disabled" {
  description = "Disable all alerting rules for 5xx_error_rate detector"
  type        = bool
  default     = null
}

variable "5xx_error_rate_disabled_critical" {
  description = "Disable critical alerting rule for 5xx_error_rate detector"
  type        = bool
  default     = null
}

variable "5xx_error_rate_disabled_warning" {
  description = "Disable warning alerting rule for 5xx_error_rate detector"
  type        = bool
  default     = null
}

variable "5xx_error_rate_notifications" {
  description = "Notification recipients list for every alerting rules of 5xx_error_rate detector"
  type        = list
  default     = []
}

variable "5xx_error_rate_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of 5xx_error_rate detector"
  type        = list
  default     = []
}

variable "5xx_error_rate_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of 5xx_error_rate detector"
  type        = list
  default     = []
}

variable "5xx_error_rate_aggregation_function" {
  description = "Aggregation function and group by for 5xx_error_rate detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".sum(by=['EnvrionementName'])"
}

variable "5xx_error_rate_transformation_function" {
  description = "Transformation function for 5xx_error_rate detector (mean, min, max)"
  type        = string
  default     = "sum"
}

variable "5xx_error_rate_transformation_window" {
  description = "Transformation window for 5xx_error_rate detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "15m"
}

variable "5xx_error_rate_threshold_critical" {
  description = "Critical threshold for 5xx_error_rate detector"
  type        = number
  default     = 5
}

variable "5xx_error_rate_threshold_warning" {
  description = "Warning threshold for 5xx_error_rate detector"
  type        = number
  default     = 3
}

# Root_filesystem_usage detectors

variable "root_filesystem_usage_disabled" {
  description = "Disable all alerting rules for root_filesystem_usage detector"
  type        = bool
  default     = null
}

variable "root_filesystem_usage_disabled_critical" {
  description = "Disable critical alerting rule for root_filesystem_usage detector"
  type        = bool
  default     = null
}

variable "root_filesystem_usage_disabled_warning" {
  description = "Disable warning alerting rule for root_filesystem_usage detector"
  type        = bool
  default     = null
}

variable "root_filesystem_usage_notifications" {
  description = "Notification recipients list for every alerting rules of root_filesystem_usage detector"
  type        = list
  default     = []
}

variable "root_filesystem_usage_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of root_filesystem_usage detector"
  type        = list
  default     = []
}

variable "root_filesystem_usage_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of root_filesystem_usage detector"
  type        = list
  default     = []
}

variable "root_filesystem_usage_aggregation_function" {
  description = "Aggregation function and group by for root_filesystem_usage detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "root_filesystem_usage_transformation_function" {
  description = "Transformation function for root_filesystem_usage detector (mean, min, max)"
  type        = string
  default     = "max"
}

variable "root_filesystem_usage_transformation_window" {
  description = "Transformation window for root_filesystem_usage detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "root_filesystem_usage_threshold_critical" {
  description = "Critical threshold for root_filesystem_usage detector"
  type        = number
  default     = 90
}

variable "root_filesystem_usage_threshold_warning" {
  description = "Warning threshold for root_filesystem_usage detector"
  type        = number
  default     = 80
}
