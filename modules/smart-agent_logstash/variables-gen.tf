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

# events_in_high detector

variable "events_in_high_notifications" {
  description = "Notification recipients list per severity overridden for events_in_high detector"
  type        = map(list(string))
  default     = {}
}

variable "events_in_high_aggregation_function" {
  description = "Aggregation function and group by for events_in_high detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "events_in_high_transformation_function" {
  description = "Transformation function for events_in_high detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='10m')"
}

variable "events_in_high_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "events_in_high_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "events_in_high_disabled" {
  description = "Disable all alerting rules for events_in_high detector"
  type        = bool
  default     = null
}

variable "events_in_high_disabled_warning" {
  description = "Disable warning alerting rule for events_in_high detector"
  type        = bool
  default     = null
}

variable "events_in_high_disabled_minor" {
  description = "Disable minor alerting rule for events_in_high detector"
  type        = bool
  default     = null
}

variable "events_in_high_threshold_warning" {
  description = "Warning threshold for events_in_high detector"
  type        = number
  default     = 25000
}

variable "events_in_high_lasting_duration_warning" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "events_in_high_at_least_percentage_warning" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "events_in_high_threshold_minor" {
  description = "Minor threshold for events_in_high detector"
  type        = number
  default     = 30000
}

variable "events_in_high_lasting_duration_minor" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "events_in_high_at_least_percentage_minor" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# events_in_low detector

variable "events_in_low_notifications" {
  description = "Notification recipients list per severity overridden for events_in_low detector"
  type        = map(list(string))
  default     = {}
}

variable "events_in_low_aggregation_function" {
  description = "Aggregation function and group by for events_in_low detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "events_in_low_transformation_function" {
  description = "Transformation function for events_in_low detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='10m')"
}

variable "events_in_low_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "events_in_low_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "events_in_low_disabled" {
  description = "Disable all alerting rules for events_in_low detector"
  type        = bool
  default     = null
}

variable "events_in_low_disabled_warning" {
  description = "Disable warning alerting rule for events_in_low detector"
  type        = bool
  default     = null
}

variable "events_in_low_disabled_minor" {
  description = "Disable minor alerting rule for events_in_low detector"
  type        = bool
  default     = null
}

variable "events_in_low_threshold_warning" {
  description = "Warning threshold for events_in_low detector"
  type        = number
  default     = 100
}

variable "events_in_low_lasting_duration_warning" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "events_in_low_at_least_percentage_warning" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "events_in_low_threshold_minor" {
  description = "Minor threshold for events_in_low detector"
  type        = number
  default     = 0
}

variable "events_in_low_lasting_duration_minor" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "events_in_low_at_least_percentage_minor" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# events_out_high detector

variable "events_out_high_notifications" {
  description = "Notification recipients list per severity overridden for events_out_high detector"
  type        = map(list(string))
  default     = {}
}

variable "events_out_high_aggregation_function" {
  description = "Aggregation function and group by for events_out_high detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "events_out_high_transformation_function" {
  description = "Transformation function for events_out_high detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='10m')"
}

variable "events_out_high_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "events_out_high_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "events_out_high_disabled" {
  description = "Disable all alerting rules for events_out_high detector"
  type        = bool
  default     = null
}

variable "events_out_high_disabled_warning" {
  description = "Disable warning alerting rule for events_out_high detector"
  type        = bool
  default     = null
}

variable "events_out_high_disabled_minor" {
  description = "Disable minor alerting rule for events_out_high detector"
  type        = bool
  default     = null
}

variable "events_out_high_threshold_warning" {
  description = "Warning threshold for events_out_high detector"
  type        = number
  default     = 25000
}

variable "events_out_high_lasting_duration_warning" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "events_out_high_at_least_percentage_warning" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "events_out_high_threshold_minor" {
  description = "Minor threshold for events_out_high detector"
  type        = number
  default     = 30000
}

variable "events_out_high_lasting_duration_minor" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "events_out_high_at_least_percentage_minor" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# events_out_low detector

variable "events_out_low_notifications" {
  description = "Notification recipients list per severity overridden for events_out_low detector"
  type        = map(list(string))
  default     = {}
}

variable "events_out_low_aggregation_function" {
  description = "Aggregation function and group by for events_out_low detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "events_out_low_transformation_function" {
  description = "Transformation function for events_out_low detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='10m')"
}

variable "events_out_low_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "events_out_low_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "events_out_low_disabled" {
  description = "Disable all alerting rules for events_out_low detector"
  type        = bool
  default     = null
}

