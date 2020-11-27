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
  default     = ""
}

# process_state detector

variable "process_state_disabled" {
  description = "Disable all alerting rules for process state detector"
  type        = bool
  default     = null
}

variable "process_state_disabled_critical" {
  description = "Disable critical alerting rule for process state detector"
  type        = bool
  default     = null
}

variable "process_state_disabled_major" {
  description = "Disable major alerting rule for process state detector"
  type        = bool
  default     = null
}

variable "process_state_notifications" {
  description = "Notification recipients list per severity overridden for process state detector"
  type        = map(list(string))
  default     = {}
}

variable "process_state_aggregation_function" {
  description = "Aggregation function and group by for process state detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "process_state_transformation_function" {
  description = "Transformation function for process state detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='10m')"
}

variable "process_state_threshold_critical" {
  description = "Critical threshold for process state detector, see http://supervisord.org/subprocess.html#process-states)"
  type        = number
  default     = 20
}

variable "process_state_threshold_major" {
  description = "Major threshold for process state detector (default to be less then 20 (process has been stopped manually or is starting), see http://supervisord.org/subprocess.html#process-states "
  type        = number
  default     = 20
}

