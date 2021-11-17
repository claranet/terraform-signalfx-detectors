# deadlettered_messages detector

variable "deadlettered_messages_notifications" {
  description = "Notification recipients list per severity overridden for deadlettered_messages detector"
  type        = map(list(string))
  default     = {}
}

variable "deadlettered_messages_aggregation_function" {
  description = "Aggregation function and group by for deadlettered_messages detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['entityname', 'azure_resource_name', 'azure_resource_group_name', 'azure_region'])"
}

variable "deadlettered_messages_transformation_function" {
  description = "Transformation function for deadlettered_messages detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='5m')"
}

variable "deadlettered_messages_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "deadlettered_messages_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "deadlettered_messages_disabled" {
  description = "Disable all alerting rules for deadlettered_messages detector"
  type        = bool
  default     = null
}

variable "deadlettered_messages_disabled_critical" {
  description = "Disable critical alerting rule for deadlettered_messages detector"
  type        = bool
  default     = null
}

variable "deadlettered_messages_disabled_major" {
  description = "Disable major alerting rule for deadlettered_messages detector"
  type        = bool
  default     = null
}

variable "deadlettered_messages_threshold_critical" {
  description = "Critical threshold for deadlettered_messages detector"
  type        = number
  default     = 10
}

variable "deadlettered_messages_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "deadlettered_messages_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "deadlettered_messages_threshold_major" {
  description = "Major threshold for deadlettered_messages detector"
  type        = number
  default     = 5
}

variable "deadlettered_messages_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "deadlettered_messages_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
