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
  default     = ".mean(by=['logicalname', 'azure_resource_name', 'azure_resource_group_name'])"
}

# SU_utilization detector

variable "su_utilization_disabled" {
  description = "Disable all alerting rules for su_utilization detector"
  type        = bool
  default     = null
}

variable "su_utilization_disabled_critical" {
  description = "Disable critical alerting rule for su_utilization detector"
  type        = bool
  default     = null
}

variable "su_utilization_disabled_major" {
  description = "Disable major alerting rule for su_utilization detector"
  type        = bool
  default     = null
}

variable "su_utilization_notifications" {
  description = "Notification recipients list per severity overridden for su_utilization detector"
  type        = map(list(string))
  default     = {}
}

variable "su_utilization_aggregation_function" {
  description = "Aggregation function and group by for su_utilization detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['azure_resource_name', 'azure_resource_group_name', 'azure_region'])"
}

variable "su_utilization_timer" {
  description = "Evaluation window for su_utilization detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "su_utilization_threshold_critical" {
  description = "Critical threshold for su_utilization detector"
  type        = number
  default     = 95
}

variable "su_utilization_threshold_major" {
  description = "Major threshold for su_utilization detector"
  type        = number
  default     = 80
}

# failed_function_requests detector

variable "failed_function_requests_disabled" {
  description = "Disable all alerting rules for failed_function_requests detector"
  type        = bool
  default     = null
}

variable "failed_function_requests_disabled_critical" {
  description = "Disable critical alerting rule for failed_function_requests detector"
  type        = bool
  default     = null
}

variable "failed_function_requests_disabled_major" {
  description = "Disable major alerting rule for failed_function_requests detector"
  type        = bool
  default     = null
}

variable "failed_function_requests_notifications" {
  description = "Notification recipients list per severity overridden for failed_function_requests detector"
  type        = map(list(string))
  default     = {}
}

variable "failed_function_requests_aggregation_function" {
  description = "Aggregation function and group by for failed_function_requests detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['logicalname', 'azure_resource_name', 'azure_resource_group_name', 'azure_region'])"
}

variable "failed_function_requests_timer" {
  description = "Evaluation window for failed_function_requests detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "failed_function_requests_threshold_critical" {
  description = "Critical threshold for failed_function_requests detector"
  type        = number
  default     = 10
}

variable "failed_function_requests_threshold_major" {
  description = "Major threshold for failed_function_requests detector"
  type        = number
  default     = 0
}

# Conversion_errors detector

variable "conversion_errors_disabled" {
  description = "Disable all alerting rules for conversion_errors detector"
  type        = bool
  default     = null
}

variable "conversion_errors_disabled_critical" {
  description = "Disable critical alerting rule for conversion_errors detector"
  type        = bool
  default     = null
}

variable "conversion_errors_disabled_major" {
  description = "Disable major alerting rule for conversion_errors detector"
  type        = bool
  default     = null
}

variable "conversion_errors_notifications" {
  description = "Notification recipients list per severity overridden for conversion_errors detector"
  type        = map(list(string))
  default     = {}
}

variable "conversion_errors_aggregation_function" {
  description = "Aggregation function and group by for conversion_errors detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['logicalname', 'azure_resource_name', 'azure_resource_group_name', 'azure_region'])"
}

variable "conversion_errors_timer" {
  description = "Evaluation window for conversion_errors detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "conversion_errors_threshold_critical" {
  description = "Critical threshold for conversion_errors detector"
  type        = number
  default     = 10
}

variable "conversion_errors_threshold_major" {
  description = "Major threshold for conversion_errors detector"
  type        = number
  default     = 0
}

# Runtime_errors detector

variable "runtime_errors_disabled" {
  description = "Disable all alerting rules for runtime_errors detector"
  type        = bool
  default     = null
}

variable "runtime_errors_disabled_critical" {
  description = "Disable critical alerting rule for runtime_errors detector"
  type        = bool
  default     = null
}

variable "runtime_errors_disabled_major" {
  description = "Disable major alerting rule for runtime_errors detector"
  type        = bool
  default     = null
}

variable "runtime_errors_notifications" {
  description = "Notification recipients list per severity overridden for runtime_errors detector"
  type        = map(list(string))
  default     = {}
}

variable "runtime_errors_aggregation_function" {
  description = "Aggregation function and group by for runtime_errors detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['azure_resource_name', 'azure_resource_group_name', 'azure_region'])"
}

variable "runtime_errors_timer" {
  description = "Evaluation window for runtime_errors detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "runtime_errors_threshold_critical" {
  description = "Critical threshold for runtime_errors detector"
  type        = number
  default     = 10
}

variable "runtime_errors_threshold_major" {
  description = "Major threshold for runtime_errors detector"
  type        = number
  default     = 0
}
