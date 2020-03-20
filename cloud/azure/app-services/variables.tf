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

# Azure app services detectors specific

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

# Response_time detectors

variable "response_time_disabled" {
  description = "Disable all alerting rules for response_time detector"
  type        = bool
  default     = null
}

variable "response_time_disabled_critical" {
  description = "Disable critical alerting rule for response_time detector"
  type        = bool
  default     = null
}

variable "response_time_disabled_warning" {
  description = "Disable warning alerting rule for response_time detector"
  type        = bool
  default     = null
}

variable "response_time_notifications" {
  description = "Notification recipients list for every alerting rules of response_time detector"
  type        = list
  default     = []
}

variable "response_time_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of response_time detector"
  type        = list
  default     = []
}

variable "response_time_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of response_time detector"
  type        = list
  default     = []
}

variable "response_time_aggregation_function" {
  description = "Aggregation function and group by for response_time detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['azure_resource_id', 'azure_resource_name', 'Instance'])"
}

variable "response_time_transformation_function" {
  description = "Transformation function for response_time detector (mean, min, max)"
  type        = string
  default     = "min"
}

variable "response_time_transformation_window" {
  description = "Transformation window for response_time detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "response_time_threshold_critical" {
  description = "Critical threshold for response_time detector"
  type        = number
  default     = 10
}

variable "response_time_threshold_warning" {
  description = "Warning threshold for response_time detector"
  type        = number
  default     = 5
}

variable "response_time_aperiodic_duration" {
  description = "Duration for the response_time block"
  type        = string
  default     = "10m"
}

variable "response_time_aperiodic_percentage" {
  description = "Percentage for the response_time block"
  type        = number
  default     = 0.9
}

# Memory_usage_count detectors

variable "memory_usage_count_disabled" {
  description = "Disable all alerting rules for memory_usage_count detector"
  type        = bool
  default     = null
}

variable "memory_usage_count_disabled_critical" {
  description = "Disable critical alerting rule for memory_usage_count detector"
  type        = bool
  default     = null
}

variable "memory_usage_count_disabled_warning" {
  description = "Disable warning alerting rule for memory_usage_count detector"
  type        = bool
  default     = null
}

variable "memory_usage_count_notifications" {
  description = "Notification recipients list for every alerting rules of memory_usage_count detector"
  type        = list
  default     = []
}

variable "memory_usage_count_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of memory_usage_count detector"
  type        = list
  default     = []
}

variable "memory_usage_count_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of memory_usage_count detector"
  type        = list
  default     = []
}

variable "memory_usage_count_aggregation_function" {
  description = "Aggregation function and group by for memory_usage_count detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['azure_resource_id', 'azure_resource_name', 'Instance'])"
}

variable "memory_usage_count_transformation_function" {
  description = "Transformation function for memory_usage_count detector (mean, min, max)"
  type        = string
  default     = "min"
}

variable "memory_usage_count_transformation_window" {
  description = "Transformation window for memory_usage_count detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "memory_usage_count_threshold_critical" {
  description = "Critical threshold for memory_usage_count detector"
  type        = number
  default     = 1073741824  # 1Gb
}

variable "memory_usage_count_threshold_warning" {
  description = "Warning threshold for memory_usage_count detector"
  type        = number
  default     = 536870912  # 512Mb
}

# Http_5xx_errors_count detectors

variable "http_5xx_errors_count_disabled" {
  description = "Disable all alerting rules for http_5xx_errors_count detector"
  type        = bool
  default     = null
}

variable "http_5xx_errors_count_disabled_critical" {
  description = "Disable critical alerting rule for http_5xx_errors_count detector"
  type        = bool
  default     = null
}

variable "http_5xx_errors_count_disabled_warning" {
  description = "Disable warning alerting rule for http_5xx_errors_count detector"
  type        = bool
  default     = null
}

variable "http_5xx_errors_count_notifications" {
  description = "Notification recipients list for every alerting rules of http_5xx_errors_count detector"
  type        = list
  default     = []
}

variable "http_5xx_errors_count_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of http_5xx_errors_count detector"
  type        = list
  default     = []
}

variable "http_5xx_errors_count_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of http_5xx_errors_count detector"
  type        = list
  default     = []
}

variable "http_5xx_errors_count_aggregation_function" {
  description = "Aggregation function and group by for http_5xx_errors_count detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['azure_resource_id','azure_resource_name', 'Instance'])"
}

variable "http_5xx_errors_count_transformation_function" {
  description = "Transformation function for http_5xx_errors_count detector (mean, min, max)"
  type        = string
  default     = "min"
}

variable "http_5xx_errors_count_transformation_window" {
  description = "Transformation window for http_5xx_errors_count detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "http_5xx_errors_count_threshold_critical" {
  description = "Critical threshold for http_5xx_errors_count detector"
  type        = number
  default     = 90
}

variable "http_5xx_errors_count_threshold_warning" {
  description = "Warning threshold for http_5xx_errors_count detector"
  type        = number
  default     = 50
}

variable "http_5xx_errors_count_aperiodic_duration" {
  description = "Duration for the http_5xx_errors_count block"
  type        = string
  default     = "10m"
}

