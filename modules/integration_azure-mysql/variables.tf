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
  default     = ".mean(by=['azure_resource_id'])"
}

# cpu_usage detector

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

# storage_usage detectors

variable "storage_usage_disabled" {
  description = "Disable all alerting rules for storage_usage detector"
  type        = bool
  default     = null
}

variable "storage_usage_disabled_critical" {
  description = "Disable critical alerting rule for storage_usage detector"
  type        = bool
  default     = null
}

variable "storage_usage_disabled_major" {
  description = "Disable major alerting rule for storage_usage detector"
  type        = bool
  default     = null
}

variable "storage_usage_notifications" {
  description = "Notification recipients list per severity overridden for storage_usage detector"
  type        = map(list(string))
  default     = {}
}

variable "storage_usage_aggregation_function" {
  description = "Aggregation function and group by for storage_usage detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['azure_resource_name', 'azure_resource_group_name', 'azure_region'])"
}

variable "storage_usage_timer" {
  description = "Transformation window for storage_usage detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "15m"
}

variable "storage_usage_threshold_critical" {
  description = "Critical threshold for storage_usage detector"
  type        = number
  default     = 90
}

variable "storage_usage_threshold_major" {
  description = "Major threshold for storage_usage detector"
  type        = number
  default     = 80
}

# io_consumption detector

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

# memory_usage detector

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

# replication_lag detector

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
