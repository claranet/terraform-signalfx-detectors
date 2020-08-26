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

# Nginx detectors specific

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

variable "dropped_connections_disabled" {
  description = "Disable all alerting rules for dropped connections detector"
  type        = bool
  default     = null
}

variable "dropped_connections_disabled_critical" {
  description = "Disable critical alerting rule for dropped connections detector"
  type        = bool
  default     = null
}

variable "dropped_connections_disabled_warning" {
  description = "Disable warning alerting rule for dropped connections detector"
  type        = bool
  default     = null
}

variable "dropped_connections_notifications" {
  description = "Notification recipients list for every alerting rules of dropped connections detector"
  type        = list
  default     = []
}

variable "dropped_connections_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of dropped connections detector"
  type        = list
  default     = []
}

variable "dropped_connections_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of dropped connections detector"
  type        = list
  default     = []
}

variable "dropped_connections_aggregation_function" {
  description = "Aggregation function and group by for dropped connections detector (i.e. \".mean(by=['host']).\")"
  type        = string
  default     = ""
}

variable "dropped_connections_transformation_function" {
  description = "Transformation function for dropped connections detector (i.e. \".mean(over='5m')\"))"
  type        = string
  default     = ".min(over='5m')"
}

variable "dropped_connections_threshold_critical" {
  description = "Critical threshold for dropped connections detector"
  type        = number
  default     = 1
}

variable "dropped_connections_threshold_warning" {
  description = "Warning threshold for dropped connections detector"
  type        = number
  default     = 0
}

