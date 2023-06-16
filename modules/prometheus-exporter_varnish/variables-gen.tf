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

# backend_failed detector

variable "backend_failed_notifications" {
  description = "Notification recipients list per severity overridden for backend_failed detector"
  type        = map(list(string))
  default     = {}
}

variable "backend_failed_aggregation_function" {
  description = "Aggregation function and group by for backend_failed detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "backend_failed_transformation_function" {
  description = "Transformation function for backend_failed detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='5m')"
}

variable "backend_failed_max_delay" {
  description = "Enforce max delay for backend_failed detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "backend_failed_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "backend_failed_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "backend_failed_disabled" {
  description = "Disable all alerting rules for backend_failed detector"
  type        = bool
  default     = null
}

variable "backend_failed_threshold_critical" {
  description = "Critical threshold for backend_failed detector"
  type        = number
  default     = 0
}

variable "backend_failed_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "backend_failed_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# thread_number detector

variable "thread_number_notifications" {
  description = "Notification recipients list per severity overridden for thread_number detector"
  type        = map(list(string))
  default     = {}
}

variable "thread_number_aggregation_function" {
  description = "Aggregation function and group by for thread_number detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "thread_number_transformation_function" {
  description = "Transformation function for thread_number detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='5m')"
}

variable "thread_number_max_delay" {
  description = "Enforce max delay for thread_number detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "thread_number_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "thread_number_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "thread_number_disabled" {
  description = "Disable all alerting rules for thread_number detector"
  type        = bool
  default     = null
}

variable "thread_number_threshold_critical" {
  description = "Critical threshold for thread_number detector"
  type        = number
  default     = 1
}

variable "thread_number_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "thread_number_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
