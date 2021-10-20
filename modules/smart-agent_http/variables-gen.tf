# heartbeat detector

variable "heartbeat_notifications" {
  description = "Notification recipients list per severity overridden for heartbeat detector"
  type        = map(list(string))
  default     = {}
}

variable "heartbeat_aggregation_function" {
  description = "Aggregation function and group by for heartbeat detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "heartbeat_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "heartbeat_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "heartbeat_disabled" {
  description = "Disable all alerting rules for heartbeat detector"
  type        = bool
  default     = null
}

variable "heartbeat_timeframe" {
  description = "Timeframe for heartbeat detector (i.e. \"10m\")"
  type        = string
  default     = "10m"
}

# http_code_matched detector

variable "http_code_matched_notifications" {
  description = "Notification recipients list per severity overridden for http_code_matched detector"
  type        = map(list(string))
  default     = {}
}

variable "http_code_matched_aggregation_function" {
  description = "Aggregation function and group by for http_code_matched detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "http_code_matched_transformation_function" {
  description = "Transformation function for http_code_matched detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "http_code_matched_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "http_code_matched_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "http_code_matched_disabled" {
  description = "Disable all alerting rules for http_code_matched detector"
  type        = bool
  default     = null
}

variable "http_code_matched_threshold_critical" {
  description = "Critical threshold for http_code_matched detector"
  type        = number
  default     = 1
}

variable "http_code_matched_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "1m"
}

variable "http_code_matched_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# http_regex_matched detector

variable "http_regex_matched_notifications" {
  description = "Notification recipients list per severity overridden for http_regex_matched detector"
  type        = map(list(string))
  default     = {}
}

variable "http_regex_matched_aggregation_function" {
  description = "Aggregation function and group by for http_regex_matched detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "http_regex_matched_transformation_function" {
  description = "Transformation function for http_regex_matched detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "http_regex_matched_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "http_regex_matched_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "http_regex_matched_disabled" {
  description = "Disable all alerting rules for http_regex_matched detector"
  type        = bool
  default     = null
}

variable "http_regex_matched_threshold_critical" {
  description = "Critical threshold for http_regex_matched detector"
  type        = number
  default     = 1
}

variable "http_regex_matched_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "1m"
}

variable "http_regex_matched_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# http_response_time detector

variable "http_response_time_notifications" {
  description = "Notification recipients list per severity overridden for http_response_time detector"
  type        = map(list(string))
  default     = {}
}

variable "http_response_time_aggregation_function" {
  description = "Aggregation function and group by for http_response_time detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "http_response_time_transformation_function" {
  description = "Transformation function for http_response_time detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "http_response_time_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "http_response_time_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

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

variable "http_response_time_disabled_major" {
  description = "Disable major alerting rule for http_response_time detector"
  type        = bool
  default     = null
}

variable "http_response_time_threshold_critical" {
  description = "Critical threshold for http_response_time detector"
  type        = number
  default     = 2
}

variable "http_response_time_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "15m"
}

variable "http_response_time_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "http_response_time_threshold_major" {
  description = "Major threshold for http_response_time detector"
  type        = number
  default     = 1
}

variable "http_response_time_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "15m"
}

variable "http_response_time_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# http_content_length detector

variable "http_content_length_notifications" {
  description = "Notification recipients list per severity overridden for http_content_length detector"
  type        = map(list(string))
  default     = {}
}

variable "http_content_length_aggregation_function" {
  description = "Aggregation function and group by for http_content_length detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "http_content_length_transformation_function" {
  description = "Transformation function for http_content_length detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "http_content_length_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "http_content_length_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "http_content_length_disabled" {
  description = "Disable all alerting rules for http_content_length detector"
  type        = bool
  default     = true
}

variable "http_content_length_threshold_warning" {
  description = "Warning threshold for http_content_length detector in bytes"
  type        = number
  default     = 10
}

variable "http_content_length_lasting_duration_warning" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "10m"
}

variable "http_content_length_at_least_percentage_warning" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# certificate_expiration_date detector

variable "certificate_expiration_date_notifications" {
  description = "Notification recipients list per severity overridden for certificate_expiration_date detector"
  type        = map(list(string))
  default     = {}
}

variable "certificate_expiration_date_aggregation_function" {
  description = "Aggregation function and group by for certificate_expiration_date detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "certificate_expiration_date_transformation_function" {
  description = "Transformation function for certificate_expiration_date detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "certificate_expiration_date_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "certificate_expiration_date_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "certificate_expiration_date_disabled" {
  description = "Disable all alerting rules for certificate_expiration_date detector"
  type        = bool
  default     = null
}

variable "certificate_expiration_date_disabled_major" {
  description = "Disable major alerting rule for certificate_expiration_date detector"
  type        = bool
  default     = null
}

variable "certificate_expiration_date_disabled_minor" {
  description = "Disable minor alerting rule for certificate_expiration_date detector"
  type        = bool
  default     = null
}

variable "certificate_expiration_date_threshold_major" {
  description = "Major threshold for certificate_expiration_date detector in days"
  type        = number
  default     = 15
}

variable "certificate_expiration_date_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "certificate_expiration_date_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "certificate_expiration_date_threshold_minor" {
  description = "Minor threshold for certificate_expiration_date detector in days"
  type        = number
  default     = 30
}

variable "certificate_expiration_date_lasting_duration_minor" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "certificate_expiration_date_at_least_percentage_minor" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# invalid_tls_certificate detector

variable "invalid_tls_certificate_notifications" {
  description = "Notification recipients list per severity overridden for invalid_tls_certificate detector"
  type        = map(list(string))
  default     = {}
}

variable "invalid_tls_certificate_aggregation_function" {
  description = "Aggregation function and group by for invalid_tls_certificate detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "invalid_tls_certificate_transformation_function" {
  description = "Transformation function for invalid_tls_certificate detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "invalid_tls_certificate_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "invalid_tls_certificate_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "invalid_tls_certificate_disabled" {
  description = "Disable all alerting rules for invalid_tls_certificate detector"
  type        = bool
  default     = null
}

variable "invalid_tls_certificate_threshold_critical" {
  description = "Critical threshold for invalid_tls_certificate detector in days"
  type        = number
  default     = 1
}

variable "invalid_tls_certificate_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "1m"
}

variable "invalid_tls_certificate_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
