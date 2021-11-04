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

# listener detector

variable "listener_notifications" {
  description = "Notification recipients list per severity overridden for listener detector"
  type        = map(list(string))
  default     = {}
}

variable "listener_aggregation_function" {
  description = "Aggregation function and group by for listener detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "listener_transformation_function" {
  description = "Transformation function for listener detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "listener_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = <<-EOF
    the listener process is not started, means that application can not connect to the database
EOF
}

variable "listener_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "listener_disabled" {
  description = "Disable all alerting rules for listener detector"
  type        = bool
  default     = null
}

variable "listener_threshold_critical" {
  description = "Critical threshold for listener detector"
  type        = number
  default     = 1
}

variable "listener_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "5m"
}

variable "listener_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# dbisdown detector

variable "dbisdown_notifications" {
  description = "Notification recipients list per severity overridden for dbisdown detector"
  type        = map(list(string))
  default     = {}
}

variable "dbisdown_aggregation_function" {
  description = "Aggregation function and group by for dbisdown detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "dbisdown_transformation_function" {
  description = "Transformation function for dbisdown detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "dbisdown_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = <<-EOF
    database is not started, check status on server and logfile
EOF
}

variable "dbisdown_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "dbisdown_disabled" {
  description = "Disable all alerting rules for dbisdown detector"
  type        = bool
  default     = null
}

variable "dbisdown_threshold_critical" {
  description = "Critical threshold for dbisdown detector"
  type        = number
  default     = 1
}

variable "dbisdown_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "5m"
}

variable "dbisdown_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# pdbisdown detector

variable "pdbisdown_notifications" {
  description = "Notification recipients list per severity overridden for pdbisdown detector"
  type        = map(list(string))
  default     = {}
}

variable "pdbisdown_aggregation_function" {
  description = "Aggregation function and group by for pdbisdown detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "pdbisdown_transformation_function" {
  description = "Transformation function for pdbisdown detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "pdbisdown_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = <<-EOF
    The pluggable database is not started, check the status from the container database which manage it
EOF
}

variable "pdbisdown_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "pdbisdown_disabled" {
  description = "Disable all alerting rules for pdbisdown detector"
  type        = bool
  default     = null
}

variable "pdbisdown_threshold_critical" {
  description = "Critical threshold for pdbisdown detector"
  type        = number
  default     = 0
}

variable "pdbisdown_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "5m"
}

variable "pdbisdown_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# blocking_sessions detector

variable "blocking_sessions_notifications" {
  description = "Notification recipients list per severity overridden for blocking_sessions detector"
  type        = map(list(string))
  default     = {}
}

variable "blocking_sessions_aggregation_function" {
  description = "Aggregation function and group by for blocking_sessions detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "blocking_sessions_transformation_function" {
  description = "Transformation function for blocking_sessions detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "blocking_sessions_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = <<-EOF
    One or more oracle session(s) are currently blocking, check sessions activity on oracle sid with oramenu or direct SQL
EOF
}

variable "blocking_sessions_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "blocking_sessions_disabled" {
  description = "Disable all alerting rules for blocking_sessions detector"
  type        = bool
  default     = null
}

variable "blocking_sessions_threshold_critical" {
  description = "Critical threshold for blocking_sessions detector"
  type        = number
  default     = 0
}

variable "blocking_sessions_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "5m"
}

variable "blocking_sessions_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# alertlogerror detector

variable "alertlogerror_notifications" {
  description = "Notification recipients list per severity overridden for alertlogerror detector"
  type        = map(list(string))
  default     = {}
}

variable "alertlogerror_aggregation_function" {
  description = "Aggregation function and group by for alertlogerror detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "alertlogerror_transformation_function" {
  description = "Transformation function for alertlogerror detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "alertlogerror_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "alertlogerror_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "alertlogerror_disabled" {
  description = "Disable all alerting rules for alertlogerror detector"
  type        = bool
  default     = null
}

variable "alertlogerror_threshold_critical" {
  description = "Critical threshold for alertlogerror detector"
  type        = number
  default     = 0
}

variable "alertlogerror_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "5m"
}

variable "alertlogerror_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# fra_usage detector

variable "fra_usage_notifications" {
  description = "Notification recipients list per severity overridden for fra_usage detector"
  type        = map(list(string))
  default     = {}
}

