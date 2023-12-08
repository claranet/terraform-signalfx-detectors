# aurora_postgresql_replica_lag detector

variable "aurora_postgresql_replica_lag_notifications" {
  description = "Notification recipients list per severity overridden for aurora_postgresql_replica_lag detector"
  type        = map(list(string))
  default     = {}
}

variable "aurora_postgresql_replica_lag_aggregation_function" {
  description = "Aggregation function and group by for aurora_postgresql_replica_lag detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "aurora_postgresql_replica_lag_transformation_function" {
  description = "Transformation function for aurora_postgresql_replica_lag detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='5m')"
}

variable "aurora_postgresql_replica_lag_max_delay" {
  description = "Enforce max delay for aurora_postgresql_replica_lag detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "aurora_postgresql_replica_lag_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "aurora_postgresql_replica_lag_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "aurora_postgresql_replica_lag_disabled" {
  description = "Disable all alerting rules for aurora_postgresql_replica_lag detector"
  type        = bool
  default     = null
}

variable "aurora_postgresql_replica_lag_disabled_critical" {
  description = "Disable critical alerting rule for aurora_postgresql_replica_lag detector"
  type        = bool
  default     = null
}

variable "aurora_postgresql_replica_lag_disabled_major" {
  description = "Disable major alerting rule for aurora_postgresql_replica_lag detector"
  type        = bool
  default     = null
}

variable "aurora_postgresql_replica_lag_threshold_critical" {
  description = "Critical threshold for aurora_postgresql_replica_lag detector"
  type        = number
  default     = 200
}

variable "aurora_postgresql_replica_lag_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "aurora_postgresql_replica_lag_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "aurora_postgresql_replica_lag_threshold_major" {
  description = "Major threshold for aurora_postgresql_replica_lag detector"
  type        = number
  default     = 100
}

variable "aurora_postgresql_replica_lag_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "aurora_postgresql_replica_lag_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
