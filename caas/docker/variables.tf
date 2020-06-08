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

# Docker detectors specific

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

# Memory_used detectors

variable "memory_used_disabled" {
  description = "Disable all alerting rules for memory_used detector"
  type        = bool
  default     = false
}

variable "memory_used_disabled_critical" {
  description = "Disable critical alerting rule for memory_used detector"
  type        = bool
  default     = null
}

variable "memory_used_disabled_warning" {
  description = "Disable warning alerting rule for memory_used detector"
  type        = bool
  default     = null
}

variable "memory_used_notifications" {
  description = "Notification recipients list for every alerting rules of memory_used detector"
  type        = list
  default     = []
}

variable "memory_used_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of memory_used detector"
  type        = list
  default     = []
}

variable "memory_used_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of memory_used detector"
  type        = list
  default     = []
}

variable "memory_used_aggregation_function" {
  description = "Aggregation function and group by for memory_used detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "memory_used_transformation_function" {
  description = "Transformation function for memory_used detector (mean, min, max)"
  type        = string
  default     = "min"
}

variable "memory_used_transformation_window" {
  description = "Transformation window for memory_used detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "memory_used_threshold_critical" {
  description = "Critical threshold for memory_used detector"
  type        = number
  default     = 90
}

variable "memory_used_threshold_warning" {
  description = "Warning threshold for memory_used detector"
  type        = number
  default     = 85
}
