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

# Azure servicebus detectors specific

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

variable "active_connections_disabled_warning" {
  description = "Disable warning alerting rule for active_connections detector"
  type        = bool
  default     = null
}

variable "active_connections_notifications" {
  description = "Notification recipients list for every alerting rules of active_connections detector"
  type        = list
  default     = []
}

variable "active_connections_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of active_connections detector"
  type        = list
  default     = []
}

variable "active_connections_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of active_connections detector"
  type        = list
  default     = []
}

variable "active_connections_aggregation_function" {
  description = "Aggregation function and group by for active_connections detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['azure_resource_name', 'azure_resource_group_name', 'azure_region'])"
}

variable "active_connections_transformation_function" {
  description = "Transformation function for active_connections detector (mean, min, max)"
  type        = string
  default     = "max"
}

variable "active_connections_transformation_window" {
  description = "Transformation window for active_connections detector (i.e. 5m, 20m, 1h, 1d)"
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
  description = "Notification recipients list for every alerting rules of user_errors detector"
  type        = list
  default     = []
}

variable "user_errors_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of user_errors detector"
  type        = list
  default     = []
}

variable "user_errors_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of user_errors detector"
  type        = list
  default     = []
}

variable "user_errors_aggregation_function" {
  description = "Aggregation function and group by for user_errors detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['entityname', 'azure_resource_name', 'azure_resource_group_name', 'azure_region'])"
}

variable "user_errors_transformation_function" {
  description = "Transformation function for user_errors detector (mean, min, max)"
  type        = string
  default     = "min"
}

variable "user_errors_transformation_window" {
  description = "Transformation window for user_errors detector (i.e. 5m, 20m, 1h, 1d)"
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

variable "user_errors_aperiodic_duration" {
  description = "Duration for the user_errors block"
  type        = string
  default     = "10m"
}

variable "user_errors_aperiodic_percentage" {
  description = "Percentage for the user_errors block"
  type        = number
  default     = 0.9
}

variable "user_errors_aperiodic_upper_strict" {
  description = "If True, compare stream against upper with strict inequality; if False, non-strict"
  type        = bool
  default     = false
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
  description = "Notification recipients list for every alerting rules of server_errors detector"
  type        = list
  default     = []
}

variable "server_errors_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of server_errors detector"
  type        = list
  default     = []
}

variable "server_errors_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of server_errors detector"
  type        = list
  default     = []
}

variable "server_errors_aggregation_function" {
  description = "Aggregation function and group by for server_errors detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['entityname', 'azure_resource_name', 'azure_resource_group_name', 'azure_region'])"
}

variable "server_errors_transformation_function" {
  description = "Transformation function for server_errors detector (mean, min, max)"
  type        = string
  default     = "min"
}

variable "server_errors_transformation_window" {
  description = "Transformation window for server_errors detector (i.e. 5m, 20m, 1h, 1d)"
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

variable "server_errors_aperiodic_duration" {
  description = "Duration for the server_errors block"
  type        = string
  default     = "10m"
}

variable "server_errors_aperiodic_percentage" {
  description = "Percentage for the server_errors block"
  type        = number
  default     = 0.9
}

variable "server_errors_aperiodic_upper_strict" {
  description = "If True, compare stream against upper with strict inequality; if False, non-strict"
  type        = bool
  default     = false
}
