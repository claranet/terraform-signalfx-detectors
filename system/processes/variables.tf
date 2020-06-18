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

#####

variable "processes_disabled" {
  description = "Disable all alerting rules for processes detector"
  type        = bool
  default     = null
}

variable "processes_disabled_critical" {
  description = "Disable critical alerting rule for processes detector"
  type        = bool
  default     = null
}

variable "processes_disabled_warning" {
  description = "Disable warning alerting rule for processes detector"
  type        = bool
  default     = true
}

variable "processes_notifications" {
  description = "Notification recipients list for every alerting rules of processes detector"
  type        = list
  default     = []
}

variable "processes_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of processes detector"
  type        = list
  default     = []
}

variable "processes_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of processes detector"
  type        = list
  default     = []
}

variable "processes_aggregation_function" {
  description = "Aggregation function and group by for processes detector (i.e. \".mean(by=['host']).\")"
  type        = string
  default     = ""
}

variable "processes_transformation_function" {
  description = "Transformation function for processes detector (mean, min, max)"
  type        = string
  default     = "min"
}

variable "processes_transformation_window" {
  description = "Transformation window for processes detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "15m"
}

variable "processes_threshold_warning" {
  description = "Warning threshold for processes detector"
  type        = number
  default     = 2
}

