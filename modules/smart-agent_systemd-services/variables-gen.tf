# aliveness detector

variable "aliveness_notifications" {
  description = "Notification recipients list per severity overridden for aliveness detector"
  type        = map(list(string))
  default     = {}
}

variable "aliveness_aggregation_function" {
  description = "Aggregation function and group by for aliveness detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "aliveness_transformation_function" {
  description = "Transformation function for aliveness detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "aliveness_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "aliveness_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "aliveness_disabled" {
  description = "Disable all alerting rules for aliveness detector"
  type        = bool
  default     = null
}

variable "aliveness_threshold_critical" {
  description = "Critical threshold for aliveness detector"
  type        = number
  default     = 1
}

variable "aliveness_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "aliveness_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
