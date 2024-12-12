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

# firebase_database_load detector

variable "firebase_database_load_notifications" {
  description = "Notification recipients list per severity overridden for firebase_database_load detector"
  type        = map(list(string))
  default     = {}
}

variable "firebase_database_load_aggregation_function" {
  description = "Aggregation function and group by for firebase_database_load detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "firebase_database_load_transformation_function" {
  description = "Transformation function for firebase_database_load detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='30m')"
}

variable "firebase_database_load_max_delay" {
  description = "Enforce max delay for firebase_database_load detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "firebase_database_load_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "firebase_database_load_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "firebase_database_load_disabled" {
  description = "Disable all alerting rules for firebase_database_load detector"
  type        = bool
  default     = null
}

variable "firebase_database_load_disabled_critical" {
  description = "Disable critical alerting rule for firebase_database_load detector"
  type        = bool
  default     = null
}

variable "firebase_database_load_disabled_major" {
  description = "Disable major alerting rule for firebase_database_load detector"
  type        = bool
  default     = null
}

variable "firebase_database_load_threshold_critical" {
  description = "Critical threshold for firebase_database_load detector"
  type        = number
  default     = 10
}

variable "firebase_database_load_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "firebase_database_load_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "firebase_database_load_threshold_major" {
  description = "Major threshold for firebase_database_load detector"
  type        = number
  default     = 5
}

variable "firebase_database_load_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "firebase_database_load_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# firebase_database_io_utilization detector

variable "firebase_database_io_utilization_notifications" {
  description = "Notification recipients list per severity overridden for firebase_database_io_utilization detector"
  type        = map(list(string))
  default     = {}
}

variable "firebase_database_io_utilization_aggregation_function" {
  description = "Aggregation function and group by for firebase_database_io_utilization detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "firebase_database_io_utilization_transformation_function" {
  description = "Transformation function for firebase_database_io_utilization detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='30m')"
}

variable "firebase_database_io_utilization_max_delay" {
  description = "Enforce max delay for firebase_database_io_utilization detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "firebase_database_io_utilization_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "firebase_database_io_utilization_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "firebase_database_io_utilization_disabled" {
  description = "Disable all alerting rules for firebase_database_io_utilization detector"
  type        = bool
  default     = null
}

variable "firebase_database_io_utilization_disabled_critical" {
  description = "Disable critical alerting rule for firebase_database_io_utilization detector"
  type        = bool
  default     = null
}

variable "firebase_database_io_utilization_disabled_major" {
  description = "Disable major alerting rule for firebase_database_io_utilization detector"
  type        = bool
  default     = null
}

variable "firebase_database_io_utilization_threshold_critical" {
  description = "Critical threshold for firebase_database_io_utilization detector"
  type        = number
  default     = 10
}

variable "firebase_database_io_utilization_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "firebase_database_io_utilization_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "firebase_database_io_utilization_threshold_major" {
  description = "Major threshold for firebase_database_io_utilization detector"
  type        = number
  default     = 5
}

variable "firebase_database_io_utilization_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "firebase_database_io_utilization_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
