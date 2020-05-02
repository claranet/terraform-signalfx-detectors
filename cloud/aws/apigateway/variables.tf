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

# AWS ApiGateway detectors specific

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

# Latency detectors

variable "latency_disabled" {
  description = "Disable all alerting rules for latency detector"
  type        = bool
  default     = null
}

variable "latency_disabled_critical" {
  description = "Disable critical alerting rule for latency detector"
  type        = bool
  default     = null
}

variable "latency_disabled_warning" {
  description = "Disable warning alerting rule for latency detector"
  type        = bool
  default     = null
}

variable "latency_notifications" {
  description = "Notification recipients list for every alerting rules of latency detector"
  type        = list
  default     = []
}

variable "latency_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of latency detector"
  type        = list
  default     = []
}

variable "latency_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of latency detector"
  type        = list
  default     = []
}

variable "latency_aggregation_function" {
  description = "Aggregation function and group by for latency detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "latency_transformation_function" {
  description = "Transformation function for latency detector (mean, min, max)"
  type        = string
  default     = "min"
}

variable "latency_transformation_window" {
  description = "Transformation window for latency detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "latency_threshold_critical" {
  description = "Critical threshold for latency detector"
  type        = number
  default     = 3000
}

variable "latency_threshold_warning" {
  description = "Warning threshold for latency detector"
  type        = number
  default     = 1000
}

variable "latency_aperiodic_duration" {
  description = "Duration for the latency block"
  type        = string
  default     = "10m"
}

variable "latency_aperiodic_percentage" {
  description = "Percentage for the latency block"
  type        = number
  default     = 0.9
}

variable "latency_aperiodic_upper_strict" {
  description = "If True, compare stream against upper with strict inequality; if False, non-strict"
  type        = bool
  default     = "0"
}

# Http_5xx_errors detectors

variable "http_5xx_errors_disabled" {
  description = "Disable all alerting rules for http_5xx_errors detector"
  type        = bool
  default     = null
}

variable "http_5xx_errors_disabled_critical" {
  description = "Disable critical alerting rule for http_5xx_errors detector"
  type        = bool
  default     = null
}

variable "http_5xx_errors_disabled_warning" {
  description = "Disable warning alerting rule for http_5xx_errors detector"
  type        = bool
  default     = null
}

variable "http_5xx_errors_notifications" {
  description = "Notification recipients list for every alerting rules of http_5xx_errors detector"
  type        = list
  default     = []
}

variable "http_5xx_errors_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of http_5xx_errors detector"
  type        = list
  default     = []
}

variable "http_5xx_errors_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of http_5xx_errors detector"
  type        = list
  default     = []
}

variable "http_5xx_errors_aggregation_function" {
  description = "Aggregation function and group by for http_5xx_errors detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean()"
}

variable "http_5xx_errors_transformation_function" {
  description = "Transformation function for http_5xx_errors detector (mean, min, max)"
  type        = string
  default     = "min"
}

variable "http_5xx_errors_transformation_window" {
  description = "Transformation window for http_5xx_errors detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "http_5xx_errors_threshold_critical" {
  description = "Critical threshold for http_5xx_errors detector"
  type        = number
  default     = 20
}

variable "http_5xx_errors_threshold_warning" {
  description = "Warning threshold for http_5xx_errors detector"
  type        = number
  default     = 10
}

variable "http_5xx_errors_threshold_number_requests" {
  description = "Number threshold for http_5xx_errors detector"
  type        = number
  default     = 5
}

# Http_4xx_errors detectors

variable "http_4xx_errors_disabled" {
  description = "Disable all alerting rules for http_4xx_errors detector"
  type        = bool
  default     = null
}

variable "http_4xx_errors_disabled_critical" {
  description = "Disable critical alerting rule for http_4xx_errors detector"
  type        = bool
  default     = null
}

variable "http_4xx_errors_disabled_warning" {
  description = "Disable warning alerting rule for http_4xx_errors detector"
  type        = bool
  default     = null
}

variable "http_4xx_errors_notifications" {
  description = "Notification recipients list for every alerting rules of http_4xx_errors detector"
  type        = list
  default     = []
}

variable "http_4xx_errors_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of http_4xx_errors detector"
  type        = list
  default     = []
}

variable "http_4xx_errors_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of http_4xx_errors detector"
  type        = list
  default     = []
}

variable "http_4xx_errors_aggregation_function" {
  description = "Aggregation function and group by for http_4xx_errors detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean()"
}

variable "http_4xx_errors_transformation_function" {
  description = "Transformation function for http_4xx_errors detector (mean, min, max)"
  type        = string
  default     = "min"
}

variable "http_4xx_errors_transformation_window" {
  description = "Transformation window for http_4xx_errors detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "http_4xx_errors_threshold_critical" {
  description = "Critical threshold for http_4xx_errors detector"
  type        = number
  default     = 30
}

variable "http_4xx_errors_threshold_warning" {
  description = "Warning threshold for http_4xx_errors detector"
  type        = number
  default     = 15
}

variable "http_4xx_errors_threshold_number_requests" {
  description = "Number threshold for http_4xx_errors detector"
  type        = number
  default     = 5
}
