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

# Azure sqldatabase detectors specific

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

# cpu detectors

variable "cpu_disabled" {
  description = "Disable all alerting rules for cpu detector"
  type        = bool
  default     = null
}

variable "cpu_disabled_critical" {
  description = "Disable critical alerting rule for cpu detector"
  type        = bool
  default     = null
}

variable "cpu_disabled_warning" {
  description = "Disable warning alerting rule for cpu detector"
  type        = bool
  default     = null
}

variable "cpu_notifications" {
  description = "Notification recipients list for every alerting rules of cpu detector"
  type        = list(string)
  default     = []
}

variable "cpu_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of cpu detector"
  type        = list(string)
  default     = []
}

variable "cpu_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of cpu detector"
  type        = list(string)
  default     = []
}

variable "cpu_aggregation_function" {
  description = "Aggregation function and group by for cpu detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['azure_resource_name', 'azure_resource_group_name', 'azure_region'])"
}

variable "cpu_timer" {
  description = "Evaluation window for cpu detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "15m"
}

variable "cpu_threshold_critical" {
  description = "Critical threshold for cpu detector"
  type        = number
  default     = 90
}

variable "cpu_threshold_warning" {
  description = "Warning threshold for cpu detector"
  type        = number
  default     = 80
}

# free_space detectors

variable "free_space_disabled" {
  description = "Disable all alerting rules for free_space detector"
  type        = bool
  default     = null
}

variable "free_space_disabled_critical" {
  description = "Disable critical alerting rule for free_space detector"
  type        = bool
  default     = null
}

variable "free_space_disabled_warning" {
  description = "Disable warning alerting rule for free_space detector"
  type        = bool
  default     = null
}

variable "free_space_notifications" {
  description = "Notification recipients list for every alerting rules of free_space detector"
  type        = list(string)
  default     = []
}

variable "free_space_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of free_space detector"
  type        = list(string)
  default     = []
}

variable "free_space_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of free_space detector"
  type        = list(string)
  default     = []
}

variable "free_space_aggregation_function" {
  description = "Aggregation function and group by for free_space detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['azure_resource_name', 'azure_resource_group_name', 'azure_region'])"
}

variable "free_space_timer" {
  description = "Evaluation window for free_space detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "15m"
}

variable "free_space_threshold_critical" {
  description = "Critical threshold for free_space detector"
  type        = number
  default     = 90
}

variable "free_space_threshold_warning" {
  description = "Warning threshold for free_space detector"
  type        = number
  default     = 80
}

# dtu_consumption detectors

variable "dtu_consumption_disabled" {
  description = "Disable all alerting rules for dtu_consumption detector"
  type        = bool
  default     = null
}

variable "dtu_consumption_disabled_critical" {
  description = "Disable critical alerting rule for dtu_consumption detector"
  type        = bool
  default     = null
}

variable "dtu_consumption_disabled_warning" {
  description = "Disable warning alerting rule for dtu_consumption detector"
  type        = bool
  default     = null
}

variable "dtu_consumption_notifications" {
  description = "Notification recipients list for every alerting rules of dtu_consumption detector"
  type        = list(string)
  default     = []
}

variable "dtu_consumption_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of dtu_consumption detector"
  type        = list(string)
  default     = []
}

variable "dtu_consumption_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of dtu_consumption detector"
  type        = list(string)
  default     = []
}

variable "dtu_consumption_aggregation_function" {
  description = "Aggregation function and group by for dtu_consumption detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['azure_resource_name', 'azure_resource_group_name', 'azure_region'])"
}

variable "dtu_consumption_timer" {
  description = "Evaluation window for dtu_consumption detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "15m"
}

variable "dtu_consumption_threshold_critical" {
  description = "Critical threshold for dtu_consumption detector"
  type        = number
  default     = 90
}

variable "dtu_consumption_threshold_warning" {
  description = "Warning threshold for dtu_consumption detector"
  type        = number
  default     = 85
}

# deadlocks_count detectors

variable "deadlocks_count_disabled" {
  description = "Disable all alerting rules for deadlocks_count detector"
  type        = bool
  default     = null
}

variable "deadlocks_count_disabled_critical" {
  description = "Disable critical alerting rule for deadlocks_count detector"
  type        = bool
  default     = null
}

variable "deadlocks_count_disabled_warning" {
  description = "Disable warning alerting rule for deadlocks_count detector"
  type        = bool
  default     = null
}

variable "deadlocks_count_notifications" {
  description = "Notification recipients list for every alerting rules of deadlocks_count detector"
  type        = list(string)
  default     = []
}

variable "deadlocks_count_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of deadlocks_count detector"
  type        = list(string)
  default     = []
}

variable "deadlocks_count_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of deadlocks_count detector"
  type        = list(string)
  default     = []
}

variable "deadlocks_count_aggregation_function" {
  description = "Aggregation function and group by for deadlocks_count detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['azure_resource_name', 'azure_resource_group_name', 'azure_region'])"
}

variable "deadlocks_count_timer" {
  description = "Evaluation window for deadlocks_count detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "deadlocks_count_threshold_critical" {
  description = "Critical threshold for deadlocks_count detector"
  type        = number
  default     = 1
}
