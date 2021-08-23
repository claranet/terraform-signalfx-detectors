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
  default     = "20m"
}

# read_latency_99th_percentile detector

variable "read_latency_99th_percentile_notifications" {
  description = "Notification recipients list per severity overridden for read_latency_99th_percentile detector"
  type        = map(list(string))
  default     = {}
}

variable "read_latency_99th_percentile_aggregation_function" {
  description = "Aggregation function and group by for read_latency_99th_percentile detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "read_latency_99th_percentile_transformation_function" {
  description = "Transformation function for read_latency_99th_percentile detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='15m')"
}

variable "read_latency_99th_percentile_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "read_latency_99th_percentile_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "read_latency_99th_percentile_disabled" {
  description = "Disable all alerting rules for read_latency_99th_percentile detector"
  type        = bool
  default     = null
}

variable "read_latency_99th_percentile_disabled_critical" {
  description = "Disable critical alerting rule for read_latency_99th_percentile detector"
  type        = bool
  default     = null
}

variable "read_latency_99th_percentile_disabled_major" {
  description = "Disable major alerting rule for read_latency_99th_percentile detector"
  type        = bool
  default     = null
}

variable "read_latency_99th_percentile_threshold_critical" {
  description = "Critical threshold for read_latency_99th_percentile detector in s"
  type        = number
  default     = 2
}

variable "read_latency_99th_percentile_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "read_latency_99th_percentile_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "read_latency_99th_percentile_threshold_major" {
  description = "Major threshold for read_latency_99th_percentile detector in s"
  type        = number
  default     = 1
}

variable "read_latency_99th_percentile_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "read_latency_99th_percentile_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# write_latency_99th_percentile detector

variable "write_latency_99th_percentile_notifications" {
  description = "Notification recipients list per severity overridden for write_latency_99th_percentile detector"
  type        = map(list(string))
  default     = {}
}

variable "write_latency_99th_percentile_aggregation_function" {
  description = "Aggregation function and group by for write_latency_99th_percentile detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "write_latency_99th_percentile_transformation_function" {
  description = "Transformation function for write_latency_99th_percentile detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='15m')"
}

variable "write_latency_99th_percentile_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "write_latency_99th_percentile_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "write_latency_99th_percentile_disabled" {
  description = "Disable all alerting rules for write_latency_99th_percentile detector"
  type        = bool
  default     = null
}

variable "write_latency_99th_percentile_disabled_critical" {
  description = "Disable critical alerting rule for write_latency_99th_percentile detector"
  type        = bool
  default     = null
}

variable "write_latency_99th_percentile_disabled_major" {
  description = "Disable major alerting rule for write_latency_99th_percentile detector"
  type        = bool
  default     = null
}

variable "write_latency_99th_percentile_threshold_critical" {
  description = "Critical threshold for write_latency_99th_percentile detector in s"
  type        = number
  default     = 1
}

variable "write_latency_99th_percentile_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "write_latency_99th_percentile_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "write_latency_99th_percentile_threshold_major" {
  description = "Major threshold for write_latency_99th_percentile detector in s"
  type        = number
  default     = 0.5
}

variable "write_latency_99th_percentile_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "write_latency_99th_percentile_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# read_latency_real_time detector

variable "read_latency_real_time_notifications" {
  description = "Notification recipients list per severity overridden for read_latency_real_time detector"
  type        = map(list(string))
  default     = {}
}

variable "read_latency_real_time_aggregation_function" {
  description = "Aggregation function and group by for read_latency_real_time detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "read_latency_real_time_transformation_function" {
  description = "Transformation function for read_latency_real_time detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='15m')"
}

variable "read_latency_real_time_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "read_latency_real_time_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "read_latency_real_time_disabled" {
  description = "Disable all alerting rules for read_latency_real_time detector"
  type        = bool
  default     = null
}

variable "read_latency_real_time_disabled_critical" {
  description = "Disable critical alerting rule for read_latency_real_time detector"
  type        = bool
  default     = null
}

variable "read_latency_real_time_disabled_major" {
  description = "Disable major alerting rule for read_latency_real_time detector"
  type        = bool
  default     = null
}

variable "read_latency_real_time_threshold_critical" {
  description = "Critical threshold for read_latency_real_time detector in s"
  type        = number
  default     = 2
}

variable "read_latency_real_time_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "read_latency_real_time_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "read_latency_real_time_threshold_major" {
  description = "Major threshold for read_latency_real_time detector in s"
  type        = number
  default     = 1
}

