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

# SSL detectors specific

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

# Invalid_ssl_certificate detectors

variable "invalid_ssl_certificate_disabled" {
  description = "Disable all alerting rules for invalid_ssl_certificate detector"
  type        = bool
  default     = null
}

variable "invalid_ssl_certificate_disabled_critical" {
  description = "Disable critical alerting rule for invalid_ssl_certificate detector"
  type        = bool
  default     = null
}

variable "invalid_ssl_certificate_disabled_warning" {
  description = "Disable warning alerting rule for invalid_ssl_certificate detector"
  type        = bool
  default     = null
}

variable "invalid_ssl_certificate_notifications" {
  description = "Notification recipients list for every alerting rules of invalid_ssl_certificate detector"
  type        = list
  default     = []
}

variable "invalid_ssl_certificate_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of invalid_ssl_certificate detector"
  type        = list
  default     = []
}

variable "invalid_ssl_certificate_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of invalid_ssl_certificate detector"
  type        = list
  default     = []
}

variable "invalid_ssl_certificate_aggregation_function" {
  description = "Aggregation function and group by for invalid_ssl_certificate detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "invalid_ssl_certificate_transformation_function" {
  description = "Transformation function for invalid_ssl_certificate detector (mean, min, max)"
  type        = string
  default     = "mean"
}

variable "invalid_ssl_certificate_transformation_window" {
  description = "Transformation window for invalid_ssl_certificate detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "15m"
}

variable "invalid_ssl_certificate_threshold_critical" {
  description = "Critical threshold for invalid_ssl_certificate detector"
  type        = number
  default     = 5
}

variable "invalid_ssl_certificate_threshold_warning" {
  description = "Warning threshold for invalid_ssl_certificate detector"
  type        = number
  default     = 3
}

# Certificate_expiration_date detectors

variable "certificate_expiration_date_disabled" {
  description = "Disable all alerting rules for certificate_expiration_date detector"
  type        = bool
  default     = null
}

variable "certificate_expiration_date_disabled_critical" {
  description = "Disable critical alerting rule for certificate_expiration_date detector"
  type        = bool
  default     = null
}

variable "certificate_expiration_date_disabled_warning" {
  description = "Disable warning alerting rule for certificate_expiration_date detector"
  type        = bool
  default     = null
}

variable "certificate_expiration_date_notifications" {
  description = "Notification recipients list for every alerting rules of certificate_expiration_date detector"
  type        = list
  default     = []
}

variable "certificate_expiration_date_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of certificate_expiration_date detector"
  type        = list
  default     = []
}

variable "certificate_expiration_date_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of certificate_expiration_date detector"
  type        = list
  default     = []
}

variable "certificate_expiration_date_aggregation_function" {
  description = "Aggregation function and group by for certificate_expiration_date detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "certificate_expiration_date_transformation_function" {
  description = "Transformation function for certificate_expiration_date detector (mean, min, max)"
  type        = string
  default     = "max"
}

variable "certificate_expiration_date_transformation_window" {
  description = "Transformation window for certificate_expiration_date detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "certificate_expiration_date_threshold_critical" {
  description = "Critical threshold for certificate_expiration_date detector"
  type        = number
  default     = 30
}

variable "certificate_expiration_date_threshold_warning" {
  description = "Warning threshold for certificate_expiration_date detector"
  type        = number
  default     = 15
}
