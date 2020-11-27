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
  default     = ".mean(by=['QueueName'])"
}

# Visible_messages detectors

variable "visible_messages_disabled" {
  description = "Disable all alerting rules for visible_messages detector"
  type        = bool
  default     = true
}

variable "visible_messages_disabled_critical" {
  description = "Disable critical alerting rule for visible_messages detector"
  type        = bool
  default     = null
}

variable "visible_messages_disabled_major" {
  description = "Disable major alerting rule for visible_messages detector"
  type        = bool
  default     = null
}

variable "visible_messages_notifications" {
  description = "Notification recipients list per severity overridden for visible_messages detector"
  type        = map(list(string))
  default     = {}
}

variable "visible_messages_aggregation_function" {
  description = "Aggregation function and group by for visible_messages detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "visible_messages_transformation_function" {
  description = "Transformation function for visible_messages detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='30m')"
}

variable "visible_messages_threshold_critical" {
  description = "Critical threshold for visible_messages detector"
  type        = number
  default     = 2
}

variable "visible_messages_threshold_major" {
  description = "Major threshold for visible_messages detector"
  type        = number
  default     = 1
}

# Age_of_oldest_message detectors

variable "age_of_oldest_message_disabled" {
  description = "Disable all alerting rules for age_of_oldest_message detector"
  type        = bool
  default     = null
}

variable "age_of_oldest_message_disabled_critical" {
  description = "Disable critical alerting rule for age_of_oldest_message detector"
  type        = bool
  default     = null
}

variable "age_of_oldest_message_disabled_major" {
  description = "Disable major alerting rule for age_of_oldest_message detector"
  type        = bool
  default     = null
}

variable "age_of_oldest_message_notifications" {
  description = "Notification recipients list per severity overridden for age_of_oldest_message detector"
  type        = map(list(string))
  default     = {}
}

variable "age_of_oldest_message_aggregation_function" {
  description = "Aggregation function and group by for age_of_oldest_message detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "age_of_oldest_message_transformation_function" {
  description = "Transformation function for age_of_oldest_message detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='30m')"
}

variable "age_of_oldest_message_threshold_critical" {
  description = "Critical threshold for age_of_oldest_message detector"
  type        = number
  default     = 600
}

variable "age_of_oldest_message_threshold_major" {
  description = "Major threshold for age_of_oldest_message detector"
  type        = number
  default     = 300
}

