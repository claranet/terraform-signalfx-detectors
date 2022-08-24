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

# blocked_over_connected_clients_ratio detector

variable "blocked_over_connected_clients_ratio_notifications" {
  description = "Notification recipients list per severity overridden for blocked_over_connected_clients_ratio detector"
  type        = map(list(string))
  default     = {}
}

variable "blocked_over_connected_clients_ratio_aggregation_function" {
  description = "Aggregation function and group by for blocked_over_connected_clients_ratio detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "blocked_over_connected_clients_ratio_transformation_function" {
  description = "Transformation function for blocked_over_connected_clients_ratio detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "blocked_over_connected_clients_ratio_max_delay" {
  description = "Enforce max delay for blocked_over_connected_clients_ratio detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "blocked_over_connected_clients_ratio_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "blocked_over_connected_clients_ratio_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "blocked_over_connected_clients_ratio_disabled" {
  description = "Disable all alerting rules for blocked_over_connected_clients_ratio detector"
  type        = bool
  default     = null
}

variable "blocked_over_connected_clients_ratio_disabled_critical" {
  description = "Disable critical alerting rule for blocked_over_connected_clients_ratio detector"
  type        = bool
  default     = null
}

variable "blocked_over_connected_clients_ratio_disabled_major" {
  description = "Disable major alerting rule for blocked_over_connected_clients_ratio detector"
  type        = bool
  default     = null
}

variable "blocked_over_connected_clients_ratio_threshold_critical" {
  description = "Critical threshold for blocked_over_connected_clients_ratio detector in %"
  type        = number
  default     = 5
}

variable "blocked_over_connected_clients_ratio_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "1h"
}

variable "blocked_over_connected_clients_ratio_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 0.5
}
variable "blocked_over_connected_clients_ratio_threshold_major" {
  description = "Major threshold for blocked_over_connected_clients_ratio detector in %"
  type        = number
  default     = 0
}

variable "blocked_over_connected_clients_ratio_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "1h"
}

variable "blocked_over_connected_clients_ratio_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 0.5
}
# system_memory_usage_ratio detector

variable "system_memory_usage_ratio_notifications" {
  description = "Notification recipients list per severity overridden for system_memory_usage_ratio detector"
  type        = map(list(string))
  default     = {}
}

variable "system_memory_usage_ratio_aggregation_function" {
  description = "Aggregation function and group by for system_memory_usage_ratio detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "system_memory_usage_ratio_transformation_function" {
  description = "Transformation function for system_memory_usage_ratio detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='1h')"
}

variable "system_memory_usage_ratio_max_delay" {
  description = "Enforce max delay for system_memory_usage_ratio detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "system_memory_usage_ratio_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "system_memory_usage_ratio_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "system_memory_usage_ratio_disabled" {
  description = "Disable all alerting rules for system_memory_usage_ratio detector"
  type        = bool
  default     = null
}

variable "system_memory_usage_ratio_disabled_critical" {
  description = "Disable critical alerting rule for system_memory_usage_ratio detector"
  type        = bool
  default     = null
}

variable "system_memory_usage_ratio_disabled_major" {
  description = "Disable major alerting rule for system_memory_usage_ratio detector"
  type        = bool
  default     = null
}

variable "system_memory_usage_ratio_threshold_critical" {
  description = "Critical threshold for system_memory_usage_ratio detector in %"
  type        = number
  default     = 90
}

variable "system_memory_usage_ratio_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "system_memory_usage_ratio_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "system_memory_usage_ratio_threshold_major" {
  description = "Major threshold for system_memory_usage_ratio detector in %"
  type        = number
  default     = 80
}

variable "system_memory_usage_ratio_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "system_memory_usage_ratio_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# memory_usage_ratio detector

variable "memory_usage_ratio_notifications" {
  description = "Notification recipients list per severity overridden for memory_usage_ratio detector"
  type        = map(list(string))
  default     = {}
}

variable "memory_usage_ratio_aggregation_function" {
  description = "Aggregation function and group by for memory_usage_ratio detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "memory_usage_ratio_transformation_function" {
  description = "Transformation function for memory_usage_ratio detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='1h')"
}

variable "memory_usage_ratio_max_delay" {
  description = "Enforce max delay for memory_usage_ratio detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "memory_usage_ratio_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "memory_usage_ratio_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "memory_usage_ratio_disabled" {
  description = "Disable all alerting rules for memory_usage_ratio detector"
  type        = bool
  default     = null
}

variable "memory_usage_ratio_disabled_critical" {
  description = "Disable critical alerting rule for memory_usage_ratio detector"
  type        = bool
  default     = null
}

variable "memory_usage_ratio_disabled_major" {
  description = "Disable major alerting rule for memory_usage_ratio detector"
  type        = bool
  default     = null
}

variable "memory_usage_ratio_threshold_critical" {
  description = "Critical threshold for memory_usage_ratio detector in %"
  type        = number
  default     = 90
}

variable "memory_usage_ratio_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "memory_usage_ratio_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "memory_usage_ratio_threshold_major" {
  description = "Major threshold for memory_usage_ratio detector in %"
  type        = number
  default     = 80
}

variable "memory_usage_ratio_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "memory_usage_ratio_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