variable "read_latency_real_time_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "read_latency_real_time_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# write_latency_real_time detector

variable "write_latency_real_time_notifications" {
  description = "Notification recipients list per severity overridden for write_latency_real_time detector"
  type        = map(list(string))
  default     = {}
}

variable "write_latency_real_time_aggregation_function" {
  description = "Aggregation function and group by for write_latency_real_time detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "write_latency_real_time_transformation_function" {
  description = "Transformation function for write_latency_real_time detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='15m')"
}

variable "write_latency_real_time_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "write_latency_real_time_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "write_latency_real_time_disabled" {
  description = "Disable all alerting rules for write_latency_real_time detector"
  type        = bool
  default     = null
}

variable "write_latency_real_time_disabled_critical" {
  description = "Disable critical alerting rule for write_latency_real_time detector"
  type        = bool
  default     = null
}

variable "write_latency_real_time_disabled_major" {
  description = "Disable major alerting rule for write_latency_real_time detector"
  type        = bool
  default     = null
}

variable "write_latency_real_time_threshold_critical" {
  description = "Critical threshold for write_latency_real_time detector in s"
  type        = number
  default     = 1
}

variable "write_latency_real_time_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "write_latency_real_time_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "write_latency_real_time_threshold_major" {
  description = "Major threshold for write_latency_real_time detector in s"
  type        = number
  default     = 0.5
}

variable "write_latency_real_time_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "write_latency_real_time_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# transactional_read_latency_99th_percentile detector

variable "transactional_read_latency_99th_percentile_notifications" {
  description = "Notification recipients list per severity overridden for transactional_read_latency_99th_percentile detector"
  type        = map(list(string))
  default     = {}
}

variable "transactional_read_latency_99th_percentile_aggregation_function" {
  description = "Aggregation function and group by for transactional_read_latency_99th_percentile detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "transactional_read_latency_99th_percentile_transformation_function" {
  description = "Transformation function for transactional_read_latency_99th_percentile detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='15m')"
}

variable "transactional_read_latency_99th_percentile_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "transactional_read_latency_99th_percentile_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "transactional_read_latency_99th_percentile_disabled" {
  description = "Disable all alerting rules for transactional_read_latency_99th_percentile detector"
  type        = bool
  default     = null
}

variable "transactional_read_latency_99th_percentile_disabled_critical" {
  description = "Disable critical alerting rule for transactional_read_latency_99th_percentile detector"
  type        = bool
  default     = null
}

variable "transactional_read_latency_99th_percentile_disabled_major" {
  description = "Disable major alerting rule for transactional_read_latency_99th_percentile detector"
  type        = bool
  default     = null
}

variable "transactional_read_latency_99th_percentile_threshold_critical" {
  description = "Critical threshold for transactional_read_latency_99th_percentile detector in s"
  type        = number
  default     = 2
}

variable "transactional_read_latency_99th_percentile_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "transactional_read_latency_99th_percentile_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "transactional_read_latency_99th_percentile_threshold_major" {
  description = "Major threshold for transactional_read_latency_99th_percentile detector in s"
  type        = number
  default     = 1
}

variable "transactional_read_latency_99th_percentile_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "transactional_read_latency_99th_percentile_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# transactional_write_latency_99th_percentile detector

variable "transactional_write_latency_99th_percentile_notifications" {
  description = "Notification recipients list per severity overridden for transactional_write_latency_99th_percentile detector"
  type        = map(list(string))
  default     = {}
}

variable "transactional_write_latency_99th_percentile_aggregation_function" {
  description = "Aggregation function and group by for transactional_write_latency_99th_percentile detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "transactional_write_latency_99th_percentile_transformation_function" {
  description = "Transformation function for transactional_write_latency_99th_percentile detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='15m')"
}

variable "transactional_write_latency_99th_percentile_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "transactional_write_latency_99th_percentile_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "transactional_write_latency_99th_percentile_disabled" {
  description = "Disable all alerting rules for transactional_write_latency_99th_percentile detector"
  type        = bool
  default     = null
}

variable "transactional_write_latency_99th_percentile_disabled_critical" {
  description = "Disable critical alerting rule for transactional_write_latency_99th_percentile detector"
  type        = bool
  default     = null
}

variable "transactional_write_latency_99th_percentile_disabled_major" {
  description = "Disable major alerting rule for transactional_write_latency_99th_percentile detector"
  type        = bool
  default     = null
}

variable "transactional_write_latency_99th_percentile_threshold_critical" {
  description = "Critical threshold for transactional_write_latency_99th_percentile detector in s"
  type        = number
  default     = 1
}

