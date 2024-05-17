# heartbeat detector

variable "heartbeat_notifications" {
  description = "Notification recipients list per severity overridden for heartbeat detector"
  type        = map(list(string))
  default     = {}
}

variable "heartbeat_aggregation_function" {
  description = "Aggregation function and group by for heartbeat detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['CacheClusterId'])"
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

# evictions detector

variable "evictions_notifications" {
  description = "Notification recipients list per severity overridden for evictions detector"
  type        = map(list(string))
  default     = {}
}

variable "evictions_aggregation_function" {
  description = "Aggregation function and group by for evictions detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "evictions_transformation_function" {
  description = "Transformation function for evictions detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".sum(over='15m')"
}

variable "evictions_max_delay" {
  description = "Enforce max delay for evictions detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "evictions_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "evictions_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "evictions_disabled" {
  description = "Disable all alerting rules for evictions detector"
  type        = bool
  default     = null
}

variable "evictions_disabled_major" {
  description = "Disable major alerting rule for evictions detector"
  type        = bool
  default     = null
}

variable "evictions_disabled_critical" {
  description = "Disable critical alerting rule for evictions detector"
  type        = bool
  default     = null
}

variable "evictions_threshold_major" {
  description = "Major threshold for evictions detector"
  type        = number
  default     = 0
}

variable "evictions_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "evictions_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "evictions_threshold_critical" {
  description = "Critical threshold for evictions detector"
  type        = number
  default     = 30
}

variable "evictions_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "evictions_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# max_connection detector

variable "max_connection_notifications" {
  description = "Notification recipients list per severity overridden for max_connection detector"
  type        = map(list(string))
  default     = {}
}

variable "max_connection_aggregation_function" {
  description = "Aggregation function and group by for max_connection detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "max_connection_transformation_function" {
  description = "Transformation function for max_connection detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".max(over='5m')"
}

variable "max_connection_max_delay" {
  description = "Enforce max delay for max_connection detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "max_connection_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "max_connection_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "max_connection_disabled" {
  description = "Disable all alerting rules for max_connection detector"
  type        = bool
  default     = null
}

variable "max_connection_threshold_critical" {
  description = "Critical threshold for max_connection detector"
  type        = number
  default     = 64999
}

variable "max_connection_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "max_connection_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# no_connection detector

variable "no_connection_notifications" {
  description = "Notification recipients list per severity overridden for no_connection detector"
  type        = map(list(string))
  default     = {}
}

variable "no_connection_aggregation_function" {
  description = "Aggregation function and group by for no_connection detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "no_connection_transformation_function" {
  description = "Transformation function for no_connection detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='5m')"
}

variable "no_connection_max_delay" {
  description = "Enforce max delay for no_connection detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "no_connection_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "no_connection_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "no_connection_disabled" {
  description = "Disable all alerting rules for no_connection detector"
  type        = bool
  default     = null
}

variable "no_connection_threshold_critical" {
  description = "Critical threshold for no_connection detector"
  type        = number
  default     = 0
}

variable "no_connection_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "no_connection_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# swap detector

variable "swap_notifications" {
  description = "Notification recipients list per severity overridden for swap detector"
  type        = map(list(string))
  default     = {}
}

variable "swap_aggregation_function" {
  description = "Aggregation function and group by for swap detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "swap_transformation_function" {
  description = "Transformation function for swap detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='5m')"
}

variable "swap_max_delay" {
  description = "Enforce max delay for swap detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "swap_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "swap_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "swap_disabled" {
  description = "Disable all alerting rules for swap detector"
  type        = bool
  default     = null
}

variable "swap_disabled_major" {
  description = "Disable major alerting rule for swap detector"
  type        = bool
  default     = null
}

variable "swap_disabled_critical" {
  description = "Disable critical alerting rule for swap detector"
  type        = bool
  default     = null
}

variable "swap_threshold_major" {
  description = "Major threshold for swap detector"
  type        = number
  default     = 0
}

variable "swap_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "swap_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "swap_threshold_critical" {
  description = "Critical threshold for swap detector"
  type        = number
  default     = 50000000
}

variable "swap_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "swap_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# free_memory detector

variable "free_memory_notifications" {
  description = "Notification recipients list per severity overridden for free_memory detector"
  type        = map(list(string))
  default     = {}
}

variable "free_memory_aggregation_function" {
  description = "Aggregation function and group by for free_memory detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "free_memory_transformation_function" {
  description = "Transformation function for free_memory detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".rateofchange().mean(over='15m')"
}

variable "free_memory_max_delay" {
  description = "Enforce max delay for free_memory detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "free_memory_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "free_memory_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "free_memory_disabled" {
  description = "Disable all alerting rules for free_memory detector"
  type        = bool
  default     = null
}

variable "free_memory_disabled_minor" {
  description = "Disable minor alerting rule for free_memory detector"
  type        = bool
  default     = null
}

variable "free_memory_disabled_major" {
  description = "Disable major alerting rule for free_memory detector"
  type        = bool
  default     = null
}

variable "free_memory_threshold_minor" {
  description = "Minor threshold for free_memory detector"
  type        = number
  default     = -50
}

variable "free_memory_lasting_duration_minor" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "free_memory_at_least_percentage_minor" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "free_memory_threshold_major" {
  description = "Major threshold for free_memory detector"
  type        = number
  default     = -70
}

variable "free_memory_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "free_memory_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# evictions_growing detector

variable "evictions_growing_notifications" {
  description = "Notification recipients list per severity overridden for evictions_growing detector"
  type        = map(list(string))
  default     = {}
}

variable "evictions_growing_aggregation_function" {
  description = "Aggregation function and group by for evictions_growing detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "evictions_growing_transformation_function" {
  description = "Transformation function for evictions_growing detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".mean(over='5m').rateofchange().scale(100)"
}

variable "evictions_growing_max_delay" {
  description = "Enforce max delay for evictions_growing detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "evictions_growing_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "evictions_growing_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "evictions_growing_disabled" {
  description = "Disable all alerting rules for evictions_growing detector"
  type        = bool
  default     = null
}

variable "evictions_growing_disabled_major" {
  description = "Disable major alerting rule for evictions_growing detector"
  type        = bool
  default     = null
}

variable "evictions_growing_disabled_critical" {
  description = "Disable critical alerting rule for evictions_growing detector"
  type        = bool
  default     = null
}

variable "evictions_growing_threshold_major" {
  description = "Major threshold for evictions_growing detector"
  type        = number
  default     = 10
}

variable "evictions_growing_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "evictions_growing_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "evictions_growing_threshold_critical" {
  description = "Critical threshold for evictions_growing detector"
  type        = number
  default     = 30
}

variable "evictions_growing_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "evictions_growing_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
