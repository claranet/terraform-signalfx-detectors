# volume_space detector

variable "volume_space_notifications" {
  description = "Notification recipients list per severity overridden for volume_space detector"
  type        = map(list(string))
  default     = {}
}

variable "volume_space_aggregation_function" {
  description = "Aggregation function and group by for volume_space detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "volume_space_transformation_function" {
  description = "Transformation function for volume_space detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='5m')"
}

variable "volume_space_max_delay" {
  description = "Enforce max delay for volume_space detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "volume_space_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "volume_space_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "volume_space_disabled" {
  description = "Disable all alerting rules for volume_space detector"
  type        = bool
  default     = null
}

variable "volume_space_disabled_critical" {
  description = "Disable critical alerting rule for volume_space detector"
  type        = bool
  default     = null
}

variable "volume_space_disabled_major" {
  description = "Disable major alerting rule for volume_space detector"
  type        = bool
  default     = null
}

variable "volume_space_threshold_critical" {
  description = "Critical threshold for volume_space detector"
  type        = number
  default     = 95
}

variable "volume_space_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "volume_space_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "volume_space_threshold_major" {
  description = "Major threshold for volume_space detector"
  type        = number
  default     = 90
}

variable "volume_space_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "volume_space_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# volume_inodes detector

variable "volume_inodes_notifications" {
  description = "Notification recipients list per severity overridden for volume_inodes detector"
  type        = map(list(string))
  default     = {}
}

variable "volume_inodes_aggregation_function" {
  description = "Aggregation function and group by for volume_inodes detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "volume_inodes_transformation_function" {
  description = "Transformation function for volume_inodes detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='5m')"
}

variable "volume_inodes_max_delay" {
  description = "Enforce max delay for volume_inodes detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "volume_inodes_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "volume_inodes_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "volume_inodes_disabled" {
  description = "Disable all alerting rules for volume_inodes detector"
  type        = bool
  default     = null
}

variable "volume_inodes_disabled_critical" {
  description = "Disable critical alerting rule for volume_inodes detector"
  type        = bool
  default     = null
}

variable "volume_inodes_disabled_major" {
  description = "Disable major alerting rule for volume_inodes detector"
  type        = bool
  default     = null
}

variable "volume_inodes_threshold_critical" {
  description = "Critical threshold for volume_inodes detector"
  type        = number
  default     = 95
}

variable "volume_inodes_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "volume_inodes_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "volume_inodes_threshold_major" {
  description = "Major threshold for volume_inodes detector"
  type        = number
  default     = 90
}

variable "volume_inodes_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "volume_inodes_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
