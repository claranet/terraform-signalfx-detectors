# success_rate detector

variable "success_rate_notifications" {
  description = "Notification recipients list per severity overridden for success_rate detector"
  type        = map(list(string))
  default     = {}
}

variable "success_rate_aggregation_function" {
  description = "Aggregation function and group by for success_rate detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".sum(by=['ratelimitkey', 'azure_resource_name', 'azure_resource_group_name', 'azure_region'])"
}

variable "success_rate_transformation_function" {
  description = "Transformation function for success_rate detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "success_rate_max_delay" {
  description = "Enforce max delay for success_rate detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "success_rate_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "success_rate_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "success_rate_disabled" {
  description = "Disable all alerting rules for success_rate detector"
  type        = bool
  default     = null
}

variable "success_rate_threshold_major" {
  description = "Major threshold for success_rate detector"
  type        = number
  default     = 10
}

variable "success_rate_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "60m"
}

variable "success_rate_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
