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

# Azure search detectors specific

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

# Search_latency detectors

variable "search_latency_disabled" {
  description = "Disable all alerting rules for search_latency detector"
  type        = bool
  default     = null
}

variable "search_latency_disabled_critical" {
  description = "Disable critical alerting rule for search_latency detector"
  type        = bool
  default     = null
}

variable "search_latency_disabled_warning" {
  description = "Disable warning alerting rule for search_latency detector"
  type        = bool
  default     = null
}

variable "search_latency_notifications" {
  description = "Notification recipients list for every alerting rules of search_latency detector"
  type        = list
  default     = []
}

variable "search_latency_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of search_latency detector"
  type        = list
  default     = []
}

variable "search_latency_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of search_latency detector"
  type        = list
  default     = []
}

variable "search_latency_aggregation_function" {
  description = "Aggregation function and group by for search_latency detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['azure_resource_id','azure_resource_name'])"
}

variable "search_latency_transformation_function" {
  description = "Transformation function for search_latency detector (mean, min, max)"
  type        = string
  default     = "min"
}

variable "search_latency_transformation_window" {
  description = "Transformation window for search_latency detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "search_latency_threshold_critical" {
  description = "Critical threshold for search_latency detector"
  type        = number
  default     = 4
}

variable "search_latency_threshold_warning" {
  description = "Warning threshold for search_latency detector"
  type        = number
  default     = 2
}

# search_throttled_queries_rate detectors

variable "search_throttled_queries_rate_disabled" {
  description = "Disable all alerting rules for search_throttled_queries_rate detector"
  type        = bool
  default     = null
}

variable "search_throttled_queries_rate_disabled_critical" {
  description = "Disable critical alerting rule for search_throttled_queries_rate detector"
  type        = bool
  default     = null
}

variable "search_throttled_queries_rate_disabled_warning" {
  description = "Disable warning alerting rule for search_throttled_queries_rate detector"
  type        = bool
  default     = null
}

variable "search_throttled_queries_rate_notifications" {
  description = "Notification recipients list for every alerting rules of search_throttled_queries_rate detector"
  type        = list
  default     = []
}

variable "search_throttled_queries_rate_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of search_throttled_queries_rate detector"
  type        = list
  default     = []
}

variable "search_throttled_queries_rate_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of search_throttled_queries_rate detector"
  type        = list
  default     = []
}

variable "search_throttled_queries_rate_aggregation_function" {
  description = "Aggregation function and group by for search_throttled_queries_rate detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['azure_resource_id','azure_resource_name'])"
}

variable "search_throttled_queries_rate_transformation_function" {
  description = "Transformation function for search_throttled_queries_rate detector (mean, min, max)"
  type        = string
  default     = "min"
}

variable "search_throttled_queries_rate_transformation_window" {
  description = "Transformation window for search_throttled_queries_rate detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "search_throttled_queries_rate_threshold_critical" {
  description = "Critical threshold for search_throttled_queries_rate detector"
  type        = number
  default     = 50
}

variable "search_throttled_queries_rate_threshold_warning" {
  description = "Warning threshold for search_throttled_queries_rate detector"
  type        = number
  default     = 20
}
