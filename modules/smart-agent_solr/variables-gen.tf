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

# errors detector

variable "errors_notifications" {
  description = "Notification recipients list per severity overridden for errors detector"
  type        = map(list(string))
  default     = {}
}

variable "errors_aggregation_function" {
  description = "Aggregation function and group by for errors detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "errors_transformation_function" {
  description = "Transformation function for errors detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".mean(over='5m')"
}

variable "errors_max_delay" {
  description = "Enforce max delay for errors detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "errors_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "errors_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "errors_disabled" {
  description = "Disable all alerting rules for errors detector"
  type        = bool
  default     = null
}

variable "errors_disabled_critical" {
  description = "Disable critical alerting rule for errors detector"
  type        = bool
  default     = null
}

variable "errors_disabled_major" {
  description = "Disable major alerting rule for errors detector"
  type        = bool
  default     = null
}

variable "errors_threshold_critical" {
  description = "Critical threshold for errors detector"
  type        = number
  default     = 5
}

variable "errors_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "errors_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "errors_threshold_major" {
  description = "Major threshold for errors detector"
  type        = number
  default     = 0
}

variable "errors_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "errors_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# searcher_warmup_time detector

variable "searcher_warmup_time_notifications" {
  description = "Notification recipients list per severity overridden for searcher_warmup_time detector"
  type        = map(list(string))
  default     = {}
}

variable "searcher_warmup_time_aggregation_function" {
  description = "Aggregation function and group by for searcher_warmup_time detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "searcher_warmup_time_transformation_function" {
  description = "Transformation function for searcher_warmup_time detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".max(over='5m')"
}

variable "searcher_warmup_time_max_delay" {
  description = "Enforce max delay for searcher_warmup_time detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "searcher_warmup_time_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "searcher_warmup_time_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "searcher_warmup_time_disabled" {
  description = "Disable all alerting rules for searcher_warmup_time detector"
  type        = bool
  default     = null
}

variable "searcher_warmup_time_disabled_critical" {
  description = "Disable critical alerting rule for searcher_warmup_time detector"
  type        = bool
  default     = null
}

variable "searcher_warmup_time_disabled_major" {
  description = "Disable major alerting rule for searcher_warmup_time detector"
  type        = bool
  default     = null
}

variable "searcher_warmup_time_threshold_critical" {
  description = "Critical threshold for searcher_warmup_time detector"
  type        = number
  default     = 5000
}

variable "searcher_warmup_time_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "searcher_warmup_time_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "searcher_warmup_time_threshold_major" {
  description = "Major threshold for searcher_warmup_time detector"
  type        = number
  default     = 2000
}

variable "searcher_warmup_time_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "searcher_warmup_time_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
