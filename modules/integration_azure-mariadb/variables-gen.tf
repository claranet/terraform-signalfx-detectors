# heartbeat detector

variable "heartbeat_notifications" {
  description = "Notification recipients list per severity overridden for heartbeat detector"
  type        = map(list(string))
  default     = {}
}

variable "heartbeat_aggregation_function" {
  description = "Aggregation function and group by for heartbeat detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['azure_resource_id'])"
}

variable "heartbeat_transformation_function" {
  description = "Transformation function for heartbeat detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

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

variable "heartbeat_timeframe" {
  description = "Timeframe for heartbeat detector (i.e. \"10m\")"
  type        = string
  default     = "10m"
}

# cpu_usage detector

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

variable "cpu_usage_transformation_function" {
  description = "Transformation function for cpu_usage detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "cpu_usage_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "cpu_usage_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "cpu_usage_disabled" {
  description = "Disable all alerting rules for cpu_usage detector"
  type        = bool
  default     = null
}

variable "cpu_usage_disabled_major" {
  description = "Disable major alerting rule for cpu_usage detector"
  type        = bool
  default     = null
}

variable "cpu_usage_disabled_critical" {
  description = "Disable critical alerting rule for cpu_usage detector"
  type        = bool
  default     = null
}

variable "cpu_usage_threshold_major" {
  description = "Major threshold for cpu_usage detector in %"
  type        = number
  default     = 80
}

variable "cpu_usage_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "15m"
}

variable "cpu_usage_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "cpu_usage_threshold_critical" {
  description = "Critical threshold for cpu_usage detector in %"
  type        = number
  default     = 90
}

variable "cpu_usage_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "15m"
}

variable "cpu_usage_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# storage_usage detector

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

variable "storage_usage_transformation_function" {
  description = "Transformation function for storage_usage detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "storage_usage_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "storage_usage_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "storage_usage_disabled" {
  description = "Disable all alerting rules for storage_usage detector"
  type        = bool
  default     = null
}

variable "storage_usage_disabled_major" {
  description = "Disable major alerting rule for storage_usage detector"
  type        = bool
  default     = null
}

variable "storage_usage_disabled_critical" {
  description = "Disable critical alerting rule for storage_usage detector"
  type        = bool
  default     = null
}

variable "storage_usage_threshold_major" {
  description = "Major threshold for storage_usage detector in %"
  type        = number
  default     = 80
}

variable "storage_usage_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "15m"
}

variable "storage_usage_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "storage_usage_threshold_critical" {
  description = "Critical threshold for storage_usage detector in %"
  type        = number
  default     = 90
}

variable "storage_usage_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "15m"
}

variable "storage_usage_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# io_consumption detector

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

variable "io_consumption_transformation_function" {
  description = "Transformation function for io_consumption detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "io_consumption_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "io_consumption_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "io_consumption_disabled" {
  description = "Disable all alerting rules for io_consumption detector"
  type        = bool
  default     = null
}

variable "io_consumption_disabled_major" {
  description = "Disable major alerting rule for io_consumption detector"
  type        = bool
  default     = null
}

variable "io_consumption_disabled_critical" {
  description = "Disable critical alerting rule for io_consumption detector"
  type        = bool
  default     = null
}

variable "io_consumption_threshold_major" {
  description = "Major threshold for io_consumption detector in %"
  type        = number
  default     = 80
}

variable "io_consumption_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "15m"
}

variable "io_consumption_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "io_consumption_threshold_critical" {
  description = "Critical threshold for io_consumption detector in %"
  type        = number
  default     = 90
}

variable "io_consumption_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "15m"
}

variable "io_consumption_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# memory_usage detector

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

variable "memory_usage_transformation_function" {
  description = "Transformation function for memory_usage detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "memory_usage_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "memory_usage_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "memory_usage_disabled" {
  description = "Disable all alerting rules for memory_usage detector"
  type        = bool
  default     = null
}

variable "memory_usage_disabled_major" {
  description = "Disable major alerting rule for memory_usage detector"
  type        = bool
  default     = null
}

variable "memory_usage_disabled_critical" {
  description = "Disable critical alerting rule for memory_usage detector"
  type        = bool
  default     = null
}

variable "memory_usage_threshold_major" {
  description = "Major threshold for memory_usage detector in %"
  type        = number
  default     = 80
}

variable "memory_usage_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "15m"
}

variable "memory_usage_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "memory_usage_threshold_critical" {
  description = "Critical threshold for memory_usage detector in %"
  type        = number
  default     = 90
}

variable "memory_usage_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "15m"
}

variable "memory_usage_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# replication_lag detector

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

variable "replication_lag_transformation_function" {
  description = "Transformation function for replication_lag detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "replication_lag_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "replication_lag_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "replication_lag_disabled" {
  description = "Disable all alerting rules for replication_lag detector"
  type        = bool
  default     = null
}

variable "replication_lag_disabled_major" {
  description = "Disable major alerting rule for replication_lag detector"
  type        = bool
  default     = null
}

variable "replication_lag_disabled_critical" {
  description = "Disable critical alerting rule for replication_lag detector"
  type        = bool
  default     = null
}

variable "replication_lag_threshold_major" {
  description = "Major threshold for replication_lag detector in seconds"
  type        = number
  default     = 100
}

variable "replication_lag_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "15m"
}

variable "replication_lag_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "replication_lag_threshold_critical" {
  description = "Critical threshold for replication_lag detector in seconds"
  type        = number
  default     = 200
}

variable "replication_lag_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "15m"
}

variable "replication_lag_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