variable "fra_usage_aggregation_function" {
  description = "Aggregation function and group by for fra_usage detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "fra_usage_transformation_function" {
  description = "Transformation function for fra_usage detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "fra_usage_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "fra_usage_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "fra_usage_disabled" {
  description = "Disable all alerting rules for fra_usage detector"
  type        = bool
  default     = null
}

variable "fra_usage_disabled_warning" {
  description = "Disable warning alerting rule for fra_usage detector"
  type        = bool
  default     = null
}

variable "fra_usage_disabled_critical" {
  description = "Disable critical alerting rule for fra_usage detector"
  type        = bool
  default     = null
}

variable "fra_usage_threshold_warning" {
  description = "Warning threshold for fra_usage detector"
  type        = number
  default     = 85
}

variable "fra_usage_lasting_duration_warning" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "5m"
}

variable "fra_usage_at_least_percentage_warning" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "fra_usage_threshold_critical" {
  description = "Critical threshold for fra_usage detector"
  type        = number
  default     = 96
}

variable "fra_usage_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "5m"
}

variable "fra_usage_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# sessions_limits detector

variable "sessions_limits_notifications" {
  description = "Notification recipients list per severity overridden for sessions_limits detector"
  type        = map(list(string))
  default     = {}
}

variable "sessions_limits_aggregation_function" {
  description = "Aggregation function and group by for sessions_limits detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "sessions_limits_transformation_function" {
  description = "Transformation function for sessions_limits detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "sessions_limits_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "sessions_limits_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "sessions_limits_disabled" {
  description = "Disable all alerting rules for sessions_limits detector"
  type        = bool
  default     = null
}

variable "sessions_limits_disabled_warning" {
  description = "Disable warning alerting rule for sessions_limits detector"
  type        = bool
  default     = null
}

variable "sessions_limits_disabled_critical" {
  description = "Disable critical alerting rule for sessions_limits detector"
  type        = bool
  default     = null
}

variable "sessions_limits_threshold_warning" {
  description = "Warning threshold for sessions_limits detector"
  type        = number
  default     = 85
}

variable "sessions_limits_lasting_duration_warning" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "5m"
}

variable "sessions_limits_at_least_percentage_warning" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "sessions_limits_threshold_critical" {
  description = "Critical threshold for sessions_limits detector"
  type        = number
  default     = 96
}

variable "sessions_limits_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "5m"
}

variable "sessions_limits_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# process_limits detector

variable "process_limits_notifications" {
  description = "Notification recipients list per severity overridden for process_limits detector"
  type        = map(list(string))
  default     = {}
}

variable "process_limits_aggregation_function" {
  description = "Aggregation function and group by for process_limits detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "process_limits_transformation_function" {
  description = "Transformation function for process_limits detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "process_limits_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "process_limits_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "process_limits_disabled" {
  description = "Disable all alerting rules for process_limits detector"
  type        = bool
  default     = null
}

variable "process_limits_disabled_warning" {
  description = "Disable warning alerting rule for process_limits detector"
  type        = bool
  default     = null
}

variable "process_limits_disabled_critical" {
  description = "Disable critical alerting rule for process_limits detector"
  type        = bool
  default     = null
}

variable "process_limits_threshold_warning" {
  description = "Warning threshold for process_limits detector"
  type        = number
  default     = 85
}

variable "process_limits_lasting_duration_warning" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "5m"
}

variable "process_limits_at_least_percentage_warning" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "process_limits_threshold_critical" {
  description = "Critical threshold for process_limits detector"
  type        = number
  default     = 96
}

variable "process_limits_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "5m"
}

variable "process_limits_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# stby_replication detector

variable "stby_replication_notifications" {
  description = "Notification recipients list per severity overridden for stby_replication detector"
  type        = map(list(string))
  default     = {}
}

variable "stby_replication_aggregation_function" {
  description = "Aggregation function and group by for stby_replication detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "stby_replication_transformation_function" {
  description = "Transformation function for stby_replication detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "stby_replication_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = <<-EOF
    GAP is detected on standby replication, check primary last sequence and standby. Also check logfiles
EOF
}

variable "stby_replication_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "stby_replication_disabled" {
  description = "Disable all alerting rules for stby_replication detector"
  type        = bool
  default     = null
}

