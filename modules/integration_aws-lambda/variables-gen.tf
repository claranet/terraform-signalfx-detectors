# pct_errors detector

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

variable "pct_errors_max_delay" {
  description = "Enforce max delay for pct_errors detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "pct_errors_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "pct_errors_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

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

variable "pct_errors_threshold_critical" {
  description = "Critical threshold for pct_errors detector in %"
  type        = number
  default     = 25
}

variable "pct_errors_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "15m"
}

variable "pct_errors_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "pct_errors_threshold_major" {
  description = "Major threshold for pct_errors detector in %"
  type        = number
  default     = 0
}

variable "pct_errors_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "15m"
}

variable "pct_errors_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# throttles detector

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

variable "throttles_max_delay" {
  description = "Enforce max delay for throttles detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "throttles_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "throttles_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

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

variable "throttles_threshold_critical" {
  description = "Critical threshold for throttles detector"
  type        = number
  default     = 1
}

variable "throttles_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "throttles_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "throttles_threshold_major" {
  description = "Major threshold for throttles detector"
  type        = number
  default     = 0
}

variable "throttles_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "throttles_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# invocations detector

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

variable "invocations_max_delay" {
  description = "Enforce max delay for invocations detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "invocations_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "invocations_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "invocations_disabled" {
  description = "Disable all alerting rules for invocations detector"
  type        = bool
  default     = true
}

variable "invocations_threshold_major" {
  description = "Major threshold for invocations detector"
  type        = number
  default     = 1
}

variable "invocations_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "invocations_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
