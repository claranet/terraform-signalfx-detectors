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

# zookeeper_health detector

variable "zookeeper_health_notifications" {
  description = "Notification recipients list per severity overridden for zookeeper_health detector"
  type        = map(list(string))
  default     = {}
}

variable "zookeeper_health_aggregation_function" {
  description = "Aggregation function and group by for zookeeper_health detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "zookeeper_health_transformation_function" {
  description = "Transformation function for zookeeper_health detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".mean(over='5m')"
}

variable "zookeeper_health_max_delay" {
  description = "Enforce max delay for zookeeper_health detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "zookeeper_health_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "zookeeper_health_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "zookeeper_health_disabled" {
  description = "Disable all alerting rules for zookeeper_health detector"
  type        = bool
  default     = null
}

variable "zookeeper_health_threshold_critical" {
  description = "Critical threshold for zookeeper_health detector"
  type        = number
  default     = 1
}

variable "zookeeper_health_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "zookeeper_health_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# zookeeper_latency detector

variable "zookeeper_latency_notifications" {
  description = "Notification recipients list per severity overridden for zookeeper_latency detector"
  type        = map(list(string))
  default     = {}
}

variable "zookeeper_latency_aggregation_function" {
  description = "Aggregation function and group by for zookeeper_latency detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "zookeeper_latency_transformation_function" {
  description = "Transformation function for zookeeper_latency detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".mean(over='5m')"
}

variable "zookeeper_latency_max_delay" {
  description = "Enforce max delay for zookeeper_latency detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "zookeeper_latency_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "zookeeper_latency_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "zookeeper_latency_disabled" {
  description = "Disable all alerting rules for zookeeper_latency detector"
  type        = bool
  default     = null
}

variable "zookeeper_latency_disabled_critical" {
  description = "Disable critical alerting rule for zookeeper_latency detector"
  type        = bool
  default     = null
}

variable "zookeeper_latency_disabled_major" {
  description = "Disable major alerting rule for zookeeper_latency detector"
  type        = bool
  default     = null
}

variable "zookeeper_latency_threshold_critical" {
  description = "Critical threshold for zookeeper_latency detector"
  type        = number
  default     = 300000
}

variable "zookeeper_latency_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "zookeeper_latency_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "zookeeper_latency_threshold_major" {
  description = "Major threshold for zookeeper_latency detector"
  type        = number
  default     = 250000
}

variable "zookeeper_latency_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "zookeeper_latency_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# file_descriptors detector

variable "file_descriptors_notifications" {
  description = "Notification recipients list per severity overridden for file_descriptors detector"
  type        = map(list(string))
  default     = {}
}

variable "file_descriptors_aggregation_function" {
  description = "Aggregation function and group by for file_descriptors detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "file_descriptors_transformation_function" {
  description = "Transformation function for file_descriptors detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".max(over='15m')"
}

variable "file_descriptors_max_delay" {
  description = "Enforce max delay for file_descriptors detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "file_descriptors_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "file_descriptors_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "file_descriptors_disabled" {
  description = "Disable all alerting rules for file_descriptors detector"
  type        = bool
  default     = null
}

variable "file_descriptors_disabled_critical" {
  description = "Disable critical alerting rule for file_descriptors detector"
  type        = bool
  default     = null
}

variable "file_descriptors_disabled_major" {
  description = "Disable major alerting rule for file_descriptors detector"
  type        = bool
  default     = null
}

variable "file_descriptors_threshold_critical" {
  description = "Critical threshold for file_descriptors detector"
  type        = number
  default     = 95
}

variable "file_descriptors_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "file_descriptors_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "file_descriptors_threshold_major" {
  description = "Major threshold for file_descriptors detector"
  type        = number
  default     = 90
}

variable "file_descriptors_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "file_descriptors_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
