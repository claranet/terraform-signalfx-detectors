# Module specific

# Heartbeat detector

variable "heartbeat_disabled" {
  description = "Disable all alerting rules for heartbeat detector"
  type        = bool
  default     = null
}

variable "heartbeat_notifications" {
  description = "Notification recipients list per severity overridden for heartbeat detector"
  type        = map(list(string))
  default     = {}
}

variable "heartbeat_timeframe" {
  description = "Timeframe for heartbeat detector (i.e. \"10m\")"
  type        = string
  default     = "20m"
}

variable "heartbeat_aggregation_function" {
  description = "Aggregation function and group by for heartbeat detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['cluster'])"
}

# read_p99_latency detector

variable "read_p99_latency_disabled" {
  description = "Disable all alerting rules for read_p99_latency detector"
  type        = bool
  default     = null
}

variable "read_p99_latency_disabled_critical" {
  description = "Disable critical alerting rule for read_p99_latency detector"
  type        = bool
  default     = null
}

variable "read_p99_latency_disabled_major" {
  description = "Disable major alerting rule for read_p99_latency detector"
  type        = bool
  default     = null
}

variable "read_p99_latency_notifications" {
  description = "Notification recipients list per severity overridden for read_p99_latency detector"
  type        = map(list(string))
  default     = {}
}

variable "read_p99_latency_aggregation_function" {
  description = "Aggregation function and group by for read_p99_latency detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "read_p99_latency_transformation_function" {
  description = "Transformation function for read_p99_latency detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='15m')"
}

variable "read_p99_latency_threshold_critical" {
  description = "Critical threshold for read_p99_latency detector in ms"
  type        = number
  default     = 2000
}

variable "read_p99_latency_threshold_major" {
  description = "Major threshold for read_p99_latency detector in ms"
  type        = number
  default     = 1000
}

# write_p99_latency detector

variable "write_p99_latency_disabled" {
  description = "Disable all alerting rules for write_p99_latency detector"
  type        = bool
  default     = null
}

variable "write_p99_latency_disabled_critical" {
  description = "Disable critical alerting rule for write_p99_latency detector"
  type        = bool
  default     = null
}

variable "write_p99_latency_disabled_major" {
  description = "Disable major alerting rule for write_p99_latency detector"
  type        = bool
  default     = null
}

variable "write_p99_latency_notifications" {
  description = "Notification recipients list per severity overridden for write_p99_latency detector"
  type        = map(list(string))
  default     = {}
}

variable "write_p99_latency_aggregation_function" {
  description = "Aggregation function and group by for write_p99_latency detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "write_p99_latency_transformation_function" {
  description = "Transformation function for write_p99_latency detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='15m')"
}

variable "write_p99_latency_threshold_critical" {
  description = "Critical threshold for write_p99_latency detector in ms"
  type        = number
  default     = 1000
}

variable "write_p99_latency_threshold_major" {
  description = "Major threshold for write_p99_latency detector in ms"
  type        = number
  default     = 500
}

# read_real_time_latency detector

variable "read_real_time_latency_disabled" {
  description = "Disable all alerting rules for read_real_time_latency detector"
  type        = bool
  default     = null
}

variable "read_real_time_latency_disabled_critical" {
  description = "Disable critical alerting rule for read_real_time_latency detector"
  type        = bool
  default     = null
}

variable "read_real_time_latency_disabled_major" {
  description = "Disable major alerting rule for read_real_time_latency detector"
  type        = bool
  default     = null
}

variable "read_real_time_latency_notifications" {
  description = "Notification recipients list per severity overridden for read_real_time_latency detector"
  type        = map(list(string))
  default     = {}
}

variable "read_real_time_latency_aggregation_function" {
  description = "Aggregation function and group by for read_real_time_latency detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "read_real_time_latency_transformation_function" {
  description = "Transformation function for read_real_time_latency detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='15m')"
}

variable "read_real_time_latency_threshold_critical" {
  description = "Critical threshold for read_real_time_latency detector in ms"
  type        = number
  default     = 2000
}

variable "read_real_time_latency_threshold_major" {
  description = "Major threshold for read_real_time_latency detector in ms"
  type        = number
  default     = 1000
}

# write_real_time_latency detector

variable "write_real_time_latency_disabled" {
  description = "Disable all alerting rules for write_real_time_latency detector"
  type        = bool
  default     = null
}

variable "write_real_time_latency_disabled_critical" {
  description = "Disable critical alerting rule for write_real_time_latency detector"
  type        = bool
  default     = null
}

variable "write_real_time_latency_disabled_major" {
  description = "Disable major alerting rule for write_real_time_latency detector"
  type        = bool
  default     = null
}

variable "write_real_time_latency_notifications" {
  description = "Notification recipients list per severity overridden for write_real_time_latency detector"
  type        = map(list(string))
  default     = {}
}

variable "write_real_time_latency_aggregation_function" {
  description = "Aggregation function and group by for write_real_time_latency detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "write_real_time_latency_transformation_function" {
  description = "Transformation function for write_real_time_latency detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='15m')"
}

variable "write_real_time_latency_threshold_critical" {
  description = "Critical threshold for write_real_time_latency detector in ms"
  type        = number
  default     = 1000
}

variable "write_real_time_latency_threshold_major" {
  description = "Major threshold for write_real_time_latency detector in ms"
  type        = number
  default     = 500
}

# casread_p99_latency detector

variable "casread_p99_latency_disabled" {
  description = "Disable all alerting rules for casread_p99_latency detector"
  type        = bool
  default     = null
}

variable "casread_p99_latency_disabled_critical" {
  description = "Disable critical alerting rule for casread_p99_latency detector"
  type        = bool
  default     = null
}

