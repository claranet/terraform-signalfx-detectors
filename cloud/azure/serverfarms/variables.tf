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

# Azure serverfarms detectors specific

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

# CPU_percentage detectors

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

variable "cpu_percentage_disabled_warning" {
  description = "Disable warning alerting rule for cpu_percentage detector"
  type        = bool
  default     = null
}

variable "cpu_percentage_notifications" {
  description = "Notification recipients list for every alerting rules of cpu_percentage detector"
  type        = list
  default     = []
}

variable "cpu_percentage_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of cpu_percentage detector"
  type        = list
  default     = []
}

variable "cpu_percentage_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of cpu_percentage detector"
  type        = list
  default     = []
}

variable "cpu_percentage_aggregation_function" {
  description = "Aggregation function and group by for cpu_percentage detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['azure_region', 'azure_resource_id', 'azure_resource_name'])"
}

variable "cpu_percentage_transformation_function" {
  description = "Transformation function for cpu_percentage detector (mean, min, max)"
  type        = string
  default     = "min"
}

variable "cpu_percentage_transformation_window" {
  description = "Transformation window for cpu_percentage detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "10m"
}

variable "cpu_percentage_threshold_critical" {
  description = "Critical threshold for cpu_percentage detector"
  type        = number
  default     = 95
}

variable "cpu_percentage_threshold_warning" {
  description = "Warning threshold for cpu_percentage detector"
  type        = number
  default     = 90
}

# memory_percentage detectors

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

variable "memory_percentage_disabled_warning" {
  description = "Disable warning alerting rule for memory_percentage detector"
  type        = bool
  default     = null
}

variable "memory_percentage_notifications" {
  description = "Notification recipients list for every alerting rules of memory_percentage detector"
  type        = list
  default     = []
}

variable "memory_percentage_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of memory_percentage detector"
  type        = list
  default     = []
}

variable "memory_percentage_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of memory_percentage detector"
  type        = list
  default     = []
}

variable "memory_percentage_aggregation_function" {
  description = "Aggregation function and group by for memory_percentage detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['azure_region', 'azure_resource_id', 'azure_resource_name'])"
}

variable "memory_percentage_transformation_function" {
  description = "Transformation function for memory_percentage detector (mean, min, max)"
  type        = string
  default     = "min"
}

variable "memory_percentage_transformation_window" {
  description = "Transformation window for memory_percentage detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "memory_percentage_threshold_critical" {
  description = "Critical threshold for memory_percentage detector"
  type        = number
  default     = 95
}

variable "memory_percentage_threshold_warning" {
  description = "Warning threshold for memory_percentage detector"
  type        = number
  default     = 90
}