variable "stby_replication_threshold_critical" {
  description = "Critical threshold for stby_replication detector"
  type        = number
  default     = 0
}

variable "stby_replication_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "5m"
}

variable "stby_replication_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# oracledb_export detector

variable "oracledb_export_notifications" {
  description = "Notification recipients list per severity overridden for oracledb_export detector"
  type        = map(list(string))
  default     = {}
}

variable "oracledb_export_aggregation_function" {
  description = "Aggregation function and group by for oracledb_export detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "oracledb_export_transformation_function" {
  description = "Transformation function for oracledb_export detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "oracledb_export_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "oracledb_export_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "oracledb_export_disabled" {
  description = "Disable all alerting rules for oracledb_export detector"
  type        = bool
  default     = null
}

variable "oracledb_export_threshold_critical" {
  description = "Critical threshold for oracledb_export detector"
  type        = number
  default     = 0
}

variable "oracledb_export_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "5m"
}

variable "oracledb_export_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# oracle_rman_incr detector

variable "oracle_rman_incr_notifications" {
  description = "Notification recipients list per severity overridden for oracle_rman_incr detector"
  type        = map(list(string))
  default     = {}
}

variable "oracle_rman_incr_aggregation_function" {
  description = "Aggregation function and group by for oracle_rman_incr detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "oracle_rman_incr_transformation_function" {
  description = "Transformation function for oracle_rman_incr detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "oracle_rman_incr_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = <<-EOF
    Last rman incremental backup is ko, check logfiles
EOF
}

variable "oracle_rman_incr_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "oracle_rman_incr_disabled" {
  description = "Disable all alerting rules for oracle_rman_incr detector"
  type        = bool
  default     = null
}

variable "oracle_rman_incr_threshold_critical" {
  description = "Critical threshold for oracle_rman_incr detector"
  type        = number
  default     = 0
}

variable "oracle_rman_incr_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "60m"
}

variable "oracle_rman_incr_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# oracle_rman_arch detector

variable "oracle_rman_arch_notifications" {
  description = "Notification recipients list per severity overridden for oracle_rman_arch detector"
  type        = map(list(string))
  default     = {}
}

variable "oracle_rman_arch_aggregation_function" {
  description = "Aggregation function and group by for oracle_rman_arch detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "oracle_rman_arch_transformation_function" {
  description = "Transformation function for oracle_rman_arch detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "oracle_rman_arch_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = <<-EOF
    Last rman archivelog backup is ko, check logfiles
EOF
}

variable "oracle_rman_arch_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "oracle_rman_arch_disabled" {
  description = "Disable all alerting rules for oracle_rman_arch detector"
  type        = bool
  default     = null
}

variable "oracle_rman_arch_threshold_critical" {
  description = "Critical threshold for oracle_rman_arch detector"
  type        = number
  default     = 0
}

variable "oracle_rman_arch_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "60m"
}

variable "oracle_rman_arch_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# user_expiration detector

variable "user_expiration_notifications" {
  description = "Notification recipients list per severity overridden for user_expiration detector"
  type        = map(list(string))
  default     = {}
}

variable "user_expiration_aggregation_function" {
  description = "Aggregation function and group by for user_expiration detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "user_expiration_transformation_function" {
  description = "Transformation function for user_expiration detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "user_expiration_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = <<-EOF
    One or more oracle user will expire in next 15 days
EOF
}

variable "user_expiration_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "user_expiration_disabled" {
  description = "Disable all alerting rules for user_expiration detector"
  type        = bool
  default     = null
}

variable "user_expiration_threshold_critical" {
  description = "Critical threshold for user_expiration detector"
  type        = number
  default     = 0
}

variable "user_expiration_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "60m"
}

variable "user_expiration_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# tablespace_cdb detector

variable "tablespace_cdb_notifications" {
  description = "Notification recipients list per severity overridden for tablespace_cdb detector"
  type        = map(list(string))
  default     = {}
}

variable "tablespace_cdb_aggregation_function" {
  description = "Aggregation function and group by for tablespace_cdb detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "tablespace_cdb_transformation_function" {
  description = "Transformation function for tablespace_cdb detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "tablespace_cdb_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "tablespace_cdb_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "tablespace_cdb_disabled" {
  description = "Disable all alerting rules for tablespace_cdb detector"
  type        = bool
  default     = null
}

