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
  default     = ".mean(by=['entityname', 'azure_resource_name', 'azure_resource_group_name'])"
}

# Active_connections detector

variable "active_connections_disabled" {
  description = "Disable all alerting rules for active_connections detector"
  type        = bool
  default     = null
}

variable "active_connections_disabled_critical" {
  description = "Disable critical alerting rule for active_connections detector"
  type        = bool
  default     = null
}

variable "active_connections_notifications" {
  description = "Notification recipients list per severity overridden for active_connections detector"
  type        = map(list(string))
  default     = {}
}

variable "active_connections_aggregation_function" {
  description = "Aggregation function and group by for active_connections detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['azure_resource_name', 'azure_resource_group_name', 'azure_region'])"
}

variable "active_connections_timer" {
  description = "Evaluation window for active_connections detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "active_connections_threshold_critical" {
  description = "Critical threshold for active_connections detector"
  type        = number
  default     = 1
}

# User_errors detector

variable "user_errors_disabled" {
  description = "Disable all alerting rules for user_errors detector"
  type        = bool
  default     = null
}

variable "user_errors_disabled_critical" {
  description = "Disable critical alerting rule for user_errors detector"
  type        = bool
  default     = null
}

variable "user_errors_disabled_major" {
  description = "Disable major alerting rule for user_errors detector"
  type        = bool
  default     = null
}

variable "user_errors_notifications" {
  description = "Notification recipients list per severity overridden for user_errors detector"
  type        = map(list(string))
  default     = {}
}

variable "user_errors_aggregation_function" {
  description = "Aggregation function and group by for user_errors detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['entityname', 'azure_resource_name', 'azure_resource_group_name', 'azure_region'])"
}

variable "user_errors_timer" {
  description = "Evaluation window for user_errors detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "user_errors_threshold_critical" {
  description = "Critical threshold for user_errors detector"
  type        = number
  default     = 90
}

variable "user_errors_threshold_major" {
  description = "Major threshold for user_errors detector"
  type        = number
  default     = 50
}

# Server_errors detector

variable "server_errors_disabled" {
  description = "Disable all alerting rules for server_errors detector"
  type        = bool
  default     = null
}

variable "server_errors_disabled_critical" {
  description = "Disable critical alerting rule for server_errors detector"
  type        = bool
  default     = null
}

variable "server_errors_disabled_major" {
  description = "Disable major alerting rule for server_errors detector"
  type        = bool
  default     = null
}

variable "server_errors_notifications" {
  description = "Notification recipients list per severity overridden for server_errors detector"
  type        = map(list(string))
  default     = {}
}

variable "server_errors_aggregation_function" {
  description = "Aggregation function and group by for server_errors detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['entityname', 'azure_resource_name', 'azure_resource_group_name', 'azure_region'])"
}

variable "server_errors_timer" {
  description = "Evaluation window for server_errors detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "server_errors_threshold_critical" {
  description = "Critical threshold for server_errors detector"
  type        = number
  default     = 90
}

variable "server_errors_threshold_major" {
  description = "Major threshold for server_errors detector"
  type        = number
  default     = 50
}

# throttled_requests detector

variable "throttled_requests_notifications" {
  description = "Notification recipients list per severity overridden for throttled_requests detector"
  type        = map(list(string))
  default     = {}
}

variable "throttled_requests_aggregation_function" {
  description = "Aggregation function and group by for throttled_requests detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['azure_resource_name', 'azure_resource_group_name', 'azure_region'])"
}

variable "throttled_requests_transformation_function" {
  description = "Transformation function for throttled_requests detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".max(over='5m')"
}

variable "throttled_requests_disabled" {
  description = "Disable all alerting rules for throttled_requests detector"
  type        = bool
  default     = null
}

variable "throttled_requests_disabled_critical" {
  description = "Disable critical alerting rule for throttled_requests detector"
  type        = bool
  default     = null
}

variable "throttled_requests_disabled_major" {
  description = "Disable major alerting rule for throttled_requests detector"
  type        = bool
  default     = null
}

variable "throttled_requests_threshold_critical" {
  description = "Critical threshold for throttled_requests detector"
  type        = number
  default     = 90
}

variable "throttled_requests_threshold_major" {
  description = "Major threshold for throttled_requests detector"
  type        = number
  default     = 80
}
