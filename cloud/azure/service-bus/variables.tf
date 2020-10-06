# Global

variable "environment" {
  description = "Infrastructure environment"
  type        = string
}

# SignalFx module specific

variable "notifications" {
  description = "Default notification recipients list per severity"
  type = object({
    critical = list(string)
    major    = list(string)
    minor    = list(string)
    warning  = list(string)
    info     = list(string)
  })
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

# Azure servicebus detectors specific

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
  description = "Timeframe for system not reporting detector (i.e. \"10m\")"
  type        = string
  default     = "20m"
}

# Active_connections detectors

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

# User_errors detectors

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

variable "user_errors_disabled_warning" {
  description = "Disable warning alerting rule for user_errors detector"
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

variable "user_errors_threshold_warning" {
  description = "Warning threshold for user_errors detector"
  type        = number
  default     = 50
}

# Server_errors detectors

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

variable "server_errors_disabled_warning" {
  description = "Disable warning alerting rule for server_errors detector"
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

variable "server_errors_threshold_warning" {
  description = "Warning threshold for server_errors detector"
  type        = number
  default     = 50
}
