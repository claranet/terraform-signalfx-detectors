# zookeeper-health detector

variable "zookeeper-health_notifications" {
  description = "Notification recipients list per severity overridden for zookeeper-health detector"
  type        = map(list(string))
  default     = {}
}

variable "zookeeper-health_aggregation_function" {
  description = "Aggregation function and group by for zookeeper-health detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "zookeeper-health_max_delay" {
  description = "Enforce max delay for zookeeper-health detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "zookeeper-health_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "zookeeper-health_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "zookeeper-health_disabled" {
  description = "Disable all alerting rules for zookeeper-health detector"
  type        = bool
  default     = null
}

variable "zookeeper-health_threshold_critical" {
  description = "Critical threshold for zookeeper-health detector"
  type        = number
  default     = 1
}

variable "zookeeper-health_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "15m"
}

variable "zookeeper-health_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
