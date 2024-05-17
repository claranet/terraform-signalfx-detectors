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

variable "heartbeat_exclude_not_running_vm" {
  description = "Don’t send alerts if associated VM is stopped or stopping (metadata provided by cloud provider integration). Can be useful for ephemeral infrastructure (such as auto scaling groups) as VM will be stopped and started regularly. Note that timeframe must be at least 25 minutes for the metadata to be available to the detector."
  type        = bool
  default     = true
}

variable "heartbeat_timeframe" {
  description = "Timeframe for heartbeat detector (i.e. \"25m\"). Must be at least \"25m\" if exclude_not_running_vm is true"
  type        = string
  default     = "25m"
}

# mysql_connections detector

variable "mysql_connections_notifications" {
  description = "Notification recipients list per severity overridden for mysql_connections detector"
  type        = map(list(string))
  default     = {}
}

variable "mysql_connections_aggregation_function" {
  description = "Aggregation function and group by for mysql_connections detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "mysql_connections_transformation_function" {
  description = "Transformation function for mysql_connections detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='1m')"
}

variable "mysql_connections_max_delay" {
  description = "Enforce max delay for mysql_connections detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "mysql_connections_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "mysql_connections_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "mysql_connections_disabled" {
  description = "Disable all alerting rules for mysql_connections detector"
  type        = bool
  default     = null
}

variable "mysql_connections_disabled_critical" {
  description = "Disable critical alerting rule for mysql_connections detector"
  type        = bool
  default     = null
}

variable "mysql_connections_disabled_major" {
  description = "Disable major alerting rule for mysql_connections detector"
  type        = bool
  default     = null
}

variable "mysql_connections_threshold_critical" {
  description = "Critical threshold for mysql_connections detector"
  type        = number
  default     = 90
}

variable "mysql_connections_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "mysql_connections_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "mysql_connections_threshold_major" {
  description = "Major threshold for mysql_connections detector"
  type        = number
  default     = 70
}

variable "mysql_connections_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "mysql_connections_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# mysql_slow detector

variable "mysql_slow_notifications" {
  description = "Notification recipients list per severity overridden for mysql_slow detector"
  type        = map(list(string))
  default     = {}
}

variable "mysql_slow_aggregation_function" {
  description = "Aggregation function and group by for mysql_slow detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "mysql_slow_transformation_function" {
  description = "Transformation function for mysql_slow detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".mean(over='15m')"
}

variable "mysql_slow_max_delay" {
  description = "Enforce max delay for mysql_slow detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "mysql_slow_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "mysql_slow_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "mysql_slow_disabled" {
  description = "Disable all alerting rules for mysql_slow detector"
  type        = bool
  default     = null
}

variable "mysql_slow_disabled_critical" {
  description = "Disable critical alerting rule for mysql_slow detector"
  type        = bool
  default     = null
}

variable "mysql_slow_disabled_major" {
  description = "Disable major alerting rule for mysql_slow detector"
  type        = bool
  default     = null
}

variable "mysql_slow_threshold_critical" {
  description = "Critical threshold for mysql_slow detector"
  type        = number
  default     = 25
}

variable "mysql_slow_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "mysql_slow_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "mysql_slow_threshold_major" {
  description = "Major threshold for mysql_slow detector"
  type        = number
  default     = 10
}

variable "mysql_slow_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "mysql_slow_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# mysql_pool_efficiency detector

variable "mysql_pool_efficiency_notifications" {
  description = "Notification recipients list per severity overridden for mysql_pool_efficiency detector"
  type        = map(list(string))
  default     = {}
}

variable "mysql_pool_efficiency_aggregation_function" {
  description = "Aggregation function and group by for mysql_pool_efficiency detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "mysql_pool_efficiency_transformation_function" {
  description = "Transformation function for mysql_pool_efficiency detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='1h')"
}

variable "mysql_pool_efficiency_max_delay" {
  description = "Enforce max delay for mysql_pool_efficiency detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "mysql_pool_efficiency_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "mysql_pool_efficiency_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "mysql_pool_efficiency_disabled" {
  description = "Disable all alerting rules for mysql_pool_efficiency detector"
  type        = bool
  default     = null
}

variable "mysql_pool_efficiency_disabled_minor" {
  description = "Disable minor alerting rule for mysql_pool_efficiency detector"
  type        = bool
  default     = null
}

variable "mysql_pool_efficiency_disabled_warning" {
  description = "Disable warning alerting rule for mysql_pool_efficiency detector"
  type        = bool
  default     = null
}

variable "mysql_pool_efficiency_threshold_minor" {
  description = "Minor threshold for mysql_pool_efficiency detector"
  type        = number
  default     = 30
}

variable "mysql_pool_efficiency_lasting_duration_minor" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "mysql_pool_efficiency_at_least_percentage_minor" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "mysql_pool_efficiency_threshold_warning" {
  description = "Warning threshold for mysql_pool_efficiency detector"
  type        = number
  default     = 20
}

variable "mysql_pool_efficiency_lasting_duration_warning" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "mysql_pool_efficiency_at_least_percentage_warning" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# mysql_pool_utilization detector

