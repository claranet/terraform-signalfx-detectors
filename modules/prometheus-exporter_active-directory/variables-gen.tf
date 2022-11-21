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

# replication_errors detector

variable "replication_errors_notifications" {
  description = "Notification recipients list per severity overridden for replication_errors detector"
  type        = map(list(string))
  default     = {}
}

variable "replication_errors_aggregation_function" {
  description = "Aggregation function and group by for replication_errors detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['host.name'])"
}

variable "replication_errors_transformation_function" {
  description = "Transformation function for replication_errors detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "replication_errors_max_delay" {
  description = "Enforce max delay for replication_errors detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "replication_errors_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "replication_errors_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "replication_errors_disabled" {
  description = "Disable all alerting rules for replication_errors detector"
  type        = bool
  default     = null
}

variable "replication_errors_disabled_critical" {
  description = "Disable critical alerting rule for replication_errors detector"
  type        = bool
  default     = null
}

variable "replication_errors_disabled_major" {
  description = "Disable major alerting rule for replication_errors detector"
  type        = bool
  default     = null
}

variable "replication_errors_threshold_critical" {
  description = "Critical threshold for replication_errors detector"
  type        = number
  default     = 90
}

variable "replication_errors_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "5m"
}

variable "replication_errors_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "replication_errors_threshold_major" {
  description = "Major threshold for replication_errors detector"
  type        = number
  default     = 80
}

variable "replication_errors_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "5m"
}

variable "replication_errors_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# active_directory_services detector

variable "active_directory_services_notifications" {
  description = "Notification recipients list per severity overridden for active_directory_services detector"
  type        = map(list(string))
  default     = {}
}

variable "active_directory_services_aggregation_function" {
  description = "Aggregation function and group by for active_directory_services detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['host.name'])"
}

variable "active_directory_services_transformation_function" {
  description = "Transformation function for active_directory_services detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "active_directory_services_max_delay" {
  description = "Enforce max delay for active_directory_services detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "active_directory_services_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "active_directory_services_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "active_directory_services_disabled" {
  description = "Disable all alerting rules for active_directory_services detector"
  type        = bool
  default     = null
}

variable "active_directory_services_threshold_critical" {
  description = "Critical threshold for active_directory_services detector"
  type        = number
  default     = 1
}

variable "active_directory_services_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "5m"
}

variable "active_directory_services_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
