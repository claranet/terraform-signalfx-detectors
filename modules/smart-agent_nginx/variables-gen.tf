# heartbeat detector

variable "heartbeat_notifications" {
  description = "Notification recipients list per severity overridden for heartbeat detector"
  type        = map(list(string))
  default     = {}
}

variable "heartbeat_aggregation_function" {
  description = "Aggregation function and group by for heartbeat detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "heartbeat_transformation_function" {
  description = "Transformation function for heartbeat detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "heartbeat_max_delay" {
  description = "Enforce max delay for heartbeat detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = 900
}

variable "heartbeat_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "heartbeat_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "heartbeat_disabled" {
  description = "Disable all alerting rules for heartbeat detector"
  type        = bool
  default     = null
}

variable "heartbeat_timeframe" {
  description = "Timeframe for heartbeat detector (i.e. \"10m\")"
  type        = string
  default     = "10m"
}

# dropped_connections detector

variable "dropped_connections_notifications" {
  description = "Notification recipients list per severity overridden for dropped_connections detector"
  type        = map(list(string))
  default     = {}
}

variable "dropped_connections_aggregation_function" {
  description = "Aggregation function and group by for dropped_connections detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "dropped_connections_transformation_function" {
  description = "Transformation function for dropped_connections detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='5m')"
}

variable "dropped_connections_max_delay" {
  description = "Enforce max delay for dropped_connections detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "dropped_connections_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "dropped_connections_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "dropped_connections_disabled" {
  description = "Disable all alerting rules for dropped_connections detector"
  type        = bool
  default     = null
}

variable "dropped_connections_disabled_critical" {
  description = "Disable critical alerting rule for dropped_connections detector"
  type        = bool
  default     = null
}

variable "dropped_connections_disabled_major" {
  description = "Disable major alerting rule for dropped_connections detector"
  type        = bool
  default     = null
}

variable "dropped_connections_threshold_critical" {
  description = "Critical threshold for dropped_connections detector"
  type        = number
  default     = 1
}

variable "dropped_connections_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "dropped_connections_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "dropped_connections_threshold_major" {
  description = "Major threshold for dropped_connections detector"
  type        = number
  default     = 0
}

variable "dropped_connections_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "dropped_connections_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
