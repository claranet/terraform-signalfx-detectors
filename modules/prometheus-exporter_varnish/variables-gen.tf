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

variable "heartbeat_exclude_not_running_vm" {
  description = "Don’t send alerts if associated VM is stopped or stopping (metadata provided by cloud provider integration). Can be useful for ephemeral infrastructure (such as auto scaling groups) as VM will be stopped and started regularly. Note that timeframe must be at least 25 minutes for the metadata to be available to the detector."
  type        = bool
  default     = true
}

variable "heartbeat_timeframe" {
  description = "Timeframe for heartbeat detector (i.e. \"25m\"). Must be at least \"25m\" if exclude_not_running_vm is true"
  type        = string
  default     = "25m"
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
# dropped_sessions detector

variable "dropped_sessions_notifications" {
  description = "Notification recipients list per severity overridden for dropped_sessions detector"
  type        = map(list(string))
  default     = {}
}

variable "dropped_sessions_aggregation_function" {
  description = "Aggregation function and group by for dropped_sessions detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "dropped_sessions_transformation_function" {
  description = "Transformation function for dropped_sessions detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='5m')"
}

variable "dropped_sessions_max_delay" {
  description = "Enforce max delay for dropped_sessions detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "dropped_sessions_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "dropped_sessions_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "dropped_sessions_disabled" {
  description = "Disable all alerting rules for dropped_sessions detector"
  type        = bool
  default     = null
}

variable "dropped_sessions_threshold_critical" {
  description = "Critical threshold for dropped_sessions detector"
  type        = number
  default     = 0
}

variable "dropped_sessions_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "dropped_sessions_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# hit_rate detector

variable "hit_rate_notifications" {
  description = "Notification recipients list per severity overridden for hit_rate detector"
  type        = map(list(string))
  default     = {}
}

variable "hit_rate_aggregation_function" {
  description = "Aggregation function and group by for hit_rate detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "hit_rate_transformation_function" {
  description = "Transformation function for hit_rate detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='5m')"
}

variable "hit_rate_max_delay" {
  description = "Enforce max delay for hit_rate detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "hit_rate_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "hit_rate_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "hit_rate_disabled" {
  description = "Disable all alerting rules for hit_rate detector"
  type        = bool
  default     = null
}

variable "hit_rate_disabled_minor" {
  description = "Disable minor alerting rule for hit_rate detector"
  type        = bool
  default     = null
}

variable "hit_rate_disabled_major" {
  description = "Disable major alerting rule for hit_rate detector"
  type        = bool
  default     = null
}

variable "hit_rate_threshold_minor" {
  description = "Minor threshold for hit_rate detector"
  type        = number
  default     = 90
}

variable "hit_rate_lasting_duration_minor" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "5m"
}

variable "hit_rate_at_least_percentage_minor" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "hit_rate_threshold_major" {
  description = "Major threshold for hit_rate detector"
  type        = number
  default     = 80
}

variable "hit_rate_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "5m"
}

variable "hit_rate_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# memory_usage detector

variable "memory_usage_notifications" {
  description = "Notification recipients list per severity overridden for memory_usage detector"
  type        = map(list(string))
  default     = {}
}

variable "memory_usage_aggregation_function" {
  description = "Aggregation function and group by for memory_usage detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "memory_usage_transformation_function" {
  description = "Transformation function for memory_usage detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='5m')"
}

variable "memory_usage_max_delay" {
  description = "Enforce max delay for memory_usage detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "memory_usage_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "memory_usage_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "memory_usage_disabled" {
  description = "Disable all alerting rules for memory_usage detector"
  type        = bool
  default     = null
}

variable "memory_usage_disabled_critical" {
  description = "Disable critical alerting rule for memory_usage detector"
  type        = bool
  default     = null
}

variable "memory_usage_disabled_major" {
  description = "Disable major alerting rule for memory_usage detector"
  type        = bool
  default     = null
}

variable "memory_usage_threshold_critical" {
  description = "Critical threshold for memory_usage detector"
  type        = number
  default     = 90
}

variable "memory_usage_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "5m"
}

variable "memory_usage_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "memory_usage_threshold_major" {
  description = "Major threshold for memory_usage detector"
  type        = number
  default     = 80
}

variable "memory_usage_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "5m"
}

variable "memory_usage_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
