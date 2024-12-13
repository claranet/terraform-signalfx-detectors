# cache_hits detector

variable "cache_hits_notifications" {
  description = "Notification recipients list per severity overridden for cache_hits detector"
  type        = map(list(string))
  default     = {}
}

variable "cache_hits_aggregation_function" {
  description = "Aggregation function and group by for cache_hits detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "cache_hits_transformation_function" {
  description = "Transformation function for cache_hits detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "cache_hits_max_delay" {
  description = "Enforce max delay for cache_hits detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "cache_hits_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "cache_hits_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "cache_hits_disabled" {
  description = "Disable all alerting rules for cache_hits detector"
  type        = bool
  default     = null
}

variable "cache_hits_disabled_major" {
  description = "Disable major alerting rule for cache_hits detector"
  type        = bool
  default     = null
}

variable "cache_hits_disabled_minor" {
  description = "Disable minor alerting rule for cache_hits detector"
  type        = bool
  default     = null
}

variable "cache_hits_threshold_major" {
  description = "Major threshold for cache_hits detector in %"
  type        = number
  default     = 60
}

variable "cache_hits_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "5m"
}

variable "cache_hits_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 0.9
}
variable "cache_hits_threshold_minor" {
  description = "Minor threshold for cache_hits detector in %"
  type        = number
  default     = 80
}

variable "cache_hits_lasting_duration_minor" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "5m"
}

variable "cache_hits_at_least_percentage_minor" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 0.9
}
# cpu_high detector

variable "cpu_high_notifications" {
  description = "Notification recipients list per severity overridden for cpu_high detector"
  type        = map(list(string))
  default     = {}
}

variable "cpu_high_aggregation_function" {
  description = "Aggregation function and group by for cpu_high detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "cpu_high_transformation_function" {
  description = "Transformation function for cpu_high detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "cpu_high_max_delay" {
  description = "Enforce max delay for cpu_high detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "cpu_high_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "cpu_high_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "cpu_high_disabled" {
  description = "Disable all alerting rules for cpu_high detector"
  type        = bool
  default     = null
}

variable "cpu_high_disabled_critical" {
  description = "Disable critical alerting rule for cpu_high detector"
  type        = bool
  default     = null
}

variable "cpu_high_disabled_major" {
  description = "Disable major alerting rule for cpu_high detector"
  type        = bool
  default     = null
}

variable "cpu_high_threshold_critical" {
  description = "Critical threshold for cpu_high detector in %"
  type        = number
  default     = 90
}

variable "cpu_high_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "15m"
}

variable "cpu_high_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "cpu_high_threshold_major" {
  description = "Major threshold for cpu_high detector in %"
  type        = number
  default     = 75
}

variable "cpu_high_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "15m"
}

variable "cpu_high_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# replication_lag detector

variable "replication_lag_notifications" {
  description = "Notification recipients list per severity overridden for replication_lag detector"
  type        = map(list(string))
  default     = {}
}

variable "replication_lag_aggregation_function" {
  description = "Aggregation function and group by for replication_lag detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "replication_lag_transformation_function" {
  description = "Transformation function for replication_lag detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "replication_lag_max_delay" {
  description = "Enforce max delay for replication_lag detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "replication_lag_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "replication_lag_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "replication_lag_disabled" {
  description = "Disable all alerting rules for replication_lag detector"
  type        = bool
  default     = null
}

variable "replication_lag_disabled_critical" {
  description = "Disable critical alerting rule for replication_lag detector"
  type        = bool
  default     = null
}

variable "replication_lag_disabled_major" {
  description = "Disable major alerting rule for replication_lag detector"
  type        = bool
  default     = null
}

variable "replication_lag_threshold_critical" {
  description = "Critical threshold for replication_lag detector in Second"
  type        = number
  default     = 180
}

variable "replication_lag_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "10m"
}

variable "replication_lag_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "replication_lag_threshold_major" {
  description = "Major threshold for replication_lag detector in Second"
  type        = number
  default     = 90
}

variable "replication_lag_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "10m"
}

variable "replication_lag_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# commands detector

variable "commands_notifications" {
  description = "Notification recipients list per severity overridden for commands detector"
  type        = map(list(string))
  default     = {}
}

variable "commands_aggregation_function" {
  description = "Aggregation function and group by for commands detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "commands_transformation_function" {
  description = "Transformation function for commands detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".sum(over='15m')"
}

variable "commands_max_delay" {
  description = "Enforce max delay for commands detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "commands_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "commands_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "commands_disabled" {
  description = "Disable all alerting rules for commands detector"
  type        = bool
  default     = null
}

variable "commands_threshold_major" {
  description = "Major threshold for commands detector"
  type        = number
  default     = 0
}

variable "commands_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "commands_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# network_conntrack_allowance_exceeded detector

variable "network_conntrack_allowance_exceeded_notifications" {
  description = "Notification recipients list per severity overridden for network_conntrack_allowance_exceeded detector"
  type        = map(list(string))
  default     = {}
}

variable "network_conntrack_allowance_exceeded_aggregation_function" {
  description = "Aggregation function and group by for network_conntrack_allowance_exceeded detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "network_conntrack_allowance_exceeded_transformation_function" {
  description = "Transformation function for network_conntrack_allowance_exceeded detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "network_conntrack_allowance_exceeded_max_delay" {
  description = "Enforce max delay for network_conntrack_allowance_exceeded detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "network_conntrack_allowance_exceeded_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "network_conntrack_allowance_exceeded_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "network_conntrack_allowance_exceeded_disabled" {
  description = "Disable all alerting rules for network_conntrack_allowance_exceeded detector"
  type        = bool
  default     = null
}

variable "network_conntrack_allowance_exceeded_threshold_critical" {
  description = "Critical threshold for network_conntrack_allowance_exceeded detector"
  type        = number
  default     = 0
}

variable "network_conntrack_allowance_exceeded_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "network_conntrack_allowance_exceeded_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# database_capacity_usage detector

variable "database_capacity_usage_notifications" {
  description = "Notification recipients list per severity overridden for database_capacity_usage detector"
  type        = map(list(string))
  default     = {}
}

variable "database_capacity_usage_aggregation_function" {
  description = "Aggregation function and group by for database_capacity_usage detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "database_capacity_usage_transformation_function" {
  description = "Transformation function for database_capacity_usage detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "database_capacity_usage_max_delay" {
  description = "Enforce max delay for database_capacity_usage detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "database_capacity_usage_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "database_capacity_usage_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "database_capacity_usage_disabled" {
  description = "Disable all alerting rules for database_capacity_usage detector"
  type        = bool
  default     = null
}

variable "database_capacity_usage_disabled_critical" {
  description = "Disable critical alerting rule for database_capacity_usage detector"
  type        = bool
  default     = null
}

variable "database_capacity_usage_disabled_major" {
  description = "Disable major alerting rule for database_capacity_usage detector"
  type        = bool
  default     = null
}

variable "database_capacity_usage_threshold_critical" {
  description = "Critical threshold for database_capacity_usage detector"
  type        = number
  default     = 90
}

variable "database_capacity_usage_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "10m"
}

variable "database_capacity_usage_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "database_capacity_usage_threshold_major" {
  description = "Major threshold for database_capacity_usage detector"
  type        = number
  default     = 80
}

variable "database_capacity_usage_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "10m"
}

variable "database_capacity_usage_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
