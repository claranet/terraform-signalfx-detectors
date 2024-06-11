# heartbeat detector

variable "heartbeat_notifications" {
  description = "Notification recipients list per severity overridden for heartbeat detector"
  type        = map(list(string))
  default     = {}
}

variable "heartbeat_aggregation_function" {
  description = "Aggregation function and group by for heartbeat detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['subscription_id'])"
}

variable "heartbeat_transformation_function" {
  description = "Transformation function for heartbeat detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "heartbeat_max_delay" {
  description = "Enforce max delay for heartbeat detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
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
  description = "Timeframe for heartbeat detector (i.e. \"25m\")."
  type        = string
  default     = "25m"
}

# oldest_unacked_message detector

variable "oldest_unacked_message_notifications" {
  description = "Notification recipients list per severity overridden for oldest_unacked_message detector"
  type        = map(list(string))
  default     = {}
}

variable "oldest_unacked_message_aggregation_function" {
  description = "Aggregation function and group by for oldest_unacked_message detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "oldest_unacked_message_transformation_function" {
  description = "Transformation function for oldest_unacked_message detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='5m')"
}

variable "oldest_unacked_message_max_delay" {
  description = "Enforce max delay for oldest_unacked_message detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "oldest_unacked_message_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "oldest_unacked_message_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "oldest_unacked_message_disabled" {
  description = "Disable all alerting rules for oldest_unacked_message detector"
  type        = bool
  default     = null
}

variable "oldest_unacked_message_disabled_critical" {
  description = "Disable critical alerting rule for oldest_unacked_message detector"
  type        = bool
  default     = null
}

variable "oldest_unacked_message_disabled_major" {
  description = "Disable major alerting rule for oldest_unacked_message detector"
  type        = bool
  default     = null
}

variable "oldest_unacked_message_threshold_critical" {
  description = "Critical threshold for oldest_unacked_message detector"
  type        = number
  default     = 120
}

variable "oldest_unacked_message_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "oldest_unacked_message_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "oldest_unacked_message_threshold_major" {
  description = "Major threshold for oldest_unacked_message detector"
  type        = number
  default     = 30
}

variable "oldest_unacked_message_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "oldest_unacked_message_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# push_latency detector

variable "push_latency_notifications" {
  description = "Notification recipients list per severity overridden for push_latency detector"
  type        = map(list(string))
  default     = {}
}

variable "push_latency_aggregation_function" {
  description = "Aggregation function and group by for push_latency detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "push_latency_transformation_function" {
  description = "Transformation function for push_latency detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='15m')"
}

variable "push_latency_max_delay" {
  description = "Enforce max delay for push_latency detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "push_latency_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "push_latency_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "push_latency_disabled" {
  description = "Disable all alerting rules for push_latency detector"
  type        = bool
  default     = null
}

variable "push_latency_disabled_critical" {
  description = "Disable critical alerting rule for push_latency detector"
  type        = bool
  default     = null
}

variable "push_latency_disabled_major" {
  description = "Disable major alerting rule for push_latency detector"
  type        = bool
  default     = null
}

variable "push_latency_threshold_critical" {
  description = "Critical threshold for push_latency detector"
  type        = number
  default     = 5000000
}

variable "push_latency_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "push_latency_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "push_latency_threshold_major" {
  description = "Major threshold for push_latency detector"
  type        = number
  default     = 1000000
}

variable "push_latency_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "push_latency_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
