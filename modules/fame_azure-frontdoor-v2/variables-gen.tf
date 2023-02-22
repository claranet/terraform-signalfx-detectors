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

# http_errors detector

variable "http_errors_notifications" {
  description = "Notification recipients list per severity overridden for http_errors detector"
  type        = map(list(string))
  default     = {}
}

variable "http_errors_aggregation_function" {
  description = "Aggregation function and group by for http_errors detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "http_errors_transformation_function" {
  description = "Transformation function for http_errors detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "http_errors_max_delay" {
  description = "Enforce max delay for http_errors detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "http_errors_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "http_errors_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "http_errors_disabled" {
  description = "Disable all alerting rules for http_errors detector"
  type        = bool
  default     = null
}

variable "http_errors_disabled_critical" {
  description = "Disable critical alerting rule for http_errors detector"
  type        = bool
  default     = null
}

variable "http_errors_disabled_major" {
  description = "Disable major alerting rule for http_errors detector"
  type        = bool
  default     = null
}

variable "http_errors_threshold_critical" {
  description = "Critical threshold for http_errors detector"
  type        = number
  default     = 50
}

variable "http_errors_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "5m"
}

variable "http_errors_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "http_errors_threshold_major" {
  description = "Major threshold for http_errors detector"
  type        = number
  default     = 25
}

variable "http_errors_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "5m"
}

variable "http_errors_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# probes_errors detector

variable "probes_errors_notifications" {
  description = "Notification recipients list per severity overridden for probes_errors detector"
  type        = map(list(string))
  default     = {}
}

variable "probes_errors_aggregation_function" {
  description = "Aggregation function and group by for probes_errors detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "probes_errors_transformation_function" {
  description = "Transformation function for probes_errors detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "probes_errors_max_delay" {
  description = "Enforce max delay for probes_errors detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "probes_errors_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "probes_errors_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "probes_errors_disabled" {
  description = "Disable all alerting rules for probes_errors detector"
  type        = bool
  default     = null
}

variable "probes_errors_disabled_critical" {
  description = "Disable critical alerting rule for probes_errors detector"
  type        = bool
  default     = null
}

variable "probes_errors_disabled_major" {
  description = "Disable major alerting rule for probes_errors detector"
  type        = bool
  default     = null
}

variable "probes_errors_threshold_critical" {
  description = "Critical threshold for probes_errors detector"
  type        = number
  default     = 50
}

variable "probes_errors_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "5m"
}

variable "probes_errors_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "probes_errors_threshold_major" {
  description = "Major threshold for probes_errors detector"
  type        = number
  default     = 25
}

variable "probes_errors_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "5m"
}

variable "probes_errors_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# cache_hit_rate detector

variable "cache_hit_rate_notifications" {
  description = "Notification recipients list per severity overridden for cache_hit_rate detector"
  type        = map(list(string))
  default     = {}
}

variable "cache_hit_rate_aggregation_function" {
  description = "Aggregation function and group by for cache_hit_rate detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "cache_hit_rate_transformation_function" {
  description = "Transformation function for cache_hit_rate detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "cache_hit_rate_max_delay" {
  description = "Enforce max delay for cache_hit_rate detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "cache_hit_rate_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "cache_hit_rate_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "cache_hit_rate_disabled" {
  description = "Disable all alerting rules for cache_hit_rate detector"
  type        = bool
  default     = null
}

variable "cache_hit_rate_threshold_warning" {
  description = "Warning threshold for cache_hit_rate detector"
  type        = number
  default     = 60
}

variable "cache_hit_rate_lasting_duration_warning" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "5m"
}

variable "cache_hit_rate_at_least_percentage_warning" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
