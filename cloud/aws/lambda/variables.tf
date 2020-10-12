# Module specific

# Pct_errors detector

variable "pct_errors_disabled" {
  description = "Disable all alerting rules for pct_errors detector"
  type        = bool
  default     = null
}

variable "pct_errors_disabled_critical" {
  description = "Disable critical alerting rule for pct_errors detector"
  type        = bool
  default     = null
}

variable "pct_errors_disabled_major" {
  description = "Disable major alerting rule for pct_errors detector"
  type        = bool
  default     = null
}

variable "pct_errors_notifications" {
  description = "Notification recipients list per severity overridden for pct_errors detector"
  type        = map(list(string))
  default     = {}
}

variable "pct_errors_aggregation_function" {
  description = "Aggregation function and group by for pct_errors detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "pct_errors_transformation_function" {
  description = "Transformation function for pct_errors detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "pct_errors_lasting_duration_seconds" {
  description = "Minimum duration that conditions must be true before raising alert (in seconds)"
  type        = number
  default     = 900
}

variable "pct_errors_threshold_critical" {
  description = "Critical threshold for pct_errors detector"
  type        = number
  default     = 25
}

variable "pct_errors_threshold_major" {
  description = "Major threshold for pct_errors detector"
  type        = number
  default     = 0
}

# Throttles detector

variable "throttles_disabled" {
  description = "Disable all alerting rules for throttles detector"
  type        = bool
  default     = null
}

variable "throttles_disabled_critical" {
  description = "Disable critical alerting rule for throttles detector"
  type        = bool
  default     = null
}

variable "throttles_disabled_major" {
  description = "Disable major alerting rule for throttles detector"
  type        = bool
  default     = null
}

variable "throttles_notifications" {
  description = "Notification recipients list per severity overridden for throttles detector"
  type        = map(list(string))
  default     = {}
}

variable "throttles_aggregation_function" {
  description = "Aggregation function and group by for throttles detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "throttles_transformation_function" {
  description = "Transformation function for throttles detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".sum(over='1h')"
}

variable "throttles_threshold_critical" {
  description = "Critical threshold for throttles detector"
  type        = number
  default     = 1
}

variable "throttles_threshold_major" {
  description = "Major threshold for throttles detector"
  type        = number
  default     = 0
}

# invocations detector

variable "invocations_disabled" {
  description = "Disable all alerting rules for invocations detector"
  type        = bool
  default     = true
}

variable "invocations_notifications" {
  description = "Notification recipients list per severity overridden for invocations detector"
  type        = map(list(string))
  default     = {}
}

variable "invocations_aggregation_function" {
  description = "Aggregation function and group by for invocations detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "invocations_transformation_function" {
  description = "Transformation function for invocations detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".sum(over='1h')"
}

variable "invocations_threshold_major" {
  description = "Major threshold for invocations detector"
  type        = number
  default     = 1
}

