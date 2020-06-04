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

# WebCheck detectors specific

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

# Http_code_matched detectors

variable "http_code_matched_disabled" {
  description = "Disable all alerting rules for http_code_matched detector"
  type        = bool
  default     = null
}

variable "http_code_matched_disabled_critical" {
  description = "Disable critical alerting rule for http_code_matched detector"
  type        = bool
  default     = null
}

variable "http_code_matched_notifications" {
  description = "Notification recipients list for every alerting rules of http_code_matched detector"
  type        = list
  default     = []
}

variable "http_code_matched_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of http_code_matched detector"
  type        = list
  default     = []
}

variable "http_code_matched_aggregation_function" {
  description = "Aggregation function and group by for http_code_matched detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['url']"
}

variable "http_code_matched_transformation_function" {
  description = "Transformation function for http_code_matched detector (mean, min, max)"
  type        = string
  default     = "mean"
}

variable "http_code_matched_transformation_window" {
  description = "Transformation window for http_code_matched detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "15m"
}

variable "http_code_matched_threshold_critical" {
  description = "Critical threshold for http_code_matched detector"
  type        = number
  default     = 1
}

# Http_regex_matched detectors

variable "http_regex_matched_disabled" {
  description = "Disable all alerting rules for http_regex_matched detector"
  type        = bool
  default     = null
}

variable "http_regex_matched_disabled_critical" {
  description = "Disable critical alerting rule for http_regex_matched detector"
  type        = bool
  default     = null
}

variable "http_regex_matched_notifications" {
  description = "Notification recipients list for every alerting rules of http_regex_matched detector"
  type        = list
  default     = []
}

variable "http_regex_matched_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of http_regex_matched detector"
  type        = list
  default     = []
}

variable "http_regex_matched_aggregation_function" {
  description = "Aggregation function and group by for http_regex_matched detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['url']"
}

variable "http_regex_matched_transformation_function" {
  description = "Transformation function for http_regex_matched detector (mean, min, max)"
  type        = string
  default     = "mean"
}

variable "http_regex_matched_transformation_window" {
  description = "Transformation window for http_regex_matched detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "15m"
}

variable "http_regex_matched_threshold_critical" {
  description = "Critical threshold for http_regex_matched detector"
  type        = number
  default     = 1
}

# Http_response_time detectors

variable "http_response_time_disabled" {
  description = "Disable all alerting rules for http_response_time detector"
  type        = bool
  default     = null
}

variable "http_response_time_disabled_critical" {
  description = "Disable critical alerting rule for http_response_time detector"
  type        = bool
  default     = null
}

variable "http_response_time_disabled_warning" {
  description = "Disable warning alerting rule for http_response_time detector"
  type        = bool
  default     = null
}

variable "http_response_time_notifications" {
  description = "Notification recipients list for every alerting rules of http_response_time detector"
  type        = list
  default     = []
}

variable "http_response_time_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of http_response_time detector"
  type        = list
  default     = []
}

variable "http_response_time_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of http_response_time detector"
  type        = list
  default     = []
}

variable "http_response_time_aggregation_function" {
  description = "Aggregation function and group by for http_response_time detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "http_response_time_transformation_function" {
  description = "Transformation function for http_response_time detector (mean, min, max)"
  type        = string
  default     = "mean"
}

variable "http_response_time_transformation_window" {
  description = "Transformation window for http_response_time detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "15m"
}

variable "http_response_time_threshold_critical" {
  description = "Critical threshold for http_response_time detector"
  type        = number
  default     = 10
}

variable "http_response_time_threshold_warning" {
  description = "Warning threshold for http_response_time detector"
  type        = number
  default     = 5
}

# http_content_length detectors

variable "http_content_length_disabled" {
  description = "Disable all alerting rules for http_content_length detector"
  type        = bool
  default     = null
}

variable "http_content_length_disabled_critical" {
  description = "Disable critical alerting rule for http_content_length detector"
  type        = bool
  default     = null
}

variable "http_content_length_disabled_warning" {
  description = "Disable warning alerting rule for http_content_length detector"
  type        = bool
  default     = null
}

variable "http_content_length_notifications" {
  description = "Notification recipients list for every alerting rules of http_content_length detector"
  type        = list
  default     = []
}

variable "http_content_length_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of http_content_length detector"
  type        = list
  default     = []
}

variable "http_content_length_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of http_content_length detector"
  type        = list
  default     = []
}

variable "http_content_length_aggregation_function" {
  description = "Aggregation function and group by for http_content_length detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['url'])"
}

variable "http_content_length_transformation_function" {
  description = "Transformation function for http_content_length detector (mean, min, max)"
  type        = string
  default     = "mean"
}

variable "http_content_length_transformation_window" {
  description = "Transformation window for http_content_length detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "15m"
}

variable "http_content_length_threshold_critical" {
  description = "Critical threshold for http_content_length detector"
  type        = number
  default     = 2
}

variable "http_content_length_threshold_warning" {
  description = "Warning threshold for http_content_length detector"
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
  default     = ".mean(by=['url'])"
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
  default     = 15
}

variable "certificate_expiration_date_threshold_warning" {
  description = "Warning threshold for certificate_expiration_date detector"
  type        = number
  default     = 30
}

# Invalid_tls_certificate detectors

variable "invalid_tls_certificate_disabled" {
  description = "Disable all alerting rules for invalid_tls_certificate detector"
  type        = bool
  default     = null
}

variable "invalid_tls_certificate_disabled_critical" {
  description = "Disable critical alerting rule for invalid_tls_certificate detector"
  type        = bool
  default     = null
}

variable "invalid_tls_certificate_notifications" {
  description = "Notification recipients list for every alerting rules of invalid_tls_certificate detector"
  type        = list
  default     = []
}

variable "invalid_tls_certificate_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of invalid_tls_certificate detector"
  type        = list
  default     = []
}

variable "invalid_tls_certificate_aggregation_function" {
  description = "Aggregation function and group by for invalid_tls_certificate detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['url'])"
}

variable "invalid_tls_certificate_transformation_function" {
  description = "Transformation function for invalid_tls_certificate detector (mean, min, max)"
  type        = string
  default     = "mean"
}

variable "invalid_tls_certificate_transformation_window" {
  description = "Transformation window for invalid_tls_certificate detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "15m"
}

variable "invalid_tls_certificate_threshold_critical" {
  description = "Critical threshold for invalid_tls_certificate detector"
  type        = number
  default     = 1
}
