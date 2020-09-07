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

# Azure functions detectors specific

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

# http_5xx_errors_rate detectors

variable "http_5xx_errors_rate_disabled" {
  description = "Disable all alerting rules for http_5xx_errors_rate detector"
  type        = bool
  default     = null
}

variable "http_5xx_errors_rate_disabled_critical" {
  description = "Disable critical alerting rule for http_5xx_errors_rate detector"
  type        = bool
  default     = null
}

variable "http_5xx_errors_rate_disabled_warning" {
  description = "Disable warning alerting rule for http_5xx_errors_rate detector"
  type        = bool
  default     = null
}

variable "http_5xx_errors_rate_notifications" {
  description = "Notification recipients list for every alerting rules of http_5xx_errors_rate detector"
  type        = list(string)
  default     = []
}

variable "http_5xx_errors_rate_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of http_5xx_errors_rate detector"
  type        = list(string)
  default     = []
}

variable "http_5xx_errors_rate_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of http_5xx_errors_rate detector"
  type        = list(string)
  default     = []
}

variable "http_5xx_errors_rate_aggregation_function" {
  description = "Aggregation function and group by for http_5xx_errors_rate detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['azure_resource_name', 'azure_resource_group_name', 'azure_region'])"
}

variable "http_5xx_errors_rate_timer" {
  description = "Evaluation window for http_5xx_errors_rate detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "http_5xx_errors_rate_threshold_critical" {
  description = "Critical threshold for http_5xx_errors_rate detector"
  type        = number
  default     = 20
}

variable "http_5xx_errors_rate_threshold_warning" {
  description = "Warning threshold for http_5xx_errors_rate detector"
  type        = number
  default     = 10
}

# High_connections_count detectors

variable "high_connections_count_disabled" {
  description = "Disable all alerting rules for high_connections_count detector"
  type        = bool
  default     = null
}

variable "high_connections_count_disabled_critical" {
  description = "Disable critical alerting rule for high_connections_count detector"
  type        = bool
  default     = null
}

variable "high_connections_count_disabled_warning" {
  description = "Disable warning alerting rule for high_connections_count detector"
  type        = bool
  default     = null
}

variable "high_connections_count_notifications" {
  description = "Notification recipients list for every alerting rules of high_connections_count detector"
  type        = list(string)
  default     = []
}

variable "high_connections_count_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of high_connections_count detector"
  type        = list(string)
  default     = []
}

variable "high_connections_count_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of high_connections_count detector"
  type        = list(string)
  default     = []
}

variable "high_connections_count_aggregation_function" {
  description = "Aggregation function and group by for high_connections_count detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['azure_resource_name', 'azure_resource_group_name', 'azure_region'])"
}

variable "high_connections_count_timer" {
  description = "Evaluation window for high_connections_count detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "high_connections_count_threshold_critical" {
  description = "Critical threshold for high_connections_count detector"
  type        = number
  default     = 590
}

variable "high_connections_count_threshold_warning" {
  description = "Warning threshold for high_connections_count detector"
  type        = number
  default     = 550
}

# High_threads_count detectors

variable "high_threads_count_disabled" {
  description = "Disable all alerting rules for high_threads_count detector"
  type        = bool
  default     = null
}

variable "high_threads_count_disabled_critical" {
  description = "Disable critical alerting rule for high_threads_count detector"
  type        = bool
  default     = null
}

variable "high_threads_count_disabled_warning" {
  description = "Disable warning alerting rule for high_threads_count detector"
  type        = bool
  default     = null
}

variable "high_threads_count_notifications" {
  description = "Notification recipients list for every alerting rules of high_threads_count detector"
  type        = list(string)
  default     = []
}

variable "high_threads_count_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of high_threads_count detector"
  type        = list(string)
  default     = []
}

variable "high_threads_count_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of high_threads_count detector"
  type        = list(string)
  default     = []
}

variable "high_threads_count_aggregation_function" {
  description = "Aggregation function and group by for high_threads_count detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['azure_resource_name', 'azure_resource_group_name', 'azure_region'])"
}

variable "high_threads_count_timer" {
  description = "Evaluation window for high_threads_count detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "high_threads_count_threshold_critical" {
  description = "Critical threshold for high_threads_count detector"
  type        = number
  default     = 510
}

variable "high_threads_count_threshold_warning" {
  description = "Warning threshold for high_threads_count detector"
  type        = number
  default     = 490
}
