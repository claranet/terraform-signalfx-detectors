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
  default     = ".mean(by=['DBInstanceIdentifier'])"
}

# CPU_90_15min detector

variable "cpu_90_15min_disabled" {
  description = "Disable all alerting rules for cpu_90_15min detector"
  type        = bool
  default     = null
}

variable "cpu_90_15min_disabled_critical" {
  description = "Disable critical alerting rule for cpu_90_15min detector"
  type        = bool
  default     = null
}

variable "cpu_90_15min_disabled_major" {
  description = "Disable major alerting rule for cpu_90_15min detector"
  type        = bool
  default     = null
}

variable "cpu_90_15min_notifications" {
  description = "Notification recipients list per severity overridden for cpu_90_15min detector"
  type        = map(list(string))
  default     = {}
}

variable "cpu_90_15min_aggregation_function" {
  description = "Aggregation function and group by for cpu_90_15min detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "cpu_90_15min_transformation_function" {
  description = "Transformation function for cpu_90_15min detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='15m')"
}

variable "cpu_90_15min_threshold_critical" {
  description = "Critical threshold for cpu_90_15min detector"
  type        = number
  default     = 90
}

variable "cpu_90_15min_threshold_major" {
  description = "Major threshold for cpu_90_15min detector"
  type        = number
  default     = 80
}

# Free_space_low detector

variable "free_space_low_disabled" {
  description = "Disable all alerting rules for free_space_low detector"
  type        = bool
  default     = null
}

variable "free_space_low_disabled_critical" {
  description = "Disable critical alerting rule for free_space_low detector"
  type        = bool
  default     = null
}

variable "free_space_low_disabled_major" {
  description = "Disable major alerting rule for free_space_low detector"
  type        = bool
  default     = null
}

variable "free_space_low_notifications" {
  description = "Notification recipients list per severity overridden for free_space_low detector"
  type        = map(list(string))
  default     = {}
}

variable "free_space_low_aggregation_function" {
  description = "Aggregation function and group by for free_space_low detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "free_space_low_transformation_function" {
  description = "Transformation function for free_space_low detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='15m')"
}

variable "free_space_low_threshold_critical" {
  description = "Critical threshold for free_space_low detector"
  type        = number
  default     = 20
}

variable "free_space_low_threshold_major" {
  description = "Major threshold for free_space_low detector"
  type        = number
  default     = 40
}

# Replica_lag detector

variable "replica_lag_disabled" {
  description = "Disable all alerting rules for replica_lag detector"
  type        = bool
  default     = null
}

variable "replica_lag_disabled_critical" {
  description = "Disable critical alerting rule for replica_lag detector"
  type        = bool
  default     = null
}

variable "replica_lag_disabled_major" {
  description = "Disable major alerting rule for replica_lag detector"
  type        = bool
  default     = null
}

variable "replica_lag_notifications" {
  description = "Notification recipients list per severity overridden for replica_lag detector"
  type        = map(list(string))
  default     = {}
}

variable "replica_lag_aggregation_function" {
  description = "Aggregation function and group by for replica_lag detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "replica_lag_transformation_function" {
  description = "Transformation function for replica_lag detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='5m')"
}

variable "replica_lag_threshold_critical" {
  description = "Critical threshold for replica_lag detector"
  type        = number
  default     = 300
}

variable "replica_lag_threshold_major" {
  description = "Major threshold for replica_lag detector"
  type        = number
  default     = 200
}

