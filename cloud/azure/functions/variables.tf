# Module specific

# Heartbeat detector

variable "heartbeat_disabled" {
  description = "Disable all alerting rules for heartbeat detector"
  type        = bool
  default     = null
}

variable "heartbeat_notifications" {
  description = "Notification recipients list per severity overridden for heartbeat detector"
  type        = map(list(string))
  default     = {}
}

variable "heartbeat_timeframe" {
  description = "Timeframe for heartbeat detector (i.e. \"10m\")"
  type        = string
  default     = "20m"
}

variable "heartbeat_aggregation_function" {
  description = "Aggregation function and group by for heartbeat detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['azure_resource_name', 'azure_resource_group_name', 'azure_region'])"
}

# http_5xx_errors_rate detector

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

variable "http_5xx_errors_rate_disabled_major" {
  description = "Disable major alerting rule for http_5xx_errors_rate detector"
  type        = bool
  default     = null
}

variable "http_5xx_errors_rate_notifications" {
  description = "Notification recipients list per severity overridden for http_5xx_errors_rate detector"
  type        = map(list(string))
  default     = {}
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

variable "http_5xx_errors_rate_threshold_major" {
  description = "Major threshold for http_5xx_errors_rate detector"
  type        = number
  default     = 10
}

# High_connections_count detector

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

variable "high_connections_count_disabled_major" {
  description = "Disable major alerting rule for high_connections_count detector"
  type        = bool
  default     = null
}

variable "high_connections_count_notifications" {
  description = "Notification recipients list per severity overridden for high_connections_count detector"
  type        = map(list(string))
  default     = {}
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

variable "high_connections_count_threshold_major" {
  description = "Major threshold for high_connections_count detector"
  type        = number
  default     = 550
}

# High_threads_count detector

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

variable "high_threads_count_disabled_major" {
  description = "Disable major alerting rule for high_threads_count detector"
  type        = bool
  default     = null
}

variable "high_threads_count_notifications" {
  description = "Notification recipients list per severity overridden for high_threads_count detector"
  type        = map(list(string))
  default     = {}
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

variable "high_threads_count_threshold_major" {
  description = "Major threshold for high_threads_count detector"
  type        = number
  default     = 490
}
