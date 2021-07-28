# Module specific

# Heartbeat detector

variable "heartbeat_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "heartbeat_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

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

variable "active_connections_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "active_connections_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

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

variable "user_errors_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "user_errors_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

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

variable "server_errors_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "server_errors_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

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

variable "throttled_requests_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "throttled_requests_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
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

# Deadlettered_messages detector

variable "deadlettered_messages_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "deadlettered_messages_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "deadlettered_messages_disabled" {
  description = "Disable all alerting rules for deadlettered_messages detector"
  type        = bool
  default     = null
}

variable "deadlettered_messages_disabled_critical" {
  description = "Disable critical alerting rule for deadlettered_messages detector"
  type        = bool
  default     = null
}

variable "deadlettered_messages_disabled_major" {
  description = "Disable critical alerting rule for deadlettered_messages detector"
  type        = bool
  default     = null
}

variable "deadlettered_messages_notifications" {
  description = "Notification recipients list per severity overridden for deadlettered_messages detector"
  type        = map(list(string))
  default     = {}
}

variable "deadlettered_messages_aggregation_function" {
  description = "Aggregation function and group by for deadlettered_messages detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['entityname', 'azure_resource_name', 'azure_resource_group_name', 'azure_region'])"
}

variable "deadlettered_messages_timer" {
  description = "Evaluation window for deadlettered_messages detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "deadlettered_messages_threshold_critical" {
  description = "Critical threshold for deadlettered_messages detector"
  type        = number
  default     = 10
}

variable "deadlettered_messages_threshold_major" {
  description = "Major threshold for deadlettered_messages detector"
  type        = number
  default     = 5
}