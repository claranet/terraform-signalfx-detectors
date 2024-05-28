# pending detector

variable "pending_notifications" {
  description = "Notification recipients list per severity overridden for pending detector"
  type        = map(list(string))
  default     = {}
}

variable "pending_aggregation_function" {
  description = "Aggregation function and group by for pending detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "pending_max_delay" {
  description = "Enforce max delay for pending detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "pending_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "pending_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "pending_disabled" {
  description = "Disable all alerting rules for pending detector"
  type        = bool
  default     = null
}

variable "pending_disabled_minor" {
  description = "Disable minor alerting rule for pending detector"
  type        = bool
  default     = null
}

variable "pending_disabled_warning" {
  description = "Disable warning alerting rule for pending detector"
  type        = bool
  default     = null
}

variable "pending_threshold_minor" {
  description = "Minor threshold for pending detector"
  type        = number
  default     = 10
}

variable "pending_lasting_duration_minor" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "5m"
}

variable "pending_at_least_percentage_minor" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "pending_threshold_warning" {
  description = "Warning threshold for pending detector"
  type        = number
  default     = 20
}

variable "pending_lasting_duration_warning" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "5m"
}

variable "pending_at_least_percentage_warning" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