variable "transactional_write_latency_99th_percentile_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "transactional_write_latency_99th_percentile_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "transactional_write_latency_99th_percentile_threshold_major" {
  description = "Major threshold for transactional_write_latency_99th_percentile detector in s"
  type        = number
  default     = 0.5
}

variable "transactional_write_latency_99th_percentile_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "transactional_write_latency_99th_percentile_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# transactional_read_latency_real_time detector

variable "transactional_read_latency_real_time_notifications" {
  description = "Notification recipients list per severity overridden for transactional_read_latency_real_time detector"
  type        = map(list(string))
  default     = {}
}

variable "transactional_read_latency_real_time_aggregation_function" {
  description = "Aggregation function and group by for transactional_read_latency_real_time detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "transactional_read_latency_real_time_transformation_function" {
  description = "Transformation function for transactional_read_latency_real_time detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='15m')"
}

variable "transactional_read_latency_real_time_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "transactional_read_latency_real_time_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "transactional_read_latency_real_time_disabled" {
  description = "Disable all alerting rules for transactional_read_latency_real_time detector"
  type        = bool
  default     = null
}

variable "transactional_read_latency_real_time_disabled_critical" {
  description = "Disable critical alerting rule for transactional_read_latency_real_time detector"
  type        = bool
  default     = null
}

variable "transactional_read_latency_real_time_disabled_major" {
  description = "Disable major alerting rule for transactional_read_latency_real_time detector"
  type        = bool
  default     = null
}

variable "transactional_read_latency_real_time_threshold_critical" {
  description = "Critical threshold for transactional_read_latency_real_time detector in s"
  type        = number
  default     = 2
}

variable "transactional_read_latency_real_time_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "transactional_read_latency_real_time_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "transactional_read_latency_real_time_threshold_major" {
  description = "Major threshold for transactional_read_latency_real_time detector in s"
  type        = number
  default     = 1
}

variable "transactional_read_latency_real_time_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "transactional_read_latency_real_time_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# transactional_write_latency_real_time detector

variable "transactional_write_latency_real_time_notifications" {
  description = "Notification recipients list per severity overridden for transactional_write_latency_real_time detector"
  type        = map(list(string))
  default     = {}
}

variable "transactional_write_latency_real_time_aggregation_function" {
  description = "Aggregation function and group by for transactional_write_latency_real_time detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "transactional_write_latency_real_time_transformation_function" {
  description = "Transformation function for transactional_write_latency_real_time detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='15m')"
}

variable "transactional_write_latency_real_time_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "transactional_write_latency_real_time_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "transactional_write_latency_real_time_disabled" {
  description = "Disable all alerting rules for transactional_write_latency_real_time detector"
  type        = bool
  default     = null
}

variable "transactional_write_latency_real_time_disabled_critical" {
  description = "Disable critical alerting rule for transactional_write_latency_real_time detector"
  type        = bool
  default     = null
}

variable "transactional_write_latency_real_time_disabled_major" {
  description = "Disable major alerting rule for transactional_write_latency_real_time detector"
  type        = bool
  default     = null
}

variable "transactional_write_latency_real_time_threshold_critical" {
  description = "Critical threshold for transactional_write_latency_real_time detector in s"
  type        = number
  default     = 1
}

variable "transactional_write_latency_real_time_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "transactional_write_latency_real_time_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "transactional_write_latency_real_time_threshold_major" {
  description = "Major threshold for transactional_write_latency_real_time detector in s"
  type        = number
  default     = 0.5
}

variable "transactional_write_latency_real_time_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "transactional_write_latency_real_time_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# storage_exceptions_count detector

variable "storage_exceptions_count_notifications" {
  description = "Notification recipients list per severity overridden for storage_exceptions_count detector"
  type        = map(list(string))
  default     = {}
}

variable "storage_exceptions_count_aggregation_function" {
  description = "Aggregation function and group by for storage_exceptions_count detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "storage_exceptions_count_transformation_function" {
  description = "Transformation function for storage_exceptions_count detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='30m')"
}

variable "storage_exceptions_count_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "storage_exceptions_count_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "storage_exceptions_count_disabled" {
  description = "Disable all alerting rules for storage_exceptions_count detector"
  type        = bool
  default     = null
}

variable "storage_exceptions_count_threshold_major" {
  description = "Major threshold for storage_exceptions_count detector"
  type        = number
  default     = 0
}

variable "storage_exceptions_count_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "storage_exceptions_count_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
