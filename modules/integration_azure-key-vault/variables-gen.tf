# api_result_rate detector

variable "api_result_rate_notifications" {
  description = "Notification recipients list per severity overridden for api_result_rate detector"
  type        = map(list(string))
  default     = {}
}

variable "api_result_rate_aggregation_function" {
  description = "Aggregation function and group by for api_result_rate detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".sum(by=['azure_resource_name', 'azure_resource_group_name', 'azure_region'])"
}

variable "api_result_rate_transformation_function" {
  description = "Transformation function for api_result_rate detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "api_result_rate_max_delay" {
  description = "Enforce max delay for api_result_rate detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "api_result_rate_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "api_result_rate_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "api_result_rate_disabled" {
  description = "Disable all alerting rules for api_result_rate detector"
  type        = bool
  default     = null
}

variable "api_result_rate_disabled_critical" {
  description = "Disable critical alerting rule for api_result_rate detector"
  type        = bool
  default     = null
}

variable "api_result_rate_disabled_major" {
  description = "Disable major alerting rule for api_result_rate detector"
  type        = bool
  default     = null
}

variable "api_result_rate_threshold_critical" {
  description = "Critical threshold for api_result_rate detector in %"
  type        = number
  default     = 10
}

variable "api_result_rate_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "5m"
}

variable "api_result_rate_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "api_result_rate_threshold_major" {
  description = "Major threshold for api_result_rate detector in %"
  type        = number
  default     = 30
}

variable "api_result_rate_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "5m"
}

variable "api_result_rate_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# api_latency detector

variable "api_latency_notifications" {
  description = "Notification recipients list per severity overridden for api_latency detector"
  type        = map(list(string))
  default     = {}
}

variable "api_latency_aggregation_function" {
  description = "Aggregation function and group by for api_latency detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['azure_resource_name', 'azure_resource_group_name', 'azure_region'])"
}

variable "api_latency_transformation_function" {
  description = "Transformation function for api_latency detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "api_latency_max_delay" {
  description = "Enforce max delay for api_latency detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "api_latency_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "api_latency_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "api_latency_disabled" {
  description = "Disable all alerting rules for api_latency detector"
  type        = bool
  default     = null
}

variable "api_latency_disabled_major" {
  description = "Disable major alerting rule for api_latency detector"
  type        = bool
  default     = null
}

variable "api_latency_disabled_minor" {
  description = "Disable minor alerting rule for api_latency detector"
  type        = bool
  default     = null
}

variable "api_latency_threshold_major" {
  description = "Major threshold for api_latency detector in ms"
  type        = number
  default     = 500
}

variable "api_latency_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "1h"
}

variable "api_latency_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "api_latency_threshold_minor" {
  description = "Minor threshold for api_latency detector in ms"
  type        = number
  default     = 500
}

variable "api_latency_lasting_duration_minor" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "30m"
}

variable "api_latency_at_least_percentage_minor" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
