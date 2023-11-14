# latency detector

variable "latency_notifications" {
  description = "Notification recipients list per severity overridden for latency detector"
  type        = map(list(string))
  default     = {}
}

variable "latency_aggregation_function" {
  description = "Aggregation function and group by for latency detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['azure_resource_name', 'azure_resource_group_name', 'azure_region'])"
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
  description = "Critical threshold for latency detector in ms"
  type        = number
  default     = 4
}

variable "latency_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "5m"
}

variable "latency_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "latency_threshold_major" {
  description = "Major threshold for latency detector in ms"
  type        = number
  default     = 2
}

variable "latency_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "5m"
}

variable "latency_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# throttled_queries_rate detector

variable "throttled_queries_rate_notifications" {
  description = "Notification recipients list per severity overridden for throttled_queries_rate detector"
  type        = map(list(string))
  default     = {}
}

variable "throttled_queries_rate_aggregation_function" {
  description = "Aggregation function and group by for throttled_queries_rate detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['azure_resource_name', 'azure_resource_group_name', 'azure_region'])"
}

variable "throttled_queries_rate_transformation_function" {
  description = "Transformation function for throttled_queries_rate detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "throttled_queries_rate_max_delay" {
  description = "Enforce max delay for throttled_queries_rate detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "throttled_queries_rate_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "throttled_queries_rate_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "throttled_queries_rate_disabled" {
  description = "Disable all alerting rules for throttled_queries_rate detector"
  type        = bool
  default     = null
}

variable "throttled_queries_rate_disabled_critical" {
  description = "Disable critical alerting rule for throttled_queries_rate detector"
  type        = bool
  default     = null
}

variable "throttled_queries_rate_disabled_major" {
  description = "Disable major alerting rule for throttled_queries_rate detector"
  type        = bool
  default     = null
}

variable "throttled_queries_rate_threshold_critical" {
  description = "Critical threshold for throttled_queries_rate detector in %"
  type        = number
  default     = 50
}

variable "throttled_queries_rate_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "5m"
}

variable "throttled_queries_rate_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "throttled_queries_rate_threshold_major" {
  description = "Major threshold for throttled_queries_rate detector in %"
  type        = number
  default     = 20
}

variable "throttled_queries_rate_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "5m"
}

variable "throttled_queries_rate_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
