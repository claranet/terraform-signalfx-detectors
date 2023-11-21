# used_capacity detector

variable "used_capacity_notifications" {
  description = "Notification recipients list per severity overridden for used_capacity detector"
  type        = map(list(string))
  default     = {}
}

variable "used_capacity_aggregation_function" {
  description = "Aggregation function and group by for used_capacity detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['azure_resource_name', 'azure_resource_group_name', 'azure_region'])"
}

variable "used_capacity_transformation_function" {
  description = "Transformation function for used_capacity detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".max(over='12h')"
}

variable "used_capacity_max_delay" {
  description = "Enforce max delay for used_capacity detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "used_capacity_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "used_capacity_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "used_capacity_disabled" {
  description = "Disable all alerting rules for used_capacity detector"
  type        = bool
  default     = null
}

variable "used_capacity_disabled_critical" {
  description = "Disable critical alerting rule for used_capacity detector"
  type        = bool
  default     = null
}

variable "used_capacity_disabled_major" {
  description = "Disable major alerting rule for used_capacity detector"
  type        = bool
  default     = null
}

variable "used_capacity_threshold_critical" {
  description = "Critical threshold for used_capacity detector in Gibibyte"
  type        = number
}

variable "used_capacity_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "used_capacity_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "used_capacity_threshold_major" {
  description = "Major threshold for used_capacity detector in Gibibyte"
  type        = number
}

variable "used_capacity_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "used_capacity_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
