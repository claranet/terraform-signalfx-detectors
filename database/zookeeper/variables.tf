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

# SQL Server detectors specific

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

# zookeeper_latency detectors

variable "zookeeper_latency_disabled" {
  description = "Disable all alerting rules for zookeeper_latency detector"
  type        = bool
  default     = null
}

variable "zookeeper_latency_disabled_critical" {
  description = "Disable critical alerting rule for zookeeper_latency detector"
  type        = bool
  default     = null
}

variable "zookeeper_latency_disabled_warning" {
  description = "Disable warning alerting rule for zookeeper_latency detector"
  type        = bool
  default     = null
}

variable "zookeeper_latency_notifications" {
  description = "Notification recipients list for every alerting rules of zookeeper_latency detector"
  type        = list
  default     = []
}

variable "zookeeper_latency_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of zookeeper_latency detector"
  type        = list
  default     = []
}

variable "zookeeper_latency_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of zookeeper_latency detector"
  type        = list
  default     = []
}

variable "zookeeper_latency_aggregation_function" {
  description = "Aggregation function and group by for zookeeper_latency detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "zookeeper_latency_transformation_function" {
  description = "Transformation function for zookeeper_latency detector (mean, min, max)"
  type        = string
  default     = "mean"
}

variable "zookeeper_latency_transformation_window" {
  description = "Transformation window for zookeeper_latency detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "zookeeper_latency_threshold_critical" {
  description = "Critical threshold for zookeeper_latency detector"
  type        = number
  default     = 300000
}

variable "zookeeper_latency_threshold_warning" {
  description = "Warning threshold for zookeeper_latency detector"
  type        = number
  default     = 250000
}
