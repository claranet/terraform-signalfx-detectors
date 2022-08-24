# latency detector

variable "latency_notifications" {
  description = "Notification recipients list per severity overridden for latency detector"
  type        = map(list(string))
  default     = {}
}

variable "latency_aggregation_function" {
  description = "Aggregation function and group by for latency detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "latency_transformation_function" {
  description = "Transformation function for latency detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "latency_max_delay" {
  description = "Enforce max delay for latency detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "latency_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "latency_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "latency_disabled" {
  description = "Disable all alerting rules for latency detector"
  type        = bool
  default     = null
}

variable "latency_disabled_critical" {
  description = "Disable critical alerting rule for latency detector"
  type        = bool
  default     = null
}

variable "latency_disabled_major" {
  description = "Disable major alerting rule for latency detector"
  type        = bool
  default     = null
}

variable "latency_threshold_critical" {
  description = "Critical threshold for latency detector in Millisecond"
  type        = number
  default     = 3000
}

variable "latency_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "10m"
}

variable "latency_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 0.9
}
variable "latency_threshold_major" {
  description = "Major threshold for latency detector in Millisecond"
  type        = number
  default     = 1000
}

variable "latency_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "10m"
}

variable "latency_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 0.9
}
# http_5xx detector

variable "http_5xx_notifications" {
  description = "Notification recipients list per severity overridden for http_5xx detector"
  type        = map(list(string))
  default     = {}
}

variable "http_5xx_aggregation_function" {
  description = "Aggregation function and group by for http_5xx detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "http_5xx_transformation_function" {
  description = "Transformation function for http_5xx detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "http_5xx_max_delay" {
  description = "Enforce max delay for http_5xx detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "http_5xx_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "http_5xx_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "http_5xx_disabled" {
  description = "Disable all alerting rules for http_5xx detector"
  type        = bool
  default     = null
}

variable "http_5xx_disabled_critical" {
  description = "Disable critical alerting rule for http_5xx detector"
  type        = bool
  default     = null
}

variable "http_5xx_disabled_major" {
  description = "Disable major alerting rule for http_5xx detector"
  type        = bool
  default     = null
}

variable "http_5xx_threshold_critical" {
  description = "Critical threshold for http_5xx detector in %"
  type        = number
  default     = 10
}

variable "http_5xx_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "5m"
}

variable "http_5xx_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 0.9
}
variable "http_5xx_threshold_major" {
  description = "Major threshold for http_5xx detector in %"
  type        = number
  default     = 5
}

variable "http_5xx_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "5m"
}

variable "http_5xx_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 0.9
}
# http_4xx detector

variable "http_4xx_notifications" {
  description = "Notification recipients list per severity overridden for http_4xx detector"
  type        = map(list(string))
  default     = {}
}

variable "http_4xx_aggregation_function" {
  description = "Aggregation function and group by for http_4xx detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "http_4xx_transformation_function" {
  description = "Transformation function for http_4xx detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "http_4xx_max_delay" {
  description = "Enforce max delay for http_4xx detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "http_4xx_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "http_4xx_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "http_4xx_disabled" {
  description = "Disable all alerting rules for http_4xx detector"
  type        = bool
  default     = null
}

variable "http_4xx_disabled_critical" {
  description = "Disable critical alerting rule for http_4xx detector"
  type        = bool
  default     = true
}

variable "http_4xx_disabled_major" {
  description = "Disable major alerting rule for http_4xx detector"
  type        = bool
  default     = null
}

variable "http_4xx_disabled_minor" {
  description = "Disable minor alerting rule for http_4xx detector"
  type        = bool
  default     = null
}

variable "http_4xx_threshold_critical" {
  description = "Critical threshold for http_4xx detector in %"
  type        = number
  default     = 99
}

variable "http_4xx_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "15m"
}

variable "http_4xx_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 0.9
}
variable "http_4xx_threshold_major" {
  description = "Major threshold for http_4xx detector in %"
  type        = number
  default     = 95
}

variable "http_4xx_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "15m"
}

variable "http_4xx_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 0.9
}
variable "http_4xx_threshold_minor" {
  description = "Minor threshold for http_4xx detector in %"
  type        = number
  default     = 90
}

variable "http_4xx_lasting_duration_minor" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "15m"
}

variable "http_4xx_at_least_percentage_minor" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 0.9
}
