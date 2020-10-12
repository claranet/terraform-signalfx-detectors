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
  default     = ".mean(by=['LoadBalancer'])"
}

# No_healthy_instances detector

variable "no_healthy_instances_disabled" {
  description = "Disable all alerting rules for no_healthy_instances detector"
  type        = bool
  default     = null
}

variable "no_healthy_instances_disabled_critical" {
  description = "Disable critical alerting rule for no_healthy_instances detector"
  type        = bool
  default     = null
}

variable "no_healthy_instances_disabled_major" {
  description = "Disable major alerting rule for no_healthy_instances detector"
  type        = bool
  default     = null
}

variable "no_healthy_instances_notifications" {
  description = "Notification recipients list per severity overridden for no_healthy_instances detector"
  type        = map(list(string))
  default     = {}
}

variable "no_healthy_instances_aggregation_function" {
  description = "Aggregation function and group by for no_healthy_instances detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "no_healthy_instances_transformation_function" {
  description = "Transformation function for no_healthy_instances detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='5m')"
}

variable "no_healthy_instances_threshold_critical" {
  description = "Critical threshold for no_healthy_instances detector"
  type        = number
  default     = 1
}

variable "no_healthy_instances_threshold_major" {
  description = "Major threshold for no_healthy_instances detector"
  type        = number
  default     = 100
}

