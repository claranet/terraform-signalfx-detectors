# task_restart detector

variable "task_restart_notifications" {
  description = "Notification recipients list per severity overridden for task_restart detector"
  type        = map(list(string))
  default     = {}
}

variable "task_restart_aggregation_function" {
  description = "Aggregation function and group by for task_restart detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "task_restart_max_delay" {
  description = "Enforce max delay for task_restart detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "task_restart_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "task_restart_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "task_restart_disabled" {
  description = "Disable all alerting rules for task_restart detector"
  type        = bool
  default     = null
}

variable "task_restart_threshold_critical" {
  description = "Critical threshold for task_restart detector"
  type        = number
  default     = 1
}

variable "task_restart_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "5m"
}

variable "task_restart_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 0.9
}
