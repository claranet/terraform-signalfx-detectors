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

variable "heartbeat_transformation_function" {
  description = "Transformation function for heartbeat detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "heartbeat_max_delay" {
  description = "Enforce max delay for heartbeat detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = 900
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

# error_rate detector

variable "error_rate_notifications" {
  description = "Notification recipients list per severity overridden for error_rate detector"
  type        = map(list(string))
  default     = {}
}

variable "error_rate_aggregation_function" {
  description = "Aggregation function and group by for error_rate detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "error_rate_transformation_function" {
  description = "Transformation function for error_rate detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='5m')"
}

variable "error_rate_max_delay" {
  description = "Enforce max delay for error_rate detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "error_rate_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "error_rate_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "error_rate_disabled" {
  description = "Disable all alerting rules for error_rate detector"
  type        = bool
  default     = null
}

variable "error_rate_disabled_critical" {
  description = "Disable critical alerting rule for error_rate detector"
  type        = bool
  default     = null
}

variable "error_rate_disabled_major" {
  description = "Disable major alerting rule for error_rate detector"
  type        = bool
  default     = null
}

variable "error_rate_threshold_critical" {
  description = "Critical threshold for error_rate detector"
  type        = number
  default     = 5
}

variable "error_rate_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "error_rate_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "error_rate_threshold_major" {
  description = "Major threshold for error_rate detector"
  type        = number
  default     = 1
}

variable "error_rate_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "error_rate_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# apdex detector

variable "apdex_notifications" {
  description = "Notification recipients list per severity overridden for apdex detector"
  type        = map(list(string))
  default     = {}
}

variable "apdex_aggregation_function" {
  description = "Aggregation function and group by for apdex detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "apdex_transformation_function" {
  description = "Transformation function for apdex detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".mean(over='15m')"
}

variable "apdex_max_delay" {
  description = "Enforce max delay for apdex detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "apdex_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "apdex_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "apdex_disabled" {
  description = "Disable all alerting rules for apdex detector"
  type        = bool
  default     = null
}

variable "apdex_disabled_critical" {
  description = "Disable critical alerting rule for apdex detector"
  type        = bool
  default     = null
}

variable "apdex_disabled_major" {
  description = "Disable major alerting rule for apdex detector"
  type        = bool
  default     = null
}

variable "apdex_threshold_critical" {
  description = "Critical threshold for apdex detector"
  type        = number
  default     = 0.25
}

variable "apdex_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "apdex_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "apdex_threshold_major" {
  description = "Major threshold for apdex detector"
  type        = number
  default     = 0.5
}

variable "apdex_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "apdex_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