variable "tablespace_cdb_threshold_critical" {
  description = "Critical threshold for tablespace_cdb detector"
  type        = number
  default     = 90
}

variable "tablespace_cdb_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "15m"
}

variable "tablespace_cdb_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# tablespace_pdb detector

variable "tablespace_pdb_notifications" {
  description = "Notification recipients list per severity overridden for tablespace_pdb detector"
  type        = map(list(string))
  default     = {}
}

variable "tablespace_pdb_aggregation_function" {
  description = "Aggregation function and group by for tablespace_pdb detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "tablespace_pdb_transformation_function" {
  description = "Transformation function for tablespace_pdb detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "tablespace_pdb_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "tablespace_pdb_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "tablespace_pdb_disabled" {
  description = "Disable all alerting rules for tablespace_pdb detector"
  type        = bool
  default     = null
}

variable "tablespace_pdb_threshold_critical" {
  description = "Critical threshold for tablespace_pdb detector"
  type        = number
  default     = 90
}

variable "tablespace_pdb_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "15m"
}

variable "tablespace_pdb_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# tablespace_single detector

variable "tablespace_single_notifications" {
  description = "Notification recipients list per severity overridden for tablespace_single detector"
  type        = map(list(string))
  default     = {}
}

variable "tablespace_single_aggregation_function" {
  description = "Aggregation function and group by for tablespace_single detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "tablespace_single_transformation_function" {
  description = "Transformation function for tablespace_single detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "tablespace_single_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "tablespace_single_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "tablespace_single_disabled" {
  description = "Disable all alerting rules for tablespace_single detector"
  type        = bool
  default     = null
}

variable "tablespace_single_threshold_critical" {
  description = "Critical threshold for tablespace_single detector"
  type        = number
  default     = 90
}

variable "tablespace_single_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "15m"
}

variable "tablespace_single_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# dbvagent detector

variable "dbvagent_notifications" {
  description = "Notification recipients list per severity overridden for dbvagent detector"
  type        = map(list(string))
  default     = {}
}

variable "dbvagent_aggregation_function" {
  description = "Aggregation function and group by for dbvagent detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "dbvagent_transformation_function" {
  description = "Transformation function for dbvagent detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "dbvagent_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "dbvagent_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "dbvagent_disabled" {
  description = "Disable all alerting rules for dbvagent detector"
  type        = bool
  default     = null
}

variable "dbvagent_threshold_critical" {
  description = "Critical threshold for dbvagent detector"
  type        = number
  default     = 1
}

variable "dbvagent_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "5m"
}

variable "dbvagent_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# dbvnet detector

variable "dbvnet_notifications" {
  description = "Notification recipients list per severity overridden for dbvnet detector"
  type        = map(list(string))
  default     = {}
}

variable "dbvnet_aggregation_function" {
  description = "Aggregation function and group by for dbvnet detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "dbvnet_transformation_function" {
  description = "Transformation function for dbvnet detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "dbvnet_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "dbvnet_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "dbvnet_disabled" {
  description = "Disable all alerting rules for dbvnet detector"
  type        = bool
  default     = null
}

variable "dbvnet_threshold_critical" {
  description = "Critical threshold for dbvnet detector"
  type        = number
  default     = 1
}

variable "dbvnet_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "5m"
}

variable "dbvnet_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# dbvctl detector

variable "dbvctl_notifications" {
  description = "Notification recipients list per severity overridden for dbvctl detector"
  type        = map(list(string))
  default     = {}
}

variable "dbvctl_aggregation_function" {
  description = "Aggregation function and group by for dbvctl detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "dbvctl_transformation_function" {
  description = "Transformation function for dbvctl detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "dbvctl_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = <<-EOF
    standby replication is not working
EOF
}

variable "dbvctl_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "dbvctl_disabled" {
  description = "Disable all alerting rules for dbvctl detector"
  type        = bool
  default     = null
}

variable "dbvctl_threshold_critical" {
  description = "Critical threshold for dbvctl detector"
  type        = number
  default     = 1
}

variable "dbvctl_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "5m"
}

variable "dbvctl_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
