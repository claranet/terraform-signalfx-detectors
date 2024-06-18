# heartbeat detector

variable "heartbeat_notifications" {
  description = "Notification recipients list per severity overridden for heartbeat detector"
  type        = map(list(string))
  default     = {}
}

variable "heartbeat_aggregation_function" {
  description = "Aggregation function and group by for heartbeat detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['QueueName'])"
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

# visible_messages detector

variable "visible_messages_notifications" {
  description = "Notification recipients list per severity overridden for visible_messages detector"
  type        = map(list(string))
  default     = {}
}

variable "visible_messages_aggregation_function" {
  description = "Aggregation function and group by for visible_messages detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "visible_messages_transformation_function" {
  description = "Transformation function for visible_messages detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='30m')"
}

variable "visible_messages_max_delay" {
  description = "Enforce max delay for visible_messages detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "visible_messages_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "visible_messages_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "visible_messages_disabled" {
  description = "Disable all alerting rules for visible_messages detector"
  type        = bool
  default     = null
}

variable "visible_messages_disabled_critical" {
  description = "Disable critical alerting rule for visible_messages detector"
  type        = bool
  default     = null
}

variable "visible_messages_disabled_major" {
  description = "Disable major alerting rule for visible_messages detector"
  type        = bool
  default     = null
}

variable "visible_messages_threshold_critical" {
  description = "Critical threshold for visible_messages detector"
  type        = number
  default     = 2
}

variable "visible_messages_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "visible_messages_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "visible_messages_threshold_major" {
  description = "Major threshold for visible_messages detector"
  type        = number
  default     = 1
}

variable "visible_messages_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "visible_messages_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# age_of_oldest_message detector

variable "age_of_oldest_message_notifications" {
  description = "Notification recipients list per severity overridden for age_of_oldest_message detector"
  type        = map(list(string))
  default     = {}
}

variable "age_of_oldest_message_aggregation_function" {
  description = "Aggregation function and group by for age_of_oldest_message detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "age_of_oldest_message_transformation_function" {
  description = "Transformation function for age_of_oldest_message detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='30m')"
}

variable "age_of_oldest_message_max_delay" {
  description = "Enforce max delay for age_of_oldest_message detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "age_of_oldest_message_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "age_of_oldest_message_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "age_of_oldest_message_disabled" {
  description = "Disable all alerting rules for age_of_oldest_message detector"
  type        = bool
  default     = null
}

variable "age_of_oldest_message_disabled_critical" {
  description = "Disable critical alerting rule for age_of_oldest_message detector"
  type        = bool
  default     = null
}

variable "age_of_oldest_message_disabled_major" {
  description = "Disable major alerting rule for age_of_oldest_message detector"
  type        = bool
  default     = null
}

variable "age_of_oldest_message_threshold_critical" {
  description = "Critical threshold for age_of_oldest_message detector"
  type        = number
  default     = 600
}

variable "age_of_oldest_message_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "age_of_oldest_message_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "age_of_oldest_message_threshold_major" {
  description = "Major threshold for age_of_oldest_message detector"
  type        = number
  default     = 300
}

variable "age_of_oldest_message_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "age_of_oldest_message_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
