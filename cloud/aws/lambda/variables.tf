# Global

variable "environment" {
  description = "Infrastructure environment"
  type        = string
}

# SignalFx module specific

variable "notifications" {
  description = "Default notification recipients list per severity"
  type = object({
    critical = list(string)
    major    = list(string)
    minor    = list(string)
    warning  = list(string)
    info     = list(string)
  })
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

# AWS Lambda detectors specific

# Pct_errors detectors

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

variable "pct_errors_disabled_warning" {
  description = "Disable warning alerting rule for pct_errors detector"
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
  description = "Transformation function for pct_errors detector (i.e. \".mean(over='5m')\"))"
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

variable "pct_errors_threshold_warning" {
  description = "Warning threshold for pct_errors detector"
  type        = number
  default     = 0
}

# Throttles detectors

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

variable "throttles_disabled_warning" {
  description = "Disable warning alerting rule for throttles detector"
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
  description = "Transformation function for throttles detector (i.e. \".mean(over='5m')\"))"
  type        = string
  default     = ".sum(over='1h')"
}

variable "throttles_threshold_critical" {
  description = "Critical threshold for throttles detector"
  type        = number
  default     = 1
}

variable "throttles_threshold_warning" {
  description = "Warning threshold for throttles detector"
  type        = number
  default     = 0
}

# invocations detectors

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
  description = "Transformation function for invocations detector (i.e. \".mean(over='5m')\"))"
  type        = string
  default     = ".sum(over='1h')"
}

variable "invocations_threshold_warning" {
  description = "Warning threshold for invocations detector"
  type        = number
  default     = 1
}