variable "events_out_low_disabled_warning" {
  description = "Disable warning alerting rule for events_out_low detector"
  type        = bool
  default     = null
}

variable "events_out_low_disabled_minor" {
  description = "Disable minor alerting rule for events_out_low detector"
  type        = bool
  default     = null
}

variable "events_out_low_threshold_warning" {
  description = "Warning threshold for events_out_low detector"
  type        = number
  default     = 100
}

variable "events_out_low_lasting_duration_warning" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "events_out_low_at_least_percentage_warning" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "events_out_low_threshold_minor" {
  description = "Minor threshold for events_out_low detector"
  type        = number
  default     = 0
}

variable "events_out_low_lasting_duration_minor" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "events_out_low_at_least_percentage_minor" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# cpu_percent detector

variable "cpu_percent_notifications" {
  description = "Notification recipients list per severity overridden for cpu_percent detector"
  type        = map(list(string))
  default     = {}
}

variable "cpu_percent_aggregation_function" {
  description = "Aggregation function and group by for cpu_percent detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "cpu_percent_transformation_function" {
  description = "Transformation function for cpu_percent detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='10m')"
}

variable "cpu_percent_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "cpu_percent_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "cpu_percent_disabled" {
  description = "Disable all alerting rules for cpu_percent detector"
  type        = bool
  default     = null
}

variable "cpu_percent_disabled_warning" {
  description = "Disable warning alerting rule for cpu_percent detector"
  type        = bool
  default     = null
}

variable "cpu_percent_disabled_minor" {
  description = "Disable minor alerting rule for cpu_percent detector"
  type        = bool
  default     = null
}

variable "cpu_percent_threshold_warning" {
  description = "Warning threshold for cpu_percent detector"
  type        = number
  default     = 90
}

variable "cpu_percent_lasting_duration_warning" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "cpu_percent_at_least_percentage_warning" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "cpu_percent_threshold_minor" {
  description = "Minor threshold for cpu_percent detector"
  type        = number
  default     = 100
}

variable "cpu_percent_lasting_duration_minor" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "cpu_percent_at_least_percentage_minor" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# queued_events detector

variable "queued_events_notifications" {
  description = "Notification recipients list per severity overridden for queued_events detector"
  type        = map(list(string))
  default     = {}
}

variable "queued_events_aggregation_function" {
  description = "Aggregation function and group by for queued_events detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "queued_events_transformation_function" {
  description = "Transformation function for queued_events detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='10m')"
}

variable "queued_events_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "queued_events_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "queued_events_disabled" {
  description = "Disable all alerting rules for queued_events detector"
  type        = bool
  default     = null
}

variable "queued_events_disabled_warning" {
  description = "Disable warning alerting rule for queued_events detector"
  type        = bool
  default     = null
}

variable "queued_events_disabled_minor" {
  description = "Disable minor alerting rule for queued_events detector"
  type        = bool
  default     = null
}

variable "queued_events_threshold_warning" {
  description = "Warning threshold for queued_events detector"
  type        = number
  default     = 1000000
}

variable "queued_events_lasting_duration_warning" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "queued_events_at_least_percentage_warning" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "queued_events_threshold_minor" {
  description = "Minor threshold for queued_events detector"
  type        = number
  default     = 2000000
}

variable "queued_events_lasting_duration_minor" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "queued_events_at_least_percentage_minor" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# queued_disk detector

variable "queued_disk_notifications" {
  description = "Notification recipients list per severity overridden for queued_disk detector"
  type        = map(list(string))
  default     = {}
}

variable "queued_disk_aggregation_function" {
  description = "Aggregation function and group by for queued_disk detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "queued_disk_transformation_function" {
  description = "Transformation function for queued_disk detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='10m')"
}

variable "queued_disk_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "queued_disk_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "queued_disk_disabled" {
  description = "Disable all alerting rules for queued_disk detector"
  type        = bool
  default     = null
}

variable "queued_disk_disabled_warning" {
  description = "Disable warning alerting rule for queued_disk detector"
  type        = bool
  default     = null
}

variable "queued_disk_disabled_minor" {
  description = "Disable minor alerting rule for queued_disk detector"
  type        = bool
  default     = null
}

variable "queued_disk_threshold_warning" {
  description = "Warning threshold for queued_disk detector"
  type        = number
  default     = 8000
}

variable "queued_disk_lasting_duration_warning" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "queued_disk_at_least_percentage_warning" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "queued_disk_threshold_minor" {
  description = "Minor threshold for queued_disk detector"
  type        = number
  default     = 10000
}

variable "queued_disk_lasting_duration_minor" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "queued_disk_at_least_percentage_minor" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
