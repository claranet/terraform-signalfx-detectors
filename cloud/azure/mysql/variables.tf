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

# Azure mysql detectors specific

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

# cpu_usage detectors

variable "cpu_usage_disabled" {
  description = "Disable all alerting rules for cpu_usage detector"
  type        = bool
  default     = null
}

variable "cpu_usage_disabled_critical" {
  description = "Disable critical alerting rule for cpu_usage detector"
  type        = bool
  default     = null
}

variable "cpu_usage_disabled_warning" {
  description = "Disable warning alerting rule for cpu_usage detector"
  type        = bool
  default     = null
}

variable "cpu_usage_notifications" {
  description = "Notification recipients list for every alerting rules of cpu_usage detector"
  type        = list(string)
  default     = []
}

variable "cpu_usage_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of cpu_usage detector"
  type        = list(string)
  default     = []
}

variable "cpu_usage_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of cpu_usage detector"
  type        = list(string)
  default     = []
}

variable "cpu_usage_aggregation_function" {
  description = "Aggregation function and group by for cpu_usage detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['azure_resource_name', 'azure_resource_group_name', 'azure_region'])"
}

variable "cpu_usage_timer" {
  description = "Transformation window for cpu_usage detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "15m"
}

variable "cpu_usage_threshold_critical" {
  description = "Critical threshold for cpu_usage detector"
  type        = number
  default     = 90
}

variable "cpu_usage_threshold_warning" {
  description = "Warning threshold for cpu_usage detector"
  type        = number
  default     = 80
}

# free_storage detectors

variable "free_storage_disabled" {
  description = "Disable all alerting rules for free_storage detector"
  type        = bool
  default     = null
}

variable "free_storage_disabled_critical" {
  description = "Disable critical alerting rule for free_storage detector"
  type        = bool
  default     = null
}

variable "free_storage_disabled_warning" {
  description = "Disable warning alerting rule for free_storage detector"
  type        = bool
  default     = null
}

variable "free_storage_notifications" {
  description = "Notification recipients list for every alerting rules of free_storage detector"
  type        = list(string)
  default     = []
}

variable "free_storage_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of free_storage detector"
  type        = list(string)
  default     = []
}

variable "free_storage_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of free_storage detector"
  type        = list(string)
  default     = []
}

variable "free_storage_aggregation_function" {
  description = "Aggregation function and group by for free_storage detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['azure_resource_name', 'azure_resource_group_name', 'azure_region'])"
}

variable "free_storage_timer" {
  description = "Transformation window for free_storage detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "15m"
}

variable "free_storage_threshold_critical" {
  description = "Critical threshold for free_storage detector"
  type        = number
  default     = 10
}

variable "free_storage_threshold_warning" {
  description = "Warning threshold for free_storage detector"
  type        = number
  default     = 20
}

# io_consumption detectors

variable "io_consumption_disabled" {
  description = "Disable all alerting rules for io_consumption detector"
  type        = bool
  default     = null
}

variable "io_consumption_disabled_critical" {
  description = "Disable critical alerting rule for io_consumption detector"
  type        = bool
  default     = null
}

variable "io_consumption_disabled_warning" {
  description = "Disable warning alerting rule for io_consumption detector"
  type        = bool
  default     = null
}

variable "io_consumption_notifications" {
  description = "Notification recipients list for every alerting rules of io_consumption detector"
  type        = list(string)
  default     = []
}

variable "io_consumption_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of io_consumption detector"
  type        = list(string)
  default     = []
}

variable "io_consumption_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of io_consumption detector"
  type        = list(string)
  default     = []
}

variable "io_consumption_aggregation_function" {
  description = "Aggregation function and group by for io_consumption detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['azure_resource_name', 'azure_resource_group_name', 'azure_region'])"
}

variable "io_consumption_timer" {
  description = "Transformation window for io_consumption detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "15m"
}

variable "io_consumption_threshold_critical" {
  description = "Critical threshold for io_consumption detector"
  type        = number
  default     = 90
}

variable "io_consumption_threshold_warning" {
  description = "Warning threshold for io_consumption detector"
  type        = number
  default     = 80
}

# memory_usage detectors

variable "memory_usage_disabled" {
  description = "Disable all alerting rules for memory_usage detector"
  type        = bool
  default     = null
}

variable "memory_usage_disabled_critical" {
  description = "Disable critical alerting rule for memory_usage detector"
  type        = bool
  default     = null
}

variable "memory_usage_disabled_warning" {
  description = "Disable warning alerting rule for memory_usage detector"
  type        = bool
  default     = null
}

variable "memory_usage_notifications" {
  description = "Notification recipients list for every alerting rules of memory_usage detector"
  type        = list(string)
  default     = []
}

variable "memory_usage_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of memory_usage detector"
  type        = list(string)
  default     = []
}

variable "memory_usage_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of memory_usage detector"
  type        = list(string)
  default     = []
}

variable "memory_usage_aggregation_function" {
  description = "Aggregation function and group by for memory_usage detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['azure_resource_name', 'azure_resource_group_name', 'azure_region'])"
}

variable "memory_usage_timer" {
  description = "Transformation window for memory_usage detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "15m"
}

variable "memory_usage_threshold_critical" {
  description = "Critical threshold for memory_usage detector"
  type        = number
  default     = 90
}

variable "memory_usage_threshold_warning" {
  description = "Warning threshold for memory_usage detector"
  type        = number
  default     = 80
}
