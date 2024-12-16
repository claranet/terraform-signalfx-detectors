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

variable "heartbeat_timeframe" {
  description = "Timeframe for heartbeat detector (i.e. \"25m\")."
  type        = string
  default     = "25m"
}

# connection_state detector

variable "connection_state_notifications" {
  description = "Notification recipients list per severity overridden for connection_state detector"
  type        = map(list(string))
  default     = {}
}

variable "connection_state_aggregation_function" {
  description = "Aggregation function and group by for connection_state detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "connection_state_transformation_function" {
  description = "Transformation function for connection_state detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "connection_state_max_delay" {
  description = "Enforce max delay for connection_state detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "connection_state_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "connection_state_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "connection_state_disabled" {
  description = "Disable all alerting rules for connection_state detector"
  type        = bool
  default     = null
}

variable "connection_state_threshold_critical" {
  description = "Critical threshold for connection_state detector in state"
  type        = number
  default     = 0
}

variable "connection_state_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "connection_state_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# virtual_interface_traffic detector

variable "virtual_interface_traffic_notifications" {
  description = "Notification recipients list per severity overridden for virtual_interface_traffic detector"
  type        = map(list(string))
  default     = {}
}

variable "virtual_interface_traffic_aggregation_function" {
  description = "Aggregation function and group by for virtual_interface_traffic detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "virtual_interface_traffic_transformation_function" {
  description = "Transformation function for virtual_interface_traffic detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "virtual_interface_traffic_max_delay" {
  description = "Enforce max delay for virtual_interface_traffic detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "virtual_interface_traffic_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "virtual_interface_traffic_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "virtual_interface_traffic_disabled" {
  description = "Disable all alerting rules for virtual_interface_traffic detector"
  type        = bool
  default     = null
}

variable "virtual_interface_traffic_threshold_critical" {
  description = "Critical threshold for virtual_interface_traffic detector in bytes"
  type        = number
  default     = 0
}

variable "virtual_interface_traffic_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "virtual_interface_traffic_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
