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

variable "cache_hits_disabled_critical" {
  description = "Disable critical alerting rule for cache_hits detector"
  type        = bool
  default     = null
}

variable "cache_hits_disabled_major" {
  description = "Disable major alerting rule for cache_hits detector"
  type        = bool
  default     = null
}

variable "cache_hits_threshold_critical" {
  description = "Critical threshold for cache_hits detector in %"
  type        = number
  default     = 60
}

variable "cache_hits_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "5m"
}

variable "cache_hits_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 0.9
}
variable "cache_hits_threshold_major" {
  description = "Major threshold for cache_hits detector in %"
  type        = number
  default     = 80
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
  description = "Critical threshold for replication_lag detector in s"
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
  description = "Major threshold for replication_lag detector in s"
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
  default     = ""
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
  default     = "15m"
}

variable "commands_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
