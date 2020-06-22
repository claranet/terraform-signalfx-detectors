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

# AWS ElastiCache detectors specific

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

# Get_hits detectors

variable "get_hits_disabled" {
  description = "Disable all alerting rules for get_hits detector"
  type        = bool
  default     = null
}

variable "get_hits_disabled_critical" {
  description = "Disable critical alerting rule for get_hits detector"
  type        = bool
  default     = null
}

variable "get_hits_disabled_warning" {
  description = "Disable warning alerting rule for get_hits detector"
  type        = bool
  default     = null
}

variable "get_hits_notifications" {
  description = "Notification recipients list for every alerting rules of get_hits detector"
  type        = list
  default     = []
}

variable "get_hits_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of get_hits detector"
  type        = list
  default     = []
}

variable "get_hits_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of get_hits detector"
  type        = list
  default     = []
}

variable "get_hits_aggregation_function" {
  description = "Aggregation function and group by for get_hits detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "get_hits_transformation_function" {
  description = "Transformation function for get_hits detector (mean, min, max)"
  type        = string
  default     = "max"
}

variable "get_hits_transformation_window" {
  description = "Transformation window for get_hits detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "15m"
}

variable "get_hits_threshold_critical" {
  description = "Critical threshold for get_hits detector"
  type        = number
  default     = 60
}

variable "get_hits_threshold_warning" {
  description = "Warning threshold for get_hits detector"
  type        = number
  default     = 80
}

variable "get_hits_aperiodic_duration" {
  description = "Duration for the get_hits block"
  type        = string
  default     = "10m"
}

variable "get_hits_aperiodic_percentage" {
  description = "Percentage for the get_hits block"
  type        = number
  default     = 0.9
}

variable "get_hits_clear_duration" {
  description = "Duration for the get_hits clear condition"
  type        = string
  default     = "15m"
}

# cpu_high detectors

variable "cpu_high_disabled" {
  description = "Disable all alerting rules for cpu_high detector"
  type        = bool
  default     = null
}

variable "cpu_high_disabled_critical" {
  description = "Disable critical alerting rule for cpu_high detector"
  type        = bool
  default     = null
}

variable "cpu_high_disabled_warning" {
  description = "Disable warning alerting rule for httpcode 5xx erros detector"
  type        = bool
  default     = null
}

variable "cpu_high_notifications" {
  description = "Notification recipients list for every alerting rules of cpu_high detector"
  type        = list
  default     = []
}

variable "cpu_high_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of cpu_high detector"
  type        = list
  default     = []
}

variable "cpu_high_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of cpu_high detector"
  type        = list
  default     = []
}

variable "cpu_high_aggregation_function" {
  description = "Aggregation function and group by for cpu_high detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "cpu_high_transformation_function" {
  description = "Transformation function for cpu_high detector (mean, min, max)"
  type        = string
  default     = "min"
}

variable "cpu_high_transformation_window" {
  description = "Transformation window for cpu_high detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "15m"
}

variable "cpu_high_threshold_critical" {
  description = "Critical threshold for cpu_high detector"
  type        = number
  default     = 90
}

variable "cpu_high_threshold_warning" {
  description = "Warning threshold for cpu_high detector"
  type        = number
  default     = 75
}
