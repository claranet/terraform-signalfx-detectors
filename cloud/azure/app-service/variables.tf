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

# Response_time detector

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

variable "response_time_disabled_major" {
  description = "Disable major alerting rule for response_time detector"
  type        = bool
  default     = null
}

variable "response_time_notifications" {
  description = "Notification recipients list per severity overridden for response_time detector"
  type        = map(list(string))
  default     = {}
}

variable "response_time_aggregation_function" {
  description = "Aggregation function and group by for response_time detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['azure_resource_name', 'azure_resource_group_name', 'azure_region'])"
}

variable "response_time_timer" {
  description = "Evaluation window for response_time detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "response_time_threshold_critical" {
  description = "Critical threshold for response_time detector"
  type        = number
  default     = 10
}

variable "response_time_threshold_major" {
  description = "Major threshold for response_time detector"
  type        = number
  default     = 5
}

# Memory_usage_count detector

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

variable "memory_usage_count_disabled_major" {
  description = "Disable major alerting rule for memory_usage_count detector"
  type        = bool
  default     = null
}

variable "memory_usage_count_notifications" {
  description = "Notification recipients list per severity overridden for memory_usage_count detector"
  type        = map(list(string))
  default     = {}
}

variable "memory_usage_count_aggregation_function" {
  description = "Aggregation function and group by for memory_usage_count detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['azure_resource_name', 'azure_resource_group_name', 'azure_region'])"
}

variable "memory_usage_count_timer" {
  description = "Evaluation window for memory_usage_count detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "memory_usage_count_threshold_critical" {
  description = "Critical threshold for memory_usage_count detector"
  type        = number
  default     = 1073741824 # 1Gb
}

variable "memory_usage_count_threshold_major" {
  description = "Major threshold for memory_usage_count detector"
  type        = number
  default     = 536870912 # 512Mb
}

# Http_5xx_errors_count detector

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

variable "http_5xx_errors_count_disabled_major" {
  description = "Disable major alerting rule for http_5xx_errors_count detector"
  type        = bool
  default     = null
}

variable "http_5xx_errors_count_notifications" {
  description = "Notification recipients list per severity overridden for http_5xx_errors_count detector"
  type        = map(list(string))
  default     = {}
}

variable "http_5xx_errors_count_aggregation_function" {
  description = "Aggregation function and group by for http_5xx_errors_count detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['azure_resource_name', 'azure_resource_group_name', 'azure_region'])"
}

variable "http_5xx_errors_count_timer" {
  description = "Evaluation window for http_5xx_errors_count detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "http_5xx_errors_count_threshold_critical" {
  description = "Critical threshold for http_5xx_errors_count detector"
  type        = number
  default     = 90
}

variable "http_5xx_errors_count_threshold_major" {
  description = "Major threshold for http_5xx_errors_count detector"
  type        = number
  default     = 50
}

# http_4xx_errors_count detector

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

variable "http_4xx_errors_count_disabled_major" {
  description = "Disable major alerting rule for http_4xx_errors_count detector"
  type        = bool
  default     = null
}

variable "http_4xx_errors_count_notifications" {
  description = "Notification recipients list per severity overridden for http_4xx_errors_count detector"
  type        = map(list(string))
  default     = {}
}

variable "http_4xx_errors_count_aggregation_function" {
  description = "Aggregation function and group by for http_4xx_errors_count detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['azure_resource_name', 'azure_resource_group_name', 'azure_region'])"
}

variable "http_4xx_errors_count_timer" {
  description = "Evaluation window for http_4xx_errors_count detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "http_4xx_errors_count_threshold_critical" {
  description = "Critical threshold for http_4xx_errors_count detector"
  type        = number
  default     = 90
}

variable "http_4xx_errors_count_threshold_major" {
  description = "Major threshold for http_4xx_errors_count detector"
  type        = number
  default     = 50
}

# Http_success_status_rate detector

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

variable "http_success_status_rate_disabled_major" {
  description = "Disable major alerting rule for http_success_status_rate detector"
  type        = bool
  default     = null
}

variable "http_success_status_rate_notifications" {
  description = "Notification recipients list per severity overridden for http_success_status_rate detector"
  type        = map(list(string))
  default     = {}
}

variable "http_success_status_rate_aggregation_function" {
  description = "Aggregation function and group by for http_success_status_rate detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['azure_resource_name', 'azure_resource_group_name', 'azure_region'])"
}

variable "http_success_status_rate_timer" {
  description = "Evaluation window for http_success_status_rate detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "http_success_status_rate_threshold_critical" {
  description = "Critical threshold for http_success_status_rate detector"
  type        = number
  default     = 10
}

variable "http_success_status_rate_threshold_major" {
  description = "Major threshold for http_success_status_rate detector"
  type        = number
  default     = 30
}
