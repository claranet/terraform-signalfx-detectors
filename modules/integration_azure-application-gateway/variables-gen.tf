# compute_units detector

variable "compute_units_notifications" {
  description = "Notification recipients list per severity overridden for compute_units detector"
  type        = map(list(string))
  default     = {}
}

variable "compute_units_aggregation_function" {
  description = "Aggregation function and group by for compute_units detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['azure_resource_name', 'azure_resource_group_name', 'azure_region'])"
}

variable "compute_units_transformation_function" {
  description = "Transformation function for compute_units detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".max(over='15m')"
}

variable "compute_units_max_delay" {
  description = "Enforce max delay for compute_units detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "compute_units_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "compute_units_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "compute_units_disabled" {
  description = "Disable all alerting rules for compute_units detector"
  type        = bool
  default     = null
}

variable "compute_units_threshold_major" {
  description = "Major threshold for compute_units detector"
  type        = number
}

variable "compute_units_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "compute_units_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
