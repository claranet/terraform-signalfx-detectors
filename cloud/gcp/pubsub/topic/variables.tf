# Global

variable "environment" {
  description = "Infrastructure environment"
  type        = string
}

variable "gcp_project_id" {
  description = "GCP project id used for default filtering while lables are not synced"
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

# GCP Pub/Sub Topic detectors specific

# sending_operations detectors

variable "sending_operations_disabled" {
  description = "Disable all alerting rules for sending_operations detector"
  type        = bool
  default     = true
}

variable "sending_operations_notifications" {
  description = "Notification recipients list for every alerting rules of sending_operations detector"
  type        = list
  default     = []
}

variable "sending_operations_aggregation_function" {
  description = "Aggregation function and group by for sending_operations detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "sending_operations_transformation_function" {
  description = "Transformation function for sending_operations detector (i.e. \".mean(over='5m')\"))"
  type        = string
  default     = ".sum(over='30m')"
}

variable "sending_operations_threshold_warning" {
  description = "Warning threshold for sending_operations detector"
  type        = number
  default     = 1
}

# Unavailable_sending_operations detectors

variable "unavailable_sending_operations_disabled" {
  description = "Disable all alerting rules for unavailable_sending_operations detector"
  type        = bool
  default     = true
}

variable "unavailable_sending_operations_disabled_critical" {
  description = "Disable critical alerting rule for unavailable_sending_operations detector"
  type        = bool
  default     = null
}

variable "unavailable_sending_operations_disabled_warning" {
  description = "Disable warning alerting rule for unavailable_sending_operations detector"
  type        = bool
  default     = null
}

variable "unavailable_sending_operations_notifications" {
  description = "Notification recipients list for every alerting rules of unavailable_sending_operations detector"
  type        = list
  default     = []
}

variable "unavailable_sending_operations_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of unavailable_sending_operations detector"
  type        = list
  default     = []
}

variable "unavailable_sending_operations_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of unavailable_sending_operations detector"
  type        = list
  default     = []
}

variable "unavailable_sending_operations_aggregation_function" {
  description = "Aggregation function and group by for unavailable_sending_operations detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "unavailable_sending_operations_transformation_function" {
  description = "Transformation function for unavailable_sending_operations detector (i.e. \".mean(over='5m')\"))"
  type        = string
  default     = ".sum(over='15m')"
}

variable "unavailable_sending_operations_threshold_critical" {
  description = "Critical threshold for unavailable_sending_operations detector"
  type        = number
  default     = 5
}

variable "unavailable_sending_operations_threshold_warning" {
  description = "Warning threshold for unavailable_sending_operations detector"
  type        = number
  default     = 0
}

# Unavailable_sending_operations_ratio detectors

variable "unavailable_sending_operations_ratio_disabled" {
  description = "Disable all alerting rules for unavailable_sending_operations_ratio detector"
  type        = bool
  default     = null
}

variable "unavailable_sending_operations_ratio_disabled_critical" {
  description = "Disable critical alerting rule for unavailable_sending_operations_ratio detector"
  type        = bool
  default     = null
}

variable "unavailable_sending_operations_ratio_disabled_warning" {
  description = "Disable warning alerting rule for unavailable_sending_operations_ratio detector"
  type        = bool
  default     = null
}

variable "unavailable_sending_operations_ratio_notifications" {
  description = "Notification recipients list for every alerting rules of unavailable_sending_operations_ratio detector"
  type        = list
  default     = []
}

variable "unavailable_sending_operations_ratio_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of unavailable_sending_operations_ratio detector"
  type        = list
  default     = []
}

variable "unavailable_sending_operations_ratio_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of unavailable_sending_operations_ratio detector"
  type        = list
  default     = []
}

variable "unavailable_sending_operations_ratio_aggregation_function" {
  description = "Aggregation function and group by for unavailable_sending_operations_ratio detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "unavailable_sending_operations_ratio_transformation_function" {
  description = "Transformation function for unavailable_sending_operations_ratio detector (i.e. \".mean(over='5m')\"))"
  type        = string
  default     = ".sum(over='15m')"
}

variable "unavailable_sending_operations_ratio_threshold_critical" {
  description = "Critical threshold for unavailable_sending_operations_ratio detector"
  type        = number
  default     = 20
}

variable "unavailable_sending_operations_ratio_threshold_warning" {
  description = "Warning threshold for unavailable_sending_operations_ratio detector"
  type        = number
  default     = 0
}

