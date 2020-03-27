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

# MySQL detectors specific

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

# Too_many_locks detectors

variable "too_many_locks_disabled" {
  description = "Disable all alerting rules for too_many_locks detector"
  type        = bool
  default     = null
}

variable "too_many_locks_disabled_critical" {
  description = "Disable critical alerting rule for too_many_locks detector"
  type        = bool
  default     = null
}

variable "too_many_locks_disabled_warning" {
  description = "Disable warning alerting rule for too_many_locks detector"
  type        = bool
  default     = null
}

variable "too_many_locks_notifications" {
  description = "Notification recipients list for every alerting rules of too_many_locks detector"
  type        = list
  default     = []
}

variable "too_many_locks_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of too_many_locks detector"
  type        = list
  default     = []
}

variable "too_many_locks_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of too_many_locks detector"
  type        = list
  default     = []
}

variable "too_many_locks_aggregation_function" {
  description = "Aggregation function and group by for too_many_locks detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "too_many_locks_transformation_function" {
  description = "Transformation function for too_many_locks detector (mean, min, max)"
  type        = string
  default     = "min"
}

variable "too_many_locks_transformation_window" {
  description = "Transformation window for too_many_locks detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "too_many_locks_threshold_critical" {
  description = "Critical threshold for too_many_locks detector"
  type        = number
  default     = 99
}

variable "too_many_locks_threshold_warning" {
  description = "Warning threshold for too_many_locks detector"
  type        = number
  default     = 70
}

variable "too_many_locks_aperiodic_duration" {
  description = "Duration for the too_many_locks block"
  type        = string
  default     = "10m"
}

variable "too_many_locks_aperiodic_percentage" {
  description = "Percentage for the too_many_locks block"
  type        = number
  default     = 0.9
}

variable "too_many_locks_clear_duration" {
  description = "Duration for the too_many_locks clear condition"
  type        = string
  default     = "15m"
}
