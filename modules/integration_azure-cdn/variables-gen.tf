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
  default     = ".min(over='15m')"
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
  description = "Critical threshold for latency detector"
  type        = number
  default     = 2000
}

variable "latency_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "latency_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "latency_threshold_major" {
  description = "Major threshold for latency detector"
  type        = number
  default     = 4000
}

variable "latency_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "latency_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
