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

# Azure loadbalancer detectors specific

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

# status detectors

variable "status_disabled" {
  description = "Disable all alerting rules for status detector"
  type        = bool
  default     = null
}

variable "status_disabled_critical" {
  description = "Disable critical alerting rule for status detector"
  type        = bool
  default     = null
}

variable "status_disabled_warning" {
  description = "Disable warning alerting rule for status detector"
  type        = bool
  default     = null
}

variable "status_notifications" {
  description = "Notification recipients list for every alerting rules of status detector"
  type        = list
  default     = []
}

variable "status_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of status detector"
  type        = list
  default     = []
}

variable "status_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of status detector"
  type        = list
  default     = []
}

variable "status_aggregation_function" {
  description = "Aggregation function and group by for status detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['azure_resource_id', 'azure_resource_name'])"
}

variable "status_transformation_function" {
  description = "Transformation function for status detector (mean, min, max)"
  type        = string
  default     = "max"
}

variable "status_transformation_window" {
  description = "Transformation window for status detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "status_threshold_critical" {
  description = "Critical threshold for status detector"
  type        = number
  default     = 1
}
