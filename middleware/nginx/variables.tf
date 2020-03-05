# Global

variable "environment" {
  description = "Architecture Environment"
  type        = string
}

# SignalFx module specific

variable "notifications" {
  description = "Notification recipients semicolon separated (i.e. \"Email,my@mail.com;PagerDuty,credentialId\")"
  type        = string
}

variable "prefixes_slug" {
  description = "Prefixes list to prepend between brackets on every monitors names before environment"
  type        = list
  default     = []
}

variable "filter_use_defaults" {
  description = "Use default filtering which follows tagging convention"
  type        = bool
  default     = true
}

variable "filter_custom_includes" {
  description = "Tags to filter signals on when custom filtering is used (i.e \"tag1:val1;tag2:val2\")"
  type        = string
  default     = ""
}

variable "filter_custom_excludes" {
  description = "Tags to exclude when using custom filtering (i.e \"tag1:val1;tag2:val2\")"
  type        = string
  default     = ""
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
  description = "Notification recipients semicolon for every alerting rules of heartbeat detector"
  type        = string
  default     = ""
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
  description = "Notification recipients semicolon for every alerting rules of dropped connections detector"
  type        = string
  default     = ""
}

variable "dropped_connections_notifications_warning" {
  description = "Notification recipients semicolon for warning alerting rule of dropped connections detector"
  type        = string
  default     = ""
}

variable "dropped_connections_notifications_critical" {
  description = "Notification recipients semicolon for critical alerting rule of dropped connections detector"
  type        = string
  default     = ""
}

variable "dropped_connections_aggregation_function" {
  description = "Aggregation function and group by for dropped connections detector (i.e. \".mean(by=['host']).\")"
  type        = string
  default     = ""
}

variable "dropped_connections_transformation_function" {
  description = "Transformation function for dropped connections detector (mean, min, max)"
  type        = string
  default     = "min"
}

variable "dropped_connections_transformation_window" {
  description = "Transformation window for dropped connections detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
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

