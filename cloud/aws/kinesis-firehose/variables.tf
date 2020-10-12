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
  default     = ".mean(by=['StreamName'])"
}

# incoming_records detector

variable "incoming_records_disabled" {
  description = "Disable all alerting rules for incoming_records detector"
  type        = bool
  default     = null
}

variable "incoming_records_disabled_critical" {
  description = "Disable critical alerting rule for incoming_records detector"
  type        = bool
  default     = null
}

variable "incoming_records_disabled_major" {
  description = "Disable major alerting rule for incoming_records detector"
  type        = bool
  default     = null
}

variable "incoming_records_notifications" {
  description = "Notification recipients list per severity overridden for incoming_records detector"
  type        = map(list(string))
  default     = {}
}

variable "incoming_records_aggregation_function" {
  description = "Aggregation function and group by for incoming_records detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "incoming_records_transformation_function" {
  description = "Transformation function for incoming_records detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".sum(over='15m')"
}

variable "incoming_records_threshold_critical" {
  description = "Critical threshold for incoming_records detector"
  type        = number
  default     = 0
}

variable "incoming_records_threshold_major" {
  description = "Major threshold for incoming_records detector"
  type        = number
  default     = 1
}

