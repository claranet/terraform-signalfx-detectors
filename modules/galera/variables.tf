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

# wsrep_ready detector

variable "wsrep_ready_notifications" {
  description = "Notification recipients list per severity overridden for wsrep_ready detector"
  type        = map(list(string))
  default     = {}
}

variable "wsrep_ready_aggregation_function" {
  description = "Aggregation function and group by for wsrep_ready detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "wsrep_ready_transformation_function" {
  description = "Transformation function for wsrep_ready detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "wsrep_ready_disabled" {
  description = "Disable all alerting rules for wsrep_ready detector"
  type        = bool
  default     = null
}

variable "wsrep_ready_threshold_critical" {
  description = "Critical threshold for wsrep_ready detector"
  type        = number
  default     = 1
}

# wsrep_local_state detector

variable "wsrep_local_state_notifications" {
  description = "Notification recipients list per severity overridden for wsrep_local_state detector"
  type        = map(list(string))
  default     = {}
}

variable "wsrep_local_state_aggregation_function" {
  description = "Aggregation function and group by for wsrep_local_state detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "wsrep_local_state_transformation_function" {
  description = "Transformation function for wsrep_local_state detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "wsrep_local_state_disabled" {
  description = "Disable all alerting rules for wsrep_local_state detector"
  type        = bool
  default     = null
}

variable "wsrep_local_state_threshold_critical" {
  description = "Critical threshold for wsrep_local_state detector (see https://galeracluster.com/library/documentation/node-states.html#node-state-changes)"
  type        = number
  default     = 4
}
