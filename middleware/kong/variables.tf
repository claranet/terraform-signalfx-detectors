# Global

variable "environment" {
  description = "Infrastructure environment"
  type        = string
}

# SignalFx Module specific

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

# Kong Detector specific

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

#####

variable "treatment_limit_disabled" {
  description = "Disable all alerting rules for treatment limit detector"
  type        = bool
  default     = null
}

variable "treatment_limit_disabled_critical" {
  description = "Disable critical alerting rule for treatment limit detector"
  type        = bool
  default     = null
}

variable "treatment_limit_disabled_warning" {
  description = "Disable warning alerting rule for treatment limit detector"
  type        = bool
  default     = null
}

variable "treatment_limit_notifications" {
  description = "Notification recipients list for every alerting rules of treatment limit detector"
  type        = list
  default     = []
}

variable "treatment_limit_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of treatment limit detector"
  type        = list
  default     = []
}

variable "treatment_limit_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of treatment limit detector"
  type        = list
  default     = []
}

variable "treatment_limit_aggregation_function" {
  description = "Aggregation function and group by for treatment limit detector (i.e. \".mean(by=['host']).\")"
  type        = string
  default     = ""
}

variable "treatment_limit_transformation_function" {
  description = "Transformation function for treatment limit detector (mean, min, max)"
  type        = string
  default     = "min"
}

variable "treatment_limit_transformation_window" {
  description = "Transformation window for treatment limit detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "15m"
}

variable "treatment_limit_threshold_critical" {
  description = "Critical threshold for treatment limit detector"
  type        = number
  default     = 20
}

variable "treatment_limit_threshold_warning" {
  description = "Warning threshold for treatment limit detector"
  type        = number
  default     = 0
}

