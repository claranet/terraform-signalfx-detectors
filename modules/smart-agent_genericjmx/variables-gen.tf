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

# memory_heap detector

variable "memory_heap_notifications" {
  description = "Notification recipients list per severity overridden for memory_heap detector"
  type        = map(list(string))
  default     = {}
}

variable "memory_heap_aggregation_function" {
  description = "Aggregation function and group by for memory_heap detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "memory_heap_transformation_function" {
  description = "Transformation function for memory_heap detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='5m')"
}

variable "memory_heap_max_delay" {
  description = "Enforce max delay for memory_heap detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "memory_heap_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "memory_heap_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "memory_heap_disabled" {
  description = "Disable all alerting rules for memory_heap detector"
  type        = bool
  default     = null
}

variable "memory_heap_disabled_critical" {
  description = "Disable critical alerting rule for memory_heap detector"
  type        = bool
  default     = null
}

variable "memory_heap_disabled_major" {
  description = "Disable major alerting rule for memory_heap detector"
  type        = bool
  default     = null
}

variable "memory_heap_threshold_critical" {
  description = "Critical threshold for memory_heap detector in %"
  type        = number
  default     = 90
}

variable "memory_heap_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "memory_heap_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "memory_heap_threshold_major" {
  description = "Major threshold for memory_heap detector in %"
  type        = number
  default     = 80
}

variable "memory_heap_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "memory_heap_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# gc_old_gen detector

variable "gc_old_gen_notifications" {
  description = "Notification recipients list per severity overridden for gc_old_gen detector"
  type        = map(list(string))
  default     = {}
}

variable "gc_old_gen_aggregation_function" {
  description = "Aggregation function and group by for gc_old_gen detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "gc_old_gen_transformation_function" {
  description = "Transformation function for gc_old_gen detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='5m')"
}

variable "gc_old_gen_max_delay" {
  description = "Enforce max delay for gc_old_gen detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "gc_old_gen_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "gc_old_gen_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "gc_old_gen_disabled" {
  description = "Disable all alerting rules for gc_old_gen detector"
  type        = bool
  default     = null
}

variable "gc_old_gen_disabled_critical" {
  description = "Disable critical alerting rule for gc_old_gen detector"
  type        = bool
  default     = null
}

variable "gc_old_gen_disabled_major" {
  description = "Disable major alerting rule for gc_old_gen detector"
  type        = bool
  default     = null
}

variable "gc_old_gen_threshold_critical" {
  description = "Critical threshold for gc_old_gen detector in %"
  type        = number
  default     = 90
}

variable "gc_old_gen_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "gc_old_gen_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "gc_old_gen_threshold_major" {
  description = "Major threshold for gc_old_gen detector in %"
  type        = number
  default     = 80
}

variable "gc_old_gen_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "gc_old_gen_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
