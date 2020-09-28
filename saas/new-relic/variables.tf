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

# New Relic detectors specific

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

# error_rate detectors

variable "error_rate_disabled" {
  description = "Disable all alerting rules for error_rate detector"
  type        = bool
  default     = null
}

variable "error_rate_disabled_critical" {
  description = "Disable critical alerting rule for error_rate detector"
  type        = bool
  default     = null
}

variable "error_rate_disabled_warning" {
  description = "Disable warning alerting rule for error_rate detector"
  type        = bool
  default     = null
}

variable "error_rate_notifications" {
  description = "Notification recipients list for every alerting rules of error_rate detector"
  type        = list
  default     = []
}

variable "error_rate_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of error_rate detector"
  type        = list
  default     = []
}

variable "error_rate_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of error_rate detector"
  type        = list
  default     = []
}

variable "error_rate_aggregation_function" {
  description = "Aggregation function and group by for error_rate detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "error_rate_transformation_function" {
  description = "Transformation function for error_rate detector (i.e. \".mean(over='5m')\"))"
  type        = string
  default     = ".min(over='5m')"
}

variable "error_rate_threshold_critical" {
  description = "Critical threshold for error_rate detector"
  type        = number
  default     = 5
}

variable "error_rate_threshold_warning" {
  description = "Warning threshold for error_rate detector"
  type        = number
  default     = 1
}

# apdex detectors

variable "apdex_disabled" {
  description = "Disable all alerting rules for apdex detector"
  type        = bool
  default     = null
}

variable "apdex_disabled_critical" {
  description = "Disable critical alerting rule for apdex detector"
  type        = bool
  default     = null
}

variable "apdex_disabled_warning" {
  description = "Disable warning alerting rule for apdex detector"
  type        = bool
  default     = null
}

variable "apdex_notifications" {
  description = "Notification recipients list for every alerting rules of apdex detector"
  type        = list
  default     = []
}

variable "apdex_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of apdex detector"
  type        = list
  default     = []
}

variable "apdex_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of apdex detector"
  type        = list
  default     = []
}

variable "apdex_aggregation_function" {
  description = "Aggregation function and group by for apdex detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "apdex_transformation_function" {
  description = "Transformation function for apdex detector (i.e. \".mean(over='5m')\"))"
  type        = string
  default     = ".mean(over='15m')"
}

variable "apdex_threshold_critical" {
  description = "Critical threshold for apdex detector"
  type        = number
  default     = 0.25
}

variable "apdex_threshold_warning" {
  description = "Warning threshold for apdex detector"
  type        = number
  default     = 0.5
}

