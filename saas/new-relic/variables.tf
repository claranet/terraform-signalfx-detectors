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

# App_error_rate detectors

variable "app_error_rate_disabled" {
  description = "Disable all alerting rules for app_error_rate detector"
  type        = bool
  default     = null
}

variable "app_error_rate_disabled_critical" {
  description = "Disable critical alerting rule for app_error_rate detector"
  type        = bool
  default     = null
}

variable "app_error_rate_disabled_warning" {
  description = "Disable warning alerting rule for app_error_rate detector"
  type        = bool
  default     = null
}

variable "app_error_rate_notifications" {
  description = "Notification recipients list for every alerting rules of app_error_rate detector"
  type        = list
  default     = []
}

variable "app_error_rate_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of app_error_rate detector"
  type        = list
  default     = []
}

variable "app_error_rate_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of app_error_rate detector"
  type        = list
  default     = []
}

variable "app_error_rate_aggregation_function" {
  description = "Aggregation function and group by for app_error_rate detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "app_error_rate_transformation_function" {
  description = "Transformation function for app_error_rate detector (mean, min, max)"
  type        = string
  default     = "min"
}

variable "app_error_rate_transformation_window" {
  description = "Transformation window for app_error_rate detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "app_error_rate_threshold_critical" {
  description = "Critical threshold for app_error_rate detector"
  type        = number
  default     = 5
}

variable "app_error_rate_threshold_warning" {
  description = "Warning threshold for app_error_rate detector"
  type        = number
  default     = 1
}

# App_apdex_score detectors

variable "app_apdex_score_disabled" {
  description = "Disable all alerting rules for app_apdex_score detector"
  type        = bool
  default     = null
}

variable "app_apdex_score_disabled_critical" {
  description = "Disable critical alerting rule for app_apdex_score detector"
  type        = bool
  default     = null
}

variable "app_apdex_score_disabled_warning" {
  description = "Disable warning alerting rule for app_apdex_score detector"
  type        = bool
  default     = null
}

variable "app_apdex_score_notifications" {
  description = "Notification recipients list for every alerting rules of app_apdex_score detector"
  type        = list
  default     = []
}

variable "app_apdex_score_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of app_apdex_score detector"
  type        = list
  default     = []
}

variable "app_apdex_score_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of app_apdex_score detector"
  type        = list
  default     = []
}

variable "app_apdex_score_aggregation_function" {
  description = "Aggregation function and group by for app_apdex_score detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "app_apdex_score_transformation_function" {
  description = "Transformation function for app_apdex_score detector (mean, min, max)"
  type        = string
  default     = "mean"
}

variable "app_apdex_score_transformation_window" {
  description = "Transformation window for app_apdex_score detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "15m"
}

variable "app_apdex_score_threshold_critical" {
  description = "Critical threshold for app_apdex_score detector"
  type        = number
  default     = 0.25
}

variable "app_apdex_score_threshold_warning" {
  description = "Warning threshold for app_apdex_score detector"
  type        = number
  default     = 0.5
}
