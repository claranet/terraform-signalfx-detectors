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

# memcached_max_conn detector

variable "memcached_max_conn_notifications" {
  description = "Notification recipients list per severity overridden for memcached_max_conn detector"
  type        = map(list(string))
  default     = {}
}

variable "memcached_max_conn_aggregation_function" {
  description = "Aggregation function and group by for memcached_max_conn detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "memcached_max_conn_transformation_function" {
  description = "Transformation function for memcached_max_conn detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".max(over='5m')"
}

variable "memcached_max_conn_max_delay" {
  description = "Enforce max delay for memcached_max_conn detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "memcached_max_conn_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "memcached_max_conn_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "memcached_max_conn_disabled" {
  description = "Disable all alerting rules for memcached_max_conn detector"
  type        = bool
  default     = null
}

variable "memcached_max_conn_disabled_critical" {
  description = "Disable critical alerting rule for memcached_max_conn detector"
  type        = bool
  default     = null
}

variable "memcached_max_conn_disabled_major" {
  description = "Disable major alerting rule for memcached_max_conn detector"
  type        = bool
  default     = null
}

variable "memcached_max_conn_threshold_critical" {
  description = "Critical threshold for memcached_max_conn detector"
  type        = number
  default     = 5
}

variable "memcached_max_conn_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "memcached_max_conn_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "memcached_max_conn_threshold_major" {
  description = "Major threshold for memcached_max_conn detector"
  type        = number
  default     = 0
}

variable "memcached_max_conn_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "memcached_max_conn_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# memcached_hit_ratio detector

variable "memcached_hit_ratio_notifications" {
  description = "Notification recipients list per severity overridden for memcached_hit_ratio detector"
  type        = map(list(string))
  default     = {}
}

variable "memcached_hit_ratio_aggregation_function" {
  description = "Aggregation function and group by for memcached_hit_ratio detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "memcached_hit_ratio_transformation_function" {
  description = "Transformation function for memcached_hit_ratio detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "memcached_hit_ratio_max_delay" {
  description = "Enforce max delay for memcached_hit_ratio detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "memcached_hit_ratio_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "memcached_hit_ratio_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "memcached_hit_ratio_disabled" {
  description = "Disable all alerting rules for memcached_hit_ratio detector"
  type        = bool
  default     = null
}

variable "memcached_hit_ratio_disabled_major" {
  description = "Disable major alerting rule for memcached_hit_ratio detector"
  type        = bool
  default     = null
}

variable "memcached_hit_ratio_disabled_minor" {
  description = "Disable minor alerting rule for memcached_hit_ratio detector"
  type        = bool
  default     = null
}

variable "memcached_hit_ratio_threshold_major" {
  description = "Major threshold for memcached_hit_ratio detector"
  type        = number
  default     = 60
}

variable "memcached_hit_ratio_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "memcached_hit_ratio_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "memcached_hit_ratio_threshold_minor" {
  description = "Minor threshold for memcached_hit_ratio detector"
  type        = number
  default     = 80
}

variable "memcached_hit_ratio_lasting_duration_minor" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "memcached_hit_ratio_at_least_percentage_minor" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}