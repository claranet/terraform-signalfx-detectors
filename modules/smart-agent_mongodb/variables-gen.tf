# heartbeat detector

variable "heartbeat_notifications" {
  description = "Notification recipients list per severity overridden for heartbeat detector"
  type        = map(list(string))
  default     = {}
}

variable "heartbeat_aggregation_function" {
  description = "Aggregation function and group by for heartbeat detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['cluster'])"
}

variable "heartbeat_transformation_function" {
  description = "Transformation function for heartbeat detector (i.e. \".mean(over='5m')\")"
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

variable "heartbeat_timeframe" {
  description = "Timeframe for heartbeat detector (i.e. \"25m\"). Must be at least \"25m\" if exclude_not_running_vm is true"
  type        = string
  default     = "25m"
}

# page_faults detector

variable "page_faults_notifications" {
  description = "Notification recipients list per severity overridden for page_faults detector"
  type        = map(list(string))
  default     = {}
}

variable "page_faults_aggregation_function" {
  description = "Aggregation function and group by for page_faults detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "page_faults_transformation_function" {
  description = "Transformation function for page_faults detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".mean(over='5m')"
}

variable "page_faults_max_delay" {
  description = "Enforce max delay for page_faults detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "page_faults_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "page_faults_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "page_faults_disabled" {
  description = "Disable all alerting rules for page_faults detector"
  type        = bool
  default     = null
}

variable "page_faults_threshold_warning" {
  description = "Warning threshold for page_faults detector"
  type        = number
  default     = 0
}

variable "page_faults_lasting_duration_warning" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "page_faults_at_least_percentage_warning" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# max_connections detector

variable "max_connections_notifications" {
  description = "Notification recipients list per severity overridden for max_connections detector"
  type        = map(list(string))
  default     = {}
}

variable "max_connections_aggregation_function" {
  description = "Aggregation function and group by for max_connections detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "max_connections_transformation_function" {
  description = "Transformation function for max_connections detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".mean(over='5m')"
}

variable "max_connections_max_delay" {
  description = "Enforce max delay for max_connections detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "max_connections_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "max_connections_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "max_connections_disabled" {
  description = "Disable all alerting rules for max_connections detector"
  type        = bool
  default     = null
}

variable "max_connections_disabled_critical" {
  description = "Disable critical alerting rule for max_connections detector"
  type        = bool
  default     = null
}

variable "max_connections_disabled_major" {
  description = "Disable major alerting rule for max_connections detector"
  type        = bool
  default     = null
}

variable "max_connections_threshold_critical" {
  description = "Critical threshold for max_connections detector"
  type        = number
  default     = 90
}

variable "max_connections_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "max_connections_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "max_connections_threshold_major" {
  description = "Major threshold for max_connections detector"
  type        = number
  default     = 75
}

variable "max_connections_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "max_connections_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# asserts detector

variable "asserts_notifications" {
  description = "Notification recipients list per severity overridden for asserts detector"
  type        = map(list(string))
  default     = {}
}

variable "asserts_aggregation_function" {
  description = "Aggregation function and group by for asserts detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "asserts_transformation_function" {
  description = "Transformation function for asserts detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".max(over='30m')"
}

variable "asserts_max_delay" {
  description = "Enforce max delay for asserts detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "asserts_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "asserts_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "asserts_disabled" {
  description = "Disable all alerting rules for asserts detector"
  type        = bool
  default     = null
}

variable "asserts_threshold_minor" {
  description = "Minor threshold for asserts detector"
  type        = number
  default     = 0
}

variable "asserts_lasting_duration_minor" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "asserts_at_least_percentage_minor" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# primary detector

variable "primary_notifications" {
  description = "Notification recipients list per severity overridden for primary detector"
  type        = map(list(string))
  default     = {}
}

variable "primary_aggregation_function" {
  description = "Aggregation function and group by for primary detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".max(by=['cluster'])"
}

variable "primary_transformation_function" {
  description = "Transformation function for primary detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='1m')"
}

variable "primary_max_delay" {
  description = "Enforce max delay for primary detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "primary_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "primary_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "primary_disabled" {
  description = "Disable all alerting rules for primary detector"
  type        = bool
  default     = null
}

variable "primary_threshold_critical" {
  description = "Critical threshold for primary detector"
  type        = number
  default     = 1
}

variable "primary_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "primary_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# secondary detector

variable "secondary_notifications" {
  description = "Notification recipients list per severity overridden for secondary detector"
  type        = map(list(string))
  default     = {}
}

variable "secondary_aggregation_function" {
  description = "Aggregation function and group by for secondary detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".max(by=['cluster'])"
}

variable "secondary_transformation_function" {
  description = "Transformation function for secondary detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='5m')"
}

variable "secondary_max_delay" {
  description = "Enforce max delay for secondary detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "secondary_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "secondary_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "secondary_disabled" {
  description = "Disable all alerting rules for secondary detector"
  type        = bool
  default     = null
}

variable "secondary_threshold_critical" {
  description = "Critical threshold for secondary detector"
  type        = number
  default     = 2
}

variable "secondary_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "secondary_at_least_percentage_critical" {
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
  default     = ".mean(over='15m')"
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
  description = "Critical threshold for replication_lag detector"
  type        = number
  default     = 10
}

variable "replication_lag_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "replication_lag_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "replication_lag_threshold_major" {
  description = "Major threshold for replication_lag detector"
  type        = number
  default     = 3
}

variable "replication_lag_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "replication_lag_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
