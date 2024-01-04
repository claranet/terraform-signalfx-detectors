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
  default     = "5m"
}

variable "zookeeper-health_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# zookeeper-latency detector

variable "zookeeper-latency_notifications" {
  description = "Notification recipients list per severity overridden for zookeeper-latency detector"
  type        = map(list(string))
  default     = {}
}

variable "zookeeper-latency_aggregation_function" {
  description = "Aggregation function and group by for zookeeper-latency detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "zookeeper-latency_max_delay" {
  description = "Enforce max delay for zookeeper-latency detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "zookeeper-latency_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "zookeeper-latency_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "zookeeper-latency_disabled" {
  description = "Disable all alerting rules for zookeeper-latency detector"
  type        = bool
  default     = null
}

variable "zookeeper-latency_disabled_critical" {
  description = "Disable critical alerting rule for zookeeper-latency detector"
  type        = bool
  default     = null
}

variable "zookeeper-latency_disabled_major" {
  description = "Disable major alerting rule for zookeeper-latency detector"
  type        = bool
  default     = null
}

variable "zookeeper-latency_threshold_critical" {
  description = "Critical threshold for zookeeper-latency detector"
  type        = number
  default     = 300000
}

variable "zookeeper-latency_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "5m"
}

variable "zookeeper-latency_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "zookeeper-latency_threshold_major" {
  description = "Major threshold for zookeeper-latency detector"
  type        = number
  default     = 250000
}

variable "zookeeper-latency_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "5m"
}

variable "zookeeper-latency_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
