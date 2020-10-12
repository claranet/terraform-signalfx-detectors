# Module specific

variable "gcp_project_id" {
  description = "GCP project id used for default filtering while lables are not synced"
  type        = string
}

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

# Oldest_unacked_message detector

variable "oldest_unacked_message_disabled" {
  description = "Disable all alerting rules for oldest_unacked_message detector"
  type        = bool
  default     = null
}

variable "oldest_unacked_message_disabled_critical" {
  description = "Disable critical alerting rule for oldest_unacked_message detector"
  type        = bool
  default     = null
}

variable "oldest_unacked_message_disabled_major" {
  description = "Disable major alerting rule for oldest_unacked_message detector"
  type        = bool
  default     = null
}

variable "oldest_unacked_message_notifications" {
  description = "Notification recipients list per severity overridden for oldest_unacked_message detector"
  type        = map(list(string))
  default     = {}
}

variable "oldest_unacked_message_aggregation_function" {
  description = "Aggregation function and group by for oldest_unacked_message detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "oldest_unacked_message_transformation_function" {
  description = "Transformation function for oldest_unacked_message detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='5m')"
}

variable "oldest_unacked_message_threshold_critical" {
  description = "Critical threshold for oldest_unacked_message detector"
  type        = number
  default     = 120
}

variable "oldest_unacked_message_threshold_major" {
  description = "Major threshold for oldest_unacked_message detector"
  type        = number
  default     = 30
}

# Push_latency detector

variable "push_latency_disabled" {
  description = "Disable all alerting rules for push_latency detector"
  type        = bool
  default     = null
}

variable "push_latency_disabled_critical" {
  description = "Disable critical alerting rule for push_latency detector"
  type        = bool
  default     = null
}

variable "push_latency_disabled_major" {
  description = "Disable major alerting rule for push_latency detector"
  type        = bool
  default     = null
}

variable "push_latency_notifications" {
  description = "Notification recipients list per severity overridden for push_latency detector"
  type        = map(list(string))
  default     = {}
}

variable "push_latency_aggregation_function" {
  description = "Aggregation function and group by for push_latency detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "push_latency_transformation_function" {
  description = "Transformation function for push_latency detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='15m')"
}

variable "push_latency_threshold_critical" {
  description = "Critical threshold for push_latency detector"
  type        = number
  default     = 5000000
}

variable "push_latency_threshold_major" {
  description = "Major threshold for push_latency detector"
  type        = number
  default     = 1000000
}

