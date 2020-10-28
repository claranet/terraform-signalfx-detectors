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
# wsrep_flow_control_paused detector

variable "wsrep_flow_control_paused_notifications" {
  description = "Notification recipients list per severity overridden for wsrep_flow_control_paused detector"
  type        = map(list(string))
  default     = {}
}

variable "wsrep_flow_control_paused_aggregation_function" {
  description = "Aggregation function and group by for wsrep_flow_control_paused detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "wsrep_flow_control_paused_transformation_function" {
  description = "Transformation function for wsrep_flow_control_paused detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "wsrep_flow_control_paused_disabled" {
  description = "Disable all alerting rules for wsrep_flow_control_paused detector"
  type        = bool
  default     = null
}

variable "wsrep_flow_control_paused_disabled_critical" {
  description = "Disable critical alerting rule for wsrep_flow_control_paused detector"
  type        = bool
  default     = null
}

variable "wsrep_flow_control_paused_disabled_major" {
  description = "Disable major alerting rule for wsrep_flow_control_paused detector"
  type        = bool
  default     = null
}

variable "wsrep_flow_control_paused_threshold_critical" {
  description = "Critical threshold for wsrep_flow_control_paused detector"
  type        = number
  default     = 1
}

variable "wsrep_flow_control_paused_threshold_major" {
  description = "Major threshold for wsrep_flow_control_paused detector"
  type        = number
  default     = 0
}

# wsrep_local_recv_queue_avg detector

variable "wsrep_local_recv_queue_avg_notifications" {
  description = "Notification recipients list per severity overridden for wsrep_local_recv_queue_avg detector"
  type        = map(list(string))
  default     = {}
}

variable "wsrep_local_recv_queue_avg_aggregation_function" {
  description = "Aggregation function and group by for wsrep_local_recv_queue_avg detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "wsrep_local_recv_queue_avg_transformation_function" {
  description = "Transformation function for wsrep_local_recv_queue_avg detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "wsrep_local_recv_queue_avg_disabled" {
  description = "Disable all alerting rules for wsrep_local_recv_queue_avg detector"
  type        = bool
  default     = null
}

variable "wsrep_local_recv_queue_avg_disabled_critical" {
  description = "Disable critical alerting rule for wsrep_local_recv_queue_avg detector"
  type        = bool
  default     = null
}

variable "wsrep_local_recv_queue_avg_disabled_major" {
  description = "Disable major alerting rule for wsrep_local_recv_queue_avg detector"
  type        = bool
  default     = null
}

variable "wsrep_local_recv_queue_avg_threshold_critical" {
  description = "Critical threshold for wsrep_local_recv_queue_avg detector"
  type        = number
  default     = 0.1
}

variable "wsrep_local_recv_queue_avg_threshold_major" {
  description = "Major threshold for wsrep_local_recv_queue_avg detector"
  type        = number
  default     = 0
}
