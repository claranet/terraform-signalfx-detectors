# heartbeat detector

variable "heartbeat_notifications" {
  description = "Notification recipients list per severity overridden for heartbeat detector"
  type        = map(list(string))
  default     = {}
}

variable "heartbeat_aggregation_function" {
  description = "Aggregation function and group by for heartbeat detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['DBInstanceIdentifier'])"
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

# cpu_usage detector

variable "cpu_usage_notifications" {
  description = "Notification recipients list per severity overridden for cpu_usage detector"
  type        = map(list(string))
  default     = {}
}

variable "cpu_usage_aggregation_function" {
  description = "Aggregation function and group by for cpu_usage detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".min(over='15m')"
}

variable "cpu_usage_transformation_function" {
  description = "Transformation function for cpu_usage detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "cpu_usage_max_delay" {
  description = "Enforce max delay for cpu_usage detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "cpu_usage_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "cpu_usage_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "cpu_usage_disabled" {
  description = "Disable all alerting rules for cpu_usage detector"
  type        = bool
  default     = null
}

variable "cpu_usage_disabled_critical" {
  description = "Disable critical alerting rule for cpu_usage detector"
  type        = bool
  default     = null
}

variable "cpu_usage_disabled_major" {
  description = "Disable major alerting rule for cpu_usage detector"
  type        = bool
  default     = null
}

variable "cpu_usage_threshold_critical" {
  description = "Critical threshold for cpu_usage detector in %"
  type        = number
  default     = 90
}

variable "cpu_usage_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "15m"
}

variable "cpu_usage_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "cpu_usage_threshold_major" {
  description = "Major threshold for cpu_usage detector in %"
  type        = number
  default     = 80
}

variable "cpu_usage_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "15m"
}

variable "cpu_usage_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# free_space_low detector

variable "free_space_low_notifications" {
  description = "Notification recipients list per severity overridden for free_space_low detector"
  type        = map(list(string))
  default     = {}
}

variable "free_space_low_aggregation_function" {
  description = "Aggregation function and group by for free_space_low detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".min(over='15m')"
}

variable "free_space_low_transformation_function" {
  description = "Transformation function for free_space_low detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".scale(1/1024**3)"
}

variable "free_space_low_max_delay" {
  description = "Enforce max delay for free_space_low detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "free_space_low_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "free_space_low_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "free_space_low_disabled" {
  description = "Disable all alerting rules for free_space_low detector"
  type        = bool
  default     = null
}

variable "free_space_low_disabled_major" {
  description = "Disable major alerting rule for free_space_low detector"
  type        = bool
  default     = null
}

variable "free_space_low_disabled_critical" {
  description = "Disable critical alerting rule for free_space_low detector"
  type        = bool
  default     = null
}

variable "free_space_low_threshold_major" {
  description = "Major threshold for free_space_low detector in Gibibyte"
  type        = number
  default     = 40
}

variable "free_space_low_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "15m"
}

variable "free_space_low_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "free_space_low_threshold_critical" {
  description = "Critical threshold for free_space_low detector in Gibibyte"
  type        = number
  default     = 20
}

variable "free_space_low_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "15m"
}

variable "free_space_low_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# replica_lag detector

variable "replica_lag_notifications" {
  description = "Notification recipients list per severity overridden for replica_lag detector"
  type        = map(list(string))
  default     = {}
}

variable "replica_lag_aggregation_function" {
  description = "Aggregation function and group by for replica_lag detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".min(over='5m')"
}

variable "replica_lag_transformation_function" {
  description = "Transformation function for replica_lag detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "replica_lag_max_delay" {
  description = "Enforce max delay for replica_lag detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "replica_lag_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "replica_lag_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "replica_lag_disabled" {
  description = "Disable all alerting rules for replica_lag detector"
  type        = bool
  default     = null
}

variable "replica_lag_disabled_critical" {
  description = "Disable critical alerting rule for replica_lag detector"
  type        = bool
  default     = null
}

variable "replica_lag_disabled_major" {
  description = "Disable major alerting rule for replica_lag detector"
  type        = bool
  default     = null
}

variable "replica_lag_threshold_critical" {
  description = "Critical threshold for replica_lag detector"
  type        = number
  default     = 300
}

variable "replica_lag_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "replica_lag_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "replica_lag_threshold_major" {
  description = "Major threshold for replica_lag detector"
  type        = number
  default     = 200
}

variable "replica_lag_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "replica_lag_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# dbload detector

variable "dbload_notifications" {
  description = "Notification recipients list per severity overridden for dbload detector"
  type        = map(list(string))
  default     = {}
}

variable "dbload_aggregation_function" {
  description = "Aggregation function and group by for dbload detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "dbload_transformation_function" {
  description = "Transformation function for dbload detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "dbload_max_delay" {
  description = "Enforce max delay for dbload detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "dbload_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "dbload_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "dbload_disabled" {
  description = "Disable all alerting rules for dbload detector"
  type        = bool
  default     = null
}

variable "dbload_disabled_critical" {
  description = "Disable critical alerting rule for dbload detector"
  type        = bool
  default     = null
}

variable "dbload_disabled_major" {
  description = "Disable major alerting rule for dbload detector"
  type        = bool
  default     = null
}

variable "dbload_threshold_critical" {
  description = "Critical threshold for dbload detector"
  type        = number
  default     = 16
}

variable "dbload_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "5m"
}

variable "dbload_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "dbload_threshold_major" {
  description = "Major threshold for dbload detector"
  type        = number
  default     = 8
}

variable "dbload_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "5m"
}

variable "dbload_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
