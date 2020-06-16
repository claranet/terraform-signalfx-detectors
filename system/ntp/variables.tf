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

# System ntp specific

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

variable "ntp_disabled" {
  description = "Disable all alerting rules for ntp detector"
  type        = bool
  default     = null
}

variable "ntp_notifications" {
  description = "Notification recipients list for every alerting rules of ntp detector"
  type        = list
  default     = []
}

variable "ntp_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of ntp detector"
  type        = list
  default     = []
}

variable "ntp_aggregation_function" {
  description = "Aggregation function and group by for ntp detector (i.e. \".mean(by=['host']).\")"
  type        = string
  default     = ""
}

variable "ntp_transformation_function" {
  description = "Transformation function for ntp detector (mean, min, max)"
  type        = string
  default     = "min"
}

variable "ntp_transformation_window" {
  description = "Transformation window for ntp detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "ntp_threshold_warning" {
  description = "Warning threshold for ntp detector"
  type        = number
  default     = 1500
}
