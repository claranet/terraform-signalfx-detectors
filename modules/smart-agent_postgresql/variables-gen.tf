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

# deadlocks detector

variable "deadlocks_notifications" {
  description = "Notification recipients list per severity overridden for deadlocks detector"
  type        = map(list(string))
  default     = {}
}

variable "deadlocks_aggregation_function" {
  description = "Aggregation function and group by for deadlocks detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "deadlocks_transformation_function" {
  description = "Transformation function for deadlocks detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".max(over='5m')"
}

variable "deadlocks_max_delay" {
  description = "Enforce max delay for deadlocks detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "deadlocks_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "deadlocks_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "deadlocks_disabled" {
  description = "Disable all alerting rules for deadlocks detector"
  type        = bool
  default     = null
}

variable "deadlocks_disabled_major" {
  description = "Disable major alerting rule for deadlocks detector"
  type        = bool
  default     = null
}

variable "deadlocks_disabled_minor" {
  description = "Disable minor alerting rule for deadlocks detector"
  type        = bool
  default     = null
}

variable "deadlocks_threshold_major" {
  description = "Major threshold for deadlocks detector"
  type        = number
  default     = 0.1
}

variable "deadlocks_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "deadlocks_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "deadlocks_threshold_minor" {
  description = "Minor threshold for deadlocks detector"
  type        = number
  default     = 0
}

variable "deadlocks_lasting_duration_minor" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "deadlocks_at_least_percentage_minor" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# hit_ratio detector

variable "hit_ratio_notifications" {
  description = "Notification recipients list per severity overridden for hit_ratio detector"
  type        = map(list(string))
  default     = {}
}

variable "hit_ratio_aggregation_function" {
  description = "Aggregation function and group by for hit_ratio detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "hit_ratio_transformation_function" {
  description = "Transformation function for hit_ratio detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".scale(100).max(over='1h')"
}

variable "hit_ratio_max_delay" {
  description = "Enforce max delay for hit_ratio detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "hit_ratio_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "hit_ratio_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "hit_ratio_disabled" {
  description = "Disable all alerting rules for hit_ratio detector"
  type        = bool
  default     = null
}

variable "hit_ratio_disabled_minor" {
  description = "Disable minor alerting rule for hit_ratio detector"
  type        = bool
  default     = null
}

variable "hit_ratio_disabled_warning" {
  description = "Disable warning alerting rule for hit_ratio detector"
  type        = bool
  default     = null
}

variable "hit_ratio_threshold_minor" {
  description = "Minor threshold for hit_ratio detector"
  type        = number
  default     = 75
}

variable "hit_ratio_lasting_duration_minor" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "hit_ratio_at_least_percentage_minor" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "hit_ratio_threshold_warning" {
  description = "Warning threshold for hit_ratio detector"
  type        = number
  default     = 50
}

variable "hit_ratio_lasting_duration_warning" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "hit_ratio_at_least_percentage_warning" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# rollbacks detector

variable "rollbacks_notifications" {
  description = "Notification recipients list per severity overridden for rollbacks detector"
  type        = map(list(string))
  default     = {}
}

variable "rollbacks_aggregation_function" {
  description = "Aggregation function and group by for rollbacks detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "rollbacks_transformation_function" {
  description = "Transformation function for rollbacks detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='10m')"
}

variable "rollbacks_max_delay" {
  description = "Enforce max delay for rollbacks detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "rollbacks_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "rollbacks_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "rollbacks_disabled" {
  description = "Disable all alerting rules for rollbacks detector"
  type        = bool
  default     = null
}

variable "rollbacks_disabled_major" {
  description = "Disable major alerting rule for rollbacks detector"
  type        = bool
  default     = null
}

variable "rollbacks_disabled_minor" {
  description = "Disable minor alerting rule for rollbacks detector"
  type        = bool
  default     = null
}

variable "rollbacks_threshold_major" {
  description = "Major threshold for rollbacks detector"
  type        = number
  default     = 20
}

variable "rollbacks_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "rollbacks_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "rollbacks_threshold_minor" {
  description = "Minor threshold for rollbacks detector"
  type        = number
  default     = 10
}

variable "rollbacks_lasting_duration_minor" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "rollbacks_at_least_percentage_minor" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# conflicts detector

variable "conflicts_notifications" {
  description = "Notification recipients list per severity overridden for conflicts detector"
  type        = map(list(string))
  default     = {}
}

variable "conflicts_aggregation_function" {
  description = "Aggregation function and group by for conflicts detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "conflicts_transformation_function" {
  description = "Transformation function for conflicts detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".max(over='5m')"
}

variable "conflicts_max_delay" {
  description = "Enforce max delay for conflicts detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "conflicts_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "conflicts_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "conflicts_disabled" {
  description = "Disable all alerting rules for conflicts detector"
  type        = bool
  default     = null
}

variable "conflicts_disabled_major" {
  description = "Disable major alerting rule for conflicts detector"
  type        = bool
  default     = null
}

variable "conflicts_disabled_minor" {
  description = "Disable minor alerting rule for conflicts detector"
  type        = bool
  default     = null
}

variable "conflicts_threshold_major" {
  description = "Major threshold for conflicts detector"
  type        = number
  default     = 1
}

variable "conflicts_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "conflicts_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "conflicts_threshold_minor" {
  description = "Minor threshold for conflicts detector"
  type        = number
  default     = 0
}

variable "conflicts_lasting_duration_minor" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "conflicts_at_least_percentage_minor" {
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
  default     = ".scale(100).min(over='1m')"
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
  default     = 80
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
  default     = ".min(over='5m')"
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
  default     = 200
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
  default     = 100
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
# replication_state detector

variable "replication_state_notifications" {
  description = "Notification recipients list per severity overridden for replication_state detector"
  type        = map(list(string))
  default     = {}
}

variable "replication_state_aggregation_function" {
  description = "Aggregation function and group by for replication_state detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "replication_state_transformation_function" {
  description = "Transformation function for replication_state detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".max(over='5m')"
}

variable "replication_state_max_delay" {
  description = "Enforce max delay for replication_state detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "replication_state_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "replication_state_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "replication_state_disabled" {
  description = "Disable all alerting rules for replication_state detector"
  type        = bool
  default     = null
}

variable "replication_state_threshold_critical" {
  description = "Critical threshold for replication_state detector"
  type        = number
  default     = 1
}

variable "replication_state_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "replication_state_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