variable "casread_p99_latency_disabled_major" {
  description = "Disable major alerting rule for casread_p99_latency detector"
  type        = bool
  default     = null
}

variable "casread_p99_latency_notifications" {
  description = "Notification recipients list per severity overridden for casread_p99_latency detector"
  type        = map(list(string))
  default     = {}
}

variable "casread_p99_latency_aggregation_function" {
  description = "Aggregation function and group by for casread_p99_latency detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "casread_p99_latency_transformation_function" {
  description = "Transformation function for casread_p99_latency detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='15m')"
}

variable "casread_p99_latency_threshold_critical" {
  description = "Critical threshold for casread_p99_latency detector in ms"
  type        = number
  default     = 2000
}

variable "casread_p99_latency_threshold_major" {
  description = "Major threshold for casread_p99_latency detector in ms"
  type        = number
  default     = 1000
}

# caswrite_p99_latency detector

variable "caswrite_p99_latency_disabled" {
  description = "Disable all alerting rules for caswrite_p99_latency detector"
  type        = bool
  default     = null
}

variable "caswrite_p99_latency_disabled_critical" {
  description = "Disable critical alerting rule for caswrite_p99_latency detector"
  type        = bool
  default     = null
}

variable "caswrite_p99_latency_disabled_major" {
  description = "Disable major alerting rule for caswrite_p99_latency detector"
  type        = bool
  default     = null
}

variable "caswrite_p99_latency_notifications" {
  description = "Notification recipients list per severity overridden for caswrite_p99_latency detector"
  type        = map(list(string))
  default     = {}
}

variable "caswrite_p99_latency_aggregation_function" {
  description = "Aggregation function and group by for caswrite_p99_latency detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "caswrite_p99_latency_transformation_function" {
  description = "Transformation function for caswrite_p99_latency detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='15m')"
}

variable "caswrite_p99_latency_threshold_critical" {
  description = "Critical threshold for caswrite_p99_latency detector in ms"
  type        = number
  default     = 1000
}

variable "caswrite_p99_latency_threshold_major" {
  description = "Major threshold for caswrite_p99_latency detector in ms"
  type        = number
  default     = 500
}

# casread_real_time_latency detector

variable "casread_real_time_latency_disabled" {
  description = "Disable all alerting rules for casread_real_time_latency detector"
  type        = bool
  default     = null
}

variable "casread_real_time_latency_disabled_critical" {
  description = "Disable critical alerting rule for casread_real_time_latency detector"
  type        = bool
  default     = null
}

variable "casread_real_time_latency_disabled_major" {
  description = "Disable major alerting rule for casread_real_time_latency detector"
  type        = bool
  default     = null
}

variable "casread_real_time_latency_notifications" {
  description = "Notification recipients list per severity overridden for casread_real_time_latency detector"
  type        = map(list(string))
  default     = {}
}

variable "casread_real_time_latency_aggregation_function" {
  description = "Aggregation function and group by for casread_real_time_latency detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "casread_real_time_latency_transformation_function" {
  description = "Transformation function for casread_real_time_latency detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='15m')"
}

variable "casread_real_time_latency_threshold_critical" {
  description = "Critical threshold for casread_real_time_latency detector in ms"
  type        = number
  default     = 2000
}

variable "casread_real_time_latency_threshold_major" {
  description = "Major threshold for casread_real_time_latency detector in ms"
  type        = number
  default     = 1000
}

# caswrite_real_time_latency detector

variable "caswrite_real_time_latency_disabled" {
  description = "Disable all alerting rules for caswrite_real_time_latency detector"
  type        = bool
  default     = null
}

variable "caswrite_real_time_latency_disabled_critical" {
  description = "Disable critical alerting rule for caswrite_real_time_latency detector"
  type        = bool
  default     = null
}

variable "caswrite_real_time_latency_disabled_major" {
  description = "Disable major alerting rule for caswrite_real_time_latency detector"
  type        = bool
  default     = null
}

variable "caswrite_real_time_latency_notifications" {
  description = "Notification recipients list per severity overridden for caswrite_real_time_latency detector"
  type        = map(list(string))
  default     = {}
}

variable "caswrite_real_time_latency_aggregation_function" {
  description = "Aggregation function and group by for caswrite_real_time_latency detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "caswrite_real_time_latency_transformation_function" {
  description = "Transformation function for caswrite_real_time_latency detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='15m')"
}

variable "caswrite_real_time_latency_threshold_critical" {
  description = "Critical threshold for caswrite_real_time_latency detector in ms"
  type        = number
  default     = 1000
}

variable "caswrite_real_time_latency_threshold_major" {
  description = "Major threshold for caswrite_real_time_latency detector in ms"
  type        = number
  default     = 500
}

# storage_exceptions detector

variable "storage_exceptions_disabled" {
  description = "Disable all alerting rules for storage_exceptions detector"
  type        = bool
  default     = null
}

variable "storage_exceptions_disabled_critical" {
  description = "Disable critical alerting rule for storage_exceptions detector"
  type        = bool
  default     = null
}

variable "storage_exceptions_disabled_major" {
  description = "Disable major alerting rule for storage_exceptions detector"
  type        = bool
  default     = null
}

variable "storage_exceptions_notifications" {
  description = "Notification recipients list per severity overridden for storage_exceptions detector"
  type        = map(list(string))
  default     = {}
}

variable "storage_exceptions_aggregation_function" {
  description = "Aggregation function and group by for storage_exceptions detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "storage_exceptions_transformation_function" {
  description = "Transformation function for storage_exceptions detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".max(over='30m')"
}

variable "storage_exceptions_threshold_major" {
  description = "Major threshold for storage_exceptions detector"
  type        = number
  default     = 0
}

