# capacity_units detector

variable "capacity_units_notifications" {
  description = "Notification recipients list per severity overridden for capacity_units detector"
  type        = map(list(string))
  default     = {}
}

variable "capacity_units_aggregation_function" {
  description = "Aggregation function and group by for capacity_units detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['azure_resource_name', 'azure_resource_group_name', 'azure_region'])"
}

variable "capacity_units_transformation_function" {
  description = "Transformation function for capacity_units detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".max(over='15m')"
}

variable "capacity_units_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "capacity_units_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "capacity_units_disabled" {
  description = "Disable all alerting rules for capacity_units detector"
  type        = bool
  default     = null
}

variable "capacity_units_threshold_major" {
  description = "Major threshold for capacity_units detector"
  type        = number
}

variable "capacity_units_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "None"
}

variable "capacity_units_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1.0
}

