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

# Azure mysql detectors specific

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

variable "cpu_usage_disabled_major" {
  description = "Disable major alerting rule for cpu_usage detector"
  type        = bool
  default     = null
}

variable "cpu_usage_notifications" {
  description = "Notification recipients list per severity overridden for cpu_usage detector"
  type        = map(list(string))
  default     = {}
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

variable "cpu_usage_threshold_major" {
  description = "Major threshold for cpu_usage detector"
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

variable "free_storage_disabled_major" {
  description = "Disable major alerting rule for free_storage detector"
  type        = bool
  default     = null
}

variable "free_storage_notifications" {
  description = "Notification recipients list per severity overridden for free_storage detector"
  type        = map(list(string))
  default     = {}
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

variable "free_storage_threshold_major" {
  description = "Major threshold for free_storage detector"
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

variable "io_consumption_disabled_major" {
  description = "Disable major alerting rule for io_consumption detector"
  type        = bool
  default     = null
}

variable "io_consumption_notifications" {
  description = "Notification recipients list per severity overridden for io_consumption detector"
  type        = map(list(string))
  default     = {}
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

variable "io_consumption_threshold_major" {
  description = "Major threshold for io_consumption detector"
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

variable "memory_usage_disabled_major" {
  description = "Disable major alerting rule for memory_usage detector"
  type        = bool
  default     = null
}

variable "memory_usage_notifications" {
  description = "Notification recipients list per severity overridden for memory_usage detector"
  type        = map(list(string))
  default     = {}
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

variable "memory_usage_threshold_major" {
  description = "Major threshold for memory_usage detector"
  type        = number
  default     = 80
}

# replication_lag detectors

variable "replication_lag_disabled" {
  description = "Disable all alerting rules for replication_lag detector"
  type        = bool
  default     = null
}

variable "replication_lag_disabled_critical" {
  description = "Disable critical alerting rule for replication_lag detector"
  type        = bool
  default     = null
}

variable "replication_lag_disabled_major" {
  description = "Disable major alerting rule for replication_lag detector"
  type        = bool
  default     = null
}

variable "replication_lag_notifications" {
  description = "Notification recipients list per severity overridden for replication_lag detector"
  type        = map(list(string))
  default     = {}
}

variable "replication_lag_aggregation_function" {
  description = "Aggregation function and group by for replication_lag detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['azure_resource_name', 'azure_resource_group_name', 'azure_region'])"
}

variable "replication_lag_timer" {
  description = "Transformation window for replication_lag detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "15m"
}

variable "replication_lag_threshold_critical" {
  description = "Critical threshold in seconds for replication_lag detector"
  type        = number
  default     = 200
}

variable "replication_lag_threshold_major" {
  description = "Major threshold in seconds for replication_lag detector"
  type        = number
  default     = 100
}
