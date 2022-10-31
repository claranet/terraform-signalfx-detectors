# cdn_total_latency detector

variable "cdn_total_latency_notifications" {
  description = "Notification recipients list per severity overridden for cdn_total_latency detector"
  type        = map(list(string))
  default     = {}
}

variable "cdn_total_latency_aggregation_function" {
  description = "Aggregation function and group by for cdn_total_latency detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "cdn_total_latency_transformation_function" {
  description = "Transformation function for cdn_total_latency detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "cdn_total_latency_max_delay" {
  description = "Enforce max delay for cdn_total_latency detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "cdn_total_latency_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "cdn_total_latency_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "cdn_total_latency_disabled" {
  description = "Disable all alerting rules for cdn_total_latency detector"
  type        = bool
  default     = null
}

variable "cdn_total_latency_disabled_critical" {
  description = "Disable critical alerting rule for cdn_total_latency detector"
  type        = bool
  default     = null
}

variable "cdn_total_latency_disabled_major" {
  description = "Disable major alerting rule for cdn_total_latency detector"
  type        = bool
  default     = null
}

variable "cdn_total_latency_threshold_critical" {
  description = "Critical threshold for cdn_total_latency detector"
  type        = number
  default     = 1500
}

variable "cdn_total_latency_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "15m"
}

variable "cdn_total_latency_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "cdn_total_latency_threshold_major" {
  description = "Major threshold for cdn_total_latency detector"
  type        = number
  default     = 3000
}

variable "cdn_total_latency_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "15m"
}

variable "cdn_total_latency_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