variable "http_5xx_errors_count_aperiodic_percentage" {
  description = "Percentage for the http_5xx_errors_count block"
  type        = number
  default     = 0.9
}

# http_4xx_errors_count detectors

variable "http_4xx_errors_count_disabled" {
  description = "Disable all alerting rules for http_4xx_errors_count detector"
  type        = bool
  default     = null
}

variable "http_4xx_errors_count_disabled_critical" {
  description = "Disable critical alerting rule for http_4xx_errors_count detector"
  type        = bool
  default     = null
}

variable "http_4xx_errors_count_disabled_warning" {
  description = "Disable warning alerting rule for http_4xx_errors_count detector"
  type        = bool
  default     = null
}

variable "http_4xx_errors_count_notifications" {
  description = "Notification recipients list for every alerting rules of http_4xx_errors_count detector"
  type        = list
  default     = []
}

variable "http_4xx_errors_count_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of http_4xx_errors_count detector"
  type        = list
  default     = []
}

variable "http_4xx_errors_count_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of http_4xx_errors_count detector"
  type        = list
  default     = []
}

variable "http_4xx_errors_count_aggregation_function" {
  description = "Aggregation function and group by for http_4xx_errors_count detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['azure_resource_id','azure_resource_name', 'Instance'])"
}

variable "http_4xx_errors_count_transformation_function" {
  description = "Transformation function for http_4xx_errors_count detector (mean, min, max)"
  type        = string
  default     = "min"
}

variable "http_4xx_errors_count_transformation_window" {
  description = "Transformation window for http_4xx_errors_count detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "http_4xx_errors_count_threshold_critical" {
  description = "Critical threshold for http_4xx_errors_count detector"
  type        = number
  default     = 90
}

variable "http_4xx_errors_count_threshold_warning" {
  description = "Warning threshold for http_4xx_errors_count detector"
  type        = number
  default     = 50
}

variable "http_4xx_errors_count_aperiodic_duration" {
  description = "Duration for the http_4xx_errors_count block"
  type        = string
  default     = "10m"
}

variable "http_4xx_errors_count_aperiodic_percentage" {
  description = "Percentage for the http_4xx_errors_count block"
  type        = number
  default     = 0.9
}

# Http_success_status_rate detectors

variable "http_success_status_rate_disabled" {
  description = "Disable all alerting rules for http_success_status_rate detector"
  type        = bool
  default     = null
}

variable "http_success_status_rate_disabled_critical" {
  description = "Disable critical alerting rule for http_success_status_rate detector"
  type        = bool
  default     = null
}

variable "http_success_status_rate_disabled_warning" {
  description = "Disable warning alerting rule for http_success_status_rate detector"
  type        = bool
  default     = null
}

variable "http_success_status_rate_notifications" {
  description = "Notification recipients list for every alerting rules of http_success_status_rate detector"
  type        = list
  default     = []
}

variable "http_success_status_rate_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of http_success_status_rate detector"
  type        = list
  default     = []
}

variable "http_success_status_rate_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of http_success_status_rate detector"
  type        = list
  default     = []
}

variable "http_success_status_rate_aggregation_function" {
  description = "Aggregation function and group by for http_success_status_rate detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['azure_resource_id','azure_resource_name', 'Instance'])"
}

variable "http_success_status_rate_transformation_function" {
  description = "Transformation function for http_success_status_rate detector (mean, min, max)"
  type        = string
  default     = "max"
}

variable "http_success_status_rate_transformation_window" {
  description = "Transformation window for http_success_status_rate detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "http_success_status_rate_threshold_critical" {
  description = "Critical threshold for http_success_status_rate detector"
  type        = number
  default     = 10
}

variable "http_success_status_rate_threshold_warning" {
  description = "Warning threshold for http_success_status_rate detector"
  type        = number
  default     = 30
}

variable "http_success_status_rate_aperiodic_duration" {
  description = "Duration for the http_success_status_rate block"
  type        = string
  default     = "10m"
}

variable "http_success_status_rate_aperiodic_percentage" {
  description = "Percentage for the http_success_status_rate block"
  type        = number
  default     = 0.9
}

# Status detectors

variable "status_disabled" {
  description = "Disable all alerting rules for status detector"
  type        = bool
  default     = null
}

variable "status_disabled_critical" {
  description = "Disable critical alerting rule for status detector"
  type        = bool
  default     = null
}

variable "status_disabled_warning" {
  description = "Disable warning alerting rule for status detector"
  type        = bool
  default     = null
}

variable "status_notifications" {
  description = "Notification recipients list for every alerting rules of status detector"
  type        = list
  default     = []
}

variable "status_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of status detector"
  type        = list
  default     = []
}

variable "status_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of status detector"
  type        = list
  default     = []
}

variable "status_aggregation_function" {
  description = "Aggregation function and group by for status detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['azure_resource_id','azure_resource_name', 'Instance'])"
}

variable "status_transformation_function" {
  description = "Transformation function for status detector (mean, min, max)"
  type        = string
  default     = "max"
}

variable "status_transformation_window" {
  description = "Transformation window for status detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "status_threshold_critical" {
  description = "Critical threshold for status detector"
  type        = number
  default     = 0
}

variable "status_threshold_warning" {
  description = "Warning threshold for status detector"
  type        = number
  default     = 1
}
