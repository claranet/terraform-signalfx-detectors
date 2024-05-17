# heartbeat detector

variable "heartbeat_notifications" {
  description = "Notification recipients list per severity overridden for heartbeat detector"
  type        = map(list(string))
  default     = {}
}

variable "heartbeat_aggregation_function" {
  description = "Aggregation function and group by for heartbeat detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['StreamName'])"
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
  description = "Timeframe for heartbeat detector (i.e. \"25m\"). Must be at least \"25m\" if exclude_not_running_vm is true"
  type        = string
  default     = "25m"
}

# incoming_records detector

variable "incoming_records_notifications" {
  description = "Notification recipients list per severity overridden for incoming_records detector"
  type        = map(list(string))
  default     = {}
}

variable "incoming_records_aggregation_function" {
  description = "Aggregation function and group by for incoming_records detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "incoming_records_transformation_function" {
  description = "Transformation function for incoming_records detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".sum(over='15m')"
}

variable "incoming_records_max_delay" {
  description = "Enforce max delay for incoming_records detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "incoming_records_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "incoming_records_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "incoming_records_disabled" {
  description = "Disable all alerting rules for incoming_records detector"
  type        = bool
  default     = null
}

variable "incoming_records_disabled_critical" {
  description = "Disable critical alerting rule for incoming_records detector"
  type        = bool
  default     = null
}

variable "incoming_records_disabled_major" {
  description = "Disable major alerting rule for incoming_records detector"
  type        = bool
  default     = null
}

variable "incoming_records_threshold_critical" {
  description = "Critical threshold for incoming_records detector"
  type        = number
  default     = 0
}

variable "incoming_records_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "incoming_records_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "incoming_records_threshold_major" {
  description = "Major threshold for incoming_records detector"
  type        = number
  default     = 1
}

variable "incoming_records_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "incoming_records_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
