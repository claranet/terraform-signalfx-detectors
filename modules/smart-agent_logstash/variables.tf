# Events in
variable "events_in_metric_name" {
  description = "Metric name for input events"
  type        = string
  default     = "node.stats.events.events.in"
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

variable "events_in_high_disabled_critical" {
  description = "Disable critical alerting rule for events_in_high detector"
  type        = bool
  default     = null
}

variable "events_in_high_disabled_major" {
  description = "Disable major alerting rule for events_in_high detector"
  type        = bool
  default     = null
}

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
  default     = ".mean(over='5m')"
}

variable "events_in_high_threshold_critical" {
  description = "Critical threshold for events_in_high detector"
  type        = number
  default     = 30000
}

variable "events_in_high_threshold_critical_lasting" {
  description = "Critical threshold lasing for events_in_high detector"
  type        = string
  default     = "5m"
}

variable "events_in_high_threshold_major" {
  description = "Major threshold for events_in_high detector"
  type        = number
  default     = 25000
}

variable "events_in_high_threshold_major_lasting" {
  description = "Major threshold lasting for events_in_high detector"
  type        = string
  default     = "10m"
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

variable "events_in_low_disabled_critical" {
  description = "Disable critical alerting rule for events_in_low detector"
  type        = bool
  default     = null
}

variable "events_in_low_disabled_major" {
  description = "Disable major alerting rule for events_in_low detector"
  type        = bool
  default     = null
}

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
  default     = ".mean(over='5m')"
}

variable "events_in_low_threshold_critical" {
  description = "Critical threshold for events_in_low detector"
  type        = number
  default     = 0
}

variable "events_in_low_threshold_critical_lasting" {
  description = "Critical threshold lasting for events_in_low detector"
  type        = string
  default     = "5m"
}

variable "events_in_low_threshold_major" {
  description = "Major threshold for events_in_low detector"
  type        = number
  default     = 10
}

variable "events_in_low_threshold_major_lasting" {
  description = "Major threshold lasting for events_in_low detector"
  type        = string
  default     = "10m"
}

# Events out
variable "events_out_metric_name" {
  description = "Metric name for input events"
  type        = string
  default     = "node.stats.events.events.out"
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

variable "events_out_high_disabled_critical" {
  description = "Disable critical alerting rule for events_out_high detector"
  type        = bool
  default     = null
}

variable "events_out_high_disabled_major" {
  description = "Disable major alerting rule for events_out_high detector"
  type        = bool
  default     = null
}

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
  default     = ".mean(over='5m')"
}

variable "events_out_high_threshold_critical" {
  description = "Critical threshold for events_out_high detector"
  type        = number
  default     = 30000
}

variable "events_out_high_threshold_critical_lasting" {
  description = "Critical threshold lasting for events_out_high detector"
  type        = string
  default     = "5m"
}

variable "events_out_high_threshold_major" {
  description = "Major threshold for events_out_high detector"
  type        = number
  default     = 25000
}

variable "events_out_high_threshold_major_lasting" {
  description = "Major threshold lasting for events_out_high detector"
  type        = string
  default     = "5m"
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

variable "events_out_low_disabled_critical" {
  description = "Disable critical alerting rule for events_out_low detector"
  type        = bool
  default     = null
}

variable "events_out_low_disabled_major" {
  description = "Disable major alerting rule for events_out_low detector"
  type        = bool
  default     = null
}

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
  default     = ".mean(over='5m')"
}

variable "events_out_low_threshold_critical" {
  description = "Critical threshold for events_out_low detector"
  type        = number
  default     = 0
}

variable "events_out_low_threshold_critical_lasting" {
  description = "Critical threshold lasting for events_out_low detector"
  type        = string
  default     = "5m"
}

variable "events_out_low_threshold_major" {
  description = "Major threshold for events_out_low detector"
  type        = number
  default     = 10
}

variable "events_out_low_threshold_major_lasting" {
  description = "Major threshold lasting for events_out_low detector"
  type        = string
  default     = "10m"
}

# CPU usage
variable "cpu_usage_percent_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "cpu_usage_percent_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "cpu_usage_percent_disabled" {
  description = "Disable all alerting rules for cpu_usage_percent detector"
  type        = bool
  default     = null
}

variable "cpu_usage_percent_disabled_critical" {
  description = "Disable critical alerting rule for cpu_usage_percent detector"
  type        = bool
  default     = null
}

variable "cpu_usage_percent_disabled_major" {
  description = "Disable major alerting rule for cpu_usage_percent detector"
  type        = bool
  default     = null
}

variable "cpu_usage_percent_notifications" {
  description = "Notification recipients list per severity overridden for cpu_usage_percent detector"
  type        = map(list(string))
  default     = {}
}

variable "cpu_usage_percent_aggregation_function" {
  description = "Aggregation function and group by for cpu_usage_percent detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "cpu_usage_percent_transformation_function" {
  description = "Transformation function for cpu_usage_percent detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".mean(over='5m')"
}

variable "cpu_usage_percent_threshold_critical" {
  description = "Critical threshold for cpu_usage_percent detector"
  type        = number
  default     = 100
}

variable "cpu_usage_percent_threshold_critical_lasting" {
  description = "Critical threshold lasting for cpu_usage_percent detector"
  type        = string
  default     = "5m"
}

variable "cpu_usage_percent_threshold_major" {
  description = "Major threshold for cpu_usage_percent detector"
  type        = number
  default     = 90
}

variable "cpu_usage_percent_threshold_major_lasting" {
  description = "Major threshold lasting for cpu_usage_percent detector"
  type        = string
  default     = "10m"
}

# Queued events
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

variable "queued_events_disabled_critical" {
  description = "Disable critical alerting rule for queued_events detector"
  type        = bool
  default     = null
}

variable "queued_events_disabled_major" {
  description = "Disable major alerting rule for queued_events detector"
  type        = bool
  default     = null
}

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
  default     = ".mean(over='5m')"
}

variable "queued_events_threshold_critical" {
  description = "Critical threshold for queued_events detector"
  type        = number
  default     = 2000000
}

variable "queued_events_threshold_critical_lasting" {
  description = "Critical threshold lasting for queued_events detector"
  type        = string
  default     = "10m"
}

variable "queued_events_threshold_major" {
  description = "Major threshold for queued_events detector"
  type        = number
  default     = 1000000
}

variable "queued_events_threshold_major_lasting" {
  description = "Major threshold lasting for queued_events detector"
  type        = string
  default     = "10m"
}

# Queued disk
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

variable "queued_disk_disabled_critical" {
  description = "Disable critical alerting rule for queued_disk detector"
  type        = bool
  default     = null
}

variable "queued_disk_disabled_major" {
  description = "Disable major alerting rule for queued_disk detector"
  type        = bool
  default     = null
}

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
  default     = ".mean(over='5m')"
}

variable "queued_disk_threshold_critical" {
  description = "Critical threshold for queued_disk detector"
  type        = number
  default     = 10000000000
}

variable "queued_disk_threshold_critical_lasting" {
  description = "Critical threshold lasting for queued_disk detector"
  type        = string
  default     = "10m"
}

variable "queued_disk_threshold_major" {
  description = "Major threshold for queued_disk detector"
  type        = number
  default     = 8000000000
}

variable "queued_disk_threshold_major_lasting" {
  description = "Major threshold lasting for queued_disk detector"
  type        = string
  default     = "10m"
}

