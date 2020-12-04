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
  default     = ".mean(by=['azure_resource_name', 'azure_resource_group_name', 'azure_region'])"
}

# CPU_percentage detector

variable "cpu_percentage_disabled" {
  description = "Disable all alerting rules for cpu_percentage detector"
  type        = bool
  default     = null
}

variable "cpu_percentage_disabled_critical" {
  description = "Disable critical alerting rule for cpu_percentage detector"
  type        = bool
  default     = null
}

variable "cpu_percentage_disabled_major" {
  description = "Disable major alerting rule for cpu_percentage detector"
  type        = bool
  default     = null
}

variable "cpu_percentage_notifications" {
  description = "Notification recipients list per severity overridden for cpu_percentage detector"
  type        = map(list(string))
  default     = {}
}

variable "cpu_percentage_aggregation_function" {
  description = "Aggregation function and group by for cpu_percentage detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['Instance', 'azure_resource_name', 'azure_resource_group_name', 'azure_region'])"
}

variable "cpu_percentage_timer" {
  description = "Evaluation window for cpu_percentage detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "10m"
}

variable "cpu_percentage_threshold_critical" {
  description = "Critical threshold for cpu_percentage detector"
  type        = number
  default     = 95
}

variable "cpu_percentage_threshold_major" {
  description = "Major threshold for cpu_percentage detector"
  type        = number
  default     = 90
}

# memory_percentage detector

variable "memory_percentage_disabled" {
  description = "Disable all alerting rules for memory_percentage detector"
  type        = bool
  default     = null
}

variable "memory_percentage_disabled_critical" {
  description = "Disable critical alerting rule for memory_percentage detector"
  type        = bool
  default     = null
}

variable "memory_percentage_disabled_major" {
  description = "Disable major alerting rule for memory_percentage detector"
  type        = bool
  default     = null
}

variable "memory_percentage_notifications" {
  description = "Notification recipients list per severity overridden for memory_percentage detector"
  type        = map(list(string))
  default     = {}
}

variable "memory_percentage_aggregation_function" {
  description = "Aggregation function and group by for memory_percentage detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['Instance', 'azure_resource_name', 'azure_resource_group_name', 'azure_region'])"
}

variable "memory_percentage_timer" {
  description = "Evaluation window for memory_percentage detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "memory_percentage_threshold_critical" {
  description = "Critical threshold for memory_percentage detector"
  type        = number
  default     = 95
}

variable "memory_percentage_threshold_major" {
  description = "Major threshold for memory_percentage detector"
  type        = number
  default     = 90
}
