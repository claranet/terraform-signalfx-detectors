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

# average_processing_time detector

variable "average_processing_time_notifications" {
  description = "Notification recipients list per severity overridden for average_processing_time detector"
  type        = map(list(string))
  default     = {}
}

variable "average_processing_time_aggregation_function" {
  description = "Aggregation function and group by for average_processing_time detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "average_processing_time_transformation_function" {
  description = "Transformation function for average_processing_time detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='10m')"
}

variable "average_processing_time_max_delay" {
  description = "Enforce max delay for average_processing_time detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "average_processing_time_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "average_processing_time_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "average_processing_time_disabled" {
  description = "Disable all alerting rules for average_processing_time detector"
  type        = bool
  default     = null
}

variable "average_processing_time_disabled_critical" {
  description = "Disable critical alerting rule for average_processing_time detector"
  type        = bool
  default     = null
}

variable "average_processing_time_disabled_major" {
  description = "Disable major alerting rule for average_processing_time detector"
  type        = bool
  default     = null
}

variable "average_processing_time_threshold_critical" {
  description = "Critical threshold for average_processing_time detector"
  type        = number
  default     = 1500
}

variable "average_processing_time_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "average_processing_time_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "average_processing_time_threshold_major" {
  description = "Major threshold for average_processing_time detector"
  type        = number
  default     = 750
}

variable "average_processing_time_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "average_processing_time_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# busy_threads_percentage detector

variable "busy_threads_percentage_notifications" {
  description = "Notification recipients list per severity overridden for busy_threads_percentage detector"
  type        = map(list(string))
  default     = {}
}

variable "busy_threads_percentage_aggregation_function" {
  description = "Aggregation function and group by for busy_threads_percentage detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "busy_threads_percentage_transformation_function" {
  description = "Transformation function for busy_threads_percentage detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='5m')"
}

variable "busy_threads_percentage_max_delay" {
  description = "Enforce max delay for busy_threads_percentage detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "busy_threads_percentage_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "busy_threads_percentage_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "busy_threads_percentage_disabled" {
  description = "Disable all alerting rules for busy_threads_percentage detector"
  type        = bool
  default     = null
}

variable "busy_threads_percentage_disabled_critical" {
  description = "Disable critical alerting rule for busy_threads_percentage detector"
  type        = bool
  default     = null
}

variable "busy_threads_percentage_disabled_major" {
  description = "Disable major alerting rule for busy_threads_percentage detector"
  type        = bool
  default     = null
}

variable "busy_threads_percentage_threshold_critical" {
  description = "Critical threshold for busy_threads_percentage detector"
  type        = number
  default     = 95
}

variable "busy_threads_percentage_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "busy_threads_percentage_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "busy_threads_percentage_threshold_major" {
  description = "Major threshold for busy_threads_percentage detector"
  type        = number
  default     = 80
}

variable "busy_threads_percentage_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "busy_threads_percentage_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
