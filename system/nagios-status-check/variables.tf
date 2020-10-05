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

variable "status_check_disabled" {
  description = "Disable all alerting rules for status_check detector"
  type        = bool
  default     = null
}

variable "status_check_disabled_critical" {
  description = "Disable critical alerting rule for status_check detector"
  type        = bool
  default     = null
}

variable "status_check_disabled_warning" {
  description = "Disable warning alerting rule for status_check detector"
  type        = bool
  default     = null
}

variable "status_check_disabled_major" {
  description = "Disable major alerting rule for status_check detector"
  type        = bool
  default     = null
}

variable "status_check_notifications" {
  description = "Notification recipients list for every alerting rules of status_check detector"
  type        = list
  default     = []
}

variable "status_check_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of status_check detector"
  type        = list
  default     = []
}

variable "status_check_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of status_check detector"
  type        = list
  default     = []
}

variable "status_check_notifications_major" {
  description = "Notification recipients list for major alerting rule of status_check detector"
  type        = list
  default     = []
}

variable "status_check_aggregation_function" {
  description = "Aggregation function and group by for status_check detector (i.e. \".mean(by=['host']).\")"
  type        = string
  default     = ""
}

variable "status_check_transformation_function" {
  description = "Transformation function for status_check detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "status_check_lasting_duration_seconds" {
  description = "Minimum duration that conditions must be true before raising alert (in seconds)"
  type        = string
  default     = "900"
}

