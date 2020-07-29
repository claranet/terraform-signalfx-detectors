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

# Azure redis detectors specific

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

# Evictedkeys detectors

variable "evictedkeys_disabled" {
  description = "Disable all alerting rules for evictedkeys detector"
  type        = bool
  default     = null
}

variable "evictedkeys_disabled_critical" {
  description = "Disable critical alerting rule for evictedkeys detector"
  type        = bool
  default     = null
}

variable "evictedkeys_disabled_warning" {
  description = "Disable warning alerting rule for evictedkeys detector"
  type        = bool
  default     = null
}

variable "evictedkeys_notifications" {
  description = "Notification recipients list for every alerting rules of evictedkeys detector"
  type        = list(string)
  default     = []
}

variable "evictedkeys_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of evictedkeys detector"
  type        = list(string)
  default     = []
}

variable "evictedkeys_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of evictedkeys detector"
  type        = list(string)
  default     = []
}

variable "evictedkeys_aggregation_function" {
  description = "Aggregation function and group by for evictedkeys detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['azure_resource_name', 'azure_resource_group_name', 'azure_region'])"
}

variable "evictedkeys_timer" {
  description = "Evaluation window for evictedkeys detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "evictedkeys_threshold_critical" {
  description = "Critical threshold for evictedkeys detector"
  type        = number
  default     = 100
}

variable "evictedkeys_threshold_warning" {
  description = "Warning threshold for evictedkeys detector"
  type        = number
  default     = 0
}

# percent_processor_time detectors

variable "percent_processor_time_disabled" {
  description = "Disable all alerting rules for percent_processor_time detector"
  type        = bool
  default     = null
}

variable "percent_processor_time_disabled_critical" {
  description = "Disable critical alerting rule for percent_processor_time detector"
  type        = bool
  default     = null
}

variable "percent_processor_time_disabled_warning" {
  description = "Disable warning alerting rule for percent_processor_time detector"
  type        = bool
  default     = null
}

variable "percent_processor_time_notifications" {
  description = "Notification recipients list for every alerting rules of percent_processor_time detector"
  type        = list(string)
  default     = []
}

variable "percent_processor_time_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of percent_processor_time detector"
  type        = list(string)
  default     = []
}

variable "percent_processor_time_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of percent_processor_time detector"
  type        = list(string)
  default     = []
}

variable "percent_processor_time_aggregation_function" {
  description = "Aggregation function and group by for percent_processor_time detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['shardid', 'azure_resource_name', 'azure_resource_group_name', 'azure_region'])"
}

variable "percent_processor_time_timer" {
  description = "Evaluation window for percent_processor_time detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "percent_processor_time_threshold_critical" {
  description = "Critical threshold for percent_processor_time detector"
  type        = number
  default     = 80
}

variable "percent_processor_time_threshold_warning" {
  description = "Warning threshold for percent_processor_time detector"
  type        = number
  default     = 60
}

# load detectors

variable "load_disabled" {
  description = "Disable all alerting rules for load detector"
  type        = bool
  default     = null
}

variable "load_disabled_critical" {
  description = "Disable critical alerting rule for load detector"
  type        = bool
  default     = null
}

variable "load_disabled_warning" {
  description = "Disable warning alerting rule for load detector"
  type        = bool
  default     = null
}

variable "load_notifications" {
  description = "Notification recipients list for every alerting rules of load detector"
  type        = list(string)
  default     = []
}

variable "load_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of load detector"
  type        = list(string)
  default     = []
}

variable "load_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of load detector"
  type        = list(string)
  default     = []
}

variable "load_aggregation_function" {
  description = "Aggregation function and group by for load detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['shardid', 'azure_resource_name', 'azure_resource_group_name', 'azure_region'])"
}

variable "load_timer" {
  description = "Evaluation window for load detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "load_threshold_critical" {
  description = "Critical threshold for load detector"
  type        = number
  default     = 90
}

variable "load_threshold_warning" {
  description = "Warning threshold for load detector"
  type        = number
  default     = 70
}
