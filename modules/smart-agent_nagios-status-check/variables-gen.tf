# status_check detector

variable "status_check_notifications" {
  description = "Notification recipients list per severity overridden for status_check detector"
  type        = map(list(string))
  default     = {}
}

variable "status_check_aggregation_function" {
  description = "Aggregation function and group by for status_check detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "status_check_transformation_function" {
  description = "Transformation function for status_check detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "status_check_max_delay" {
  description = "Enforce max delay for status_check detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "status_check_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "status_check_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "status_check_disabled" {
  description = "Disable all alerting rules for status_check detector"
  type        = bool
  default     = null
}

variable "status_check_disabled_warning" {
  description = "Disable warning alerting rule for status_check detector"
  type        = bool
  default     = null
}

variable "status_check_disabled_critical" {
  description = "Disable critical alerting rule for status_check detector"
  type        = bool
  default     = null
}

variable "status_check_disabled_major" {
  description = "Disable major alerting rule for status_check detector"
  type        = bool
  default     = null
}

variable "status_check_threshold_warning" {
  description = "Warning threshold for status_check detector"
  type        = number
  default     = 1
}

variable "status_check_lasting_duration_warning" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "15m"
}

variable "status_check_at_least_percentage_warning" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "status_check_threshold_critical" {
  description = "Critical threshold for status_check detector"
  type        = number
  default     = 2
}

variable "status_check_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "15m"
}

variable "status_check_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "status_check_threshold_major" {
  description = "Major threshold for status_check detector"
  type        = number
  default     = 3
}

variable "status_check_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "15m"
}

variable "status_check_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