variable "mysql_pool_utilization_notifications" {
  description = "Notification recipients list per severity overridden for mysql_pool_utilization detector"
  type        = map(list(string))
  default     = {}
}

variable "mysql_pool_utilization_aggregation_function" {
  description = "Aggregation function and group by for mysql_pool_utilization detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "mysql_pool_utilization_transformation_function" {
  description = "Transformation function for mysql_pool_utilization detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='1h')"
}

variable "mysql_pool_utilization_max_delay" {
  description = "Enforce max delay for mysql_pool_utilization detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "mysql_pool_utilization_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "mysql_pool_utilization_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "mysql_pool_utilization_disabled" {
  description = "Disable all alerting rules for mysql_pool_utilization detector"
  type        = bool
  default     = null
}

variable "mysql_pool_utilization_disabled_minor" {
  description = "Disable minor alerting rule for mysql_pool_utilization detector"
  type        = bool
  default     = null
}

variable "mysql_pool_utilization_disabled_warning" {
  description = "Disable warning alerting rule for mysql_pool_utilization detector"
  type        = bool
  default     = null
}

variable "mysql_pool_utilization_threshold_minor" {
  description = "Minor threshold for mysql_pool_utilization detector"
  type        = number
  default     = 95
}

variable "mysql_pool_utilization_lasting_duration_minor" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "mysql_pool_utilization_at_least_percentage_minor" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "mysql_pool_utilization_threshold_warning" {
  description = "Warning threshold for mysql_pool_utilization detector"
  type        = number
  default     = 80
}

variable "mysql_pool_utilization_lasting_duration_warning" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "mysql_pool_utilization_at_least_percentage_warning" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# mysql_replication_lag detector

variable "mysql_replication_lag_notifications" {
  description = "Notification recipients list per severity overridden for mysql_replication_lag detector"
  type        = map(list(string))
  default     = {}
}

variable "mysql_replication_lag_aggregation_function" {
  description = "Aggregation function and group by for mysql_replication_lag detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "mysql_replication_lag_transformation_function" {
  description = "Transformation function for mysql_replication_lag detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='15m')"
}

variable "mysql_replication_lag_max_delay" {
  description = "Enforce max delay for mysql_replication_lag detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "mysql_replication_lag_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "mysql_replication_lag_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "mysql_replication_lag_disabled" {
  description = "Disable all alerting rules for mysql_replication_lag detector"
  type        = bool
  default     = null
}

variable "mysql_replication_lag_disabled_critical" {
  description = "Disable critical alerting rule for mysql_replication_lag detector"
  type        = bool
  default     = null
}

variable "mysql_replication_lag_disabled_major" {
  description = "Disable major alerting rule for mysql_replication_lag detector"
  type        = bool
  default     = null
}

variable "mysql_replication_lag_threshold_critical" {
  description = "Critical threshold for mysql_replication_lag detector"
  type        = number
  default     = 200
}

variable "mysql_replication_lag_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "mysql_replication_lag_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "mysql_replication_lag_threshold_major" {
  description = "Major threshold for mysql_replication_lag detector"
  type        = number
  default     = 100
}

variable "mysql_replication_lag_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "mysql_replication_lag_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# mysql_slave_sql_status detector

variable "mysql_slave_sql_status_notifications" {
  description = "Notification recipients list per severity overridden for mysql_slave_sql_status detector"
  type        = map(list(string))
  default     = {}
}

variable "mysql_slave_sql_status_aggregation_function" {
  description = "Aggregation function and group by for mysql_slave_sql_status detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "mysql_slave_sql_status_transformation_function" {
  description = "Transformation function for mysql_slave_sql_status detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".max(over='5m')"
}

variable "mysql_slave_sql_status_max_delay" {
  description = "Enforce max delay for mysql_slave_sql_status detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "mysql_slave_sql_status_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "mysql_slave_sql_status_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "mysql_slave_sql_status_disabled" {
  description = "Disable all alerting rules for mysql_slave_sql_status detector"
  type        = bool
  default     = null
}

variable "mysql_slave_sql_status_threshold_critical" {
  description = "Critical threshold for mysql_slave_sql_status detector"
  type        = number
  default     = 1
}

variable "mysql_slave_sql_status_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "mysql_slave_sql_status_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# mysql_slave_io_status detector

variable "mysql_slave_io_status_notifications" {
  description = "Notification recipients list per severity overridden for mysql_slave_io_status detector"
  type        = map(list(string))
  default     = {}
}

variable "mysql_slave_io_status_aggregation_function" {
  description = "Aggregation function and group by for mysql_slave_io_status detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "mysql_slave_io_status_transformation_function" {
  description = "Transformation function for mysql_slave_io_status detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".max(over='5m')"
}

variable "mysql_slave_io_status_max_delay" {
  description = "Enforce max delay for mysql_slave_io_status detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "mysql_slave_io_status_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "mysql_slave_io_status_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "mysql_slave_io_status_disabled" {
  description = "Disable all alerting rules for mysql_slave_io_status detector"
  type        = bool
  default     = null
}

variable "mysql_slave_io_status_threshold_critical" {
  description = "Critical threshold for mysql_slave_io_status detector"
  type        = number
  default     = 1
}

variable "mysql_slave_io_status_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "mysql_slave_io_status_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
