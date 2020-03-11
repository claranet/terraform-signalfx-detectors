# Global

variable "environment" {
  description = "Infrastructure environment"
  type        = string
}

# SignalFx module specific

variable "notifications" {
  description = "Notification recipients list (i.e. \"Email,my@mail.com;PagerDuty,credentialId\")"
  type        = list
}

variable "prefixes" {
  description = "Prefixes list to prepend between brackets on every monitors names before environment"
  type        = list
  default     = []
}

variable "filter_defaults" {
  description = "Default string to use as default filtering which follows tagging convention"
  type        = string
  default     = "filter('env', '${var.environment}') and filter('claranet_monitored', 'true')"
}

variable "filter_custom_includes" {
  description = "Filters list to include when using custom filtering"
  type        = list
  default     = []
}

variable "filter_custom_excludes" {
  description = "Filters list to exclude when using custom filtering"
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

