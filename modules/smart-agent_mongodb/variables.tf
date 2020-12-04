# heartbeat detector

variable "heartbeat_notifications" {
  description = "Notification recipients list per severity overridden for heartbeat detector"
  type        = map(list(string))
  default     = {}
}

variable "heartbeat_aggregation_function" {
  description = "Aggregation function and group by for heartbeat detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['cluster'])"
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

# page_faults detector

variable "page_faults_notifications" {
  description = "Notification recipients list per severity overridden for page_faults detector"
  type        = map(list(string))
  default     = {}
}

variable "page_faults_aggregation_function" {
  description = "Aggregation function and group by for page_faults detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "page_faults_transformation_function" {
  description = "Transformation function for page_faults detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".mean(over='5m')"
}

variable "page_faults_disabled" {
  description = "Disable all alerting rules for page_faults detector"
  type        = bool
  default     = null
}

variable "page_faults_threshold_warning" {
  description = "Warning threshold for page_faults detector"
  type        = number
  default     = 0
}

# max_connections detector

variable "max_connections_notifications" {
  description = "Notification recipients list per severity overridden for max_connections detector"
  type        = map(list(string))
  default     = {}
}

variable "max_connections_aggregation_function" {
  description = "Aggregation function and group by for max_connections detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "max_connections_transformation_function" {
  description = "Transformation function for max_connections detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".mean(over='5m')"
}

variable "max_connections_disabled" {
  description = "Disable all alerting rules for max_connections detector"
  type        = bool
  default     = null
}

variable "max_connections_disabled_critical" {
  description = "Disable critical alerting rule for max_connections detector"
  type        = bool
  default     = null
}

variable "max_connections_disabled_major" {
  description = "Disable major alerting rule for max_connections detector"
  type        = bool
  default     = null
}

variable "max_connections_threshold_critical" {
  description = "Critical threshold for max_connections detector"
  type        = number
  default     = 90
}

variable "max_connections_threshold_major" {
  description = "Major threshold for max_connections detector"
  type        = number
  default     = 75
}


# asserts detector

variable "asserts_notifications" {
  description = "Notification recipients list per severity overridden for asserts detector"
  type        = map(list(string))
  default     = {}
}

variable "asserts_aggregation_function" {
  description = "Aggregation function and group by for asserts detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "asserts_transformation_function" {
  description = "Transformation function for asserts detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".max(over='30m')"
}

variable "asserts_disabled" {
  description = "Disable all alerting rules for asserts detector"
  type        = bool
  default     = null
}

variable "asserts_threshold_minor" {
  description = "Minor threshold for asserts detector"
  type        = number
  default     = 0
}

# primary detector

variable "primary_notifications" {
  description = "Notification recipients list per severity overridden for primary detector"
  type        = map(list(string))
  default     = {}
}

variable "primary_aggregation_function" {
  description = "Aggregation function and group by for primary detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".max(by=['cluster'])"
}

variable "primary_transformation_function" {
  description = "Transformation function for primary detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='1m')"
}

variable "primary_disabled" {
  description = "Disable all alerting rules for primary detector"
  type        = bool
  default     = null
}

variable "primary_threshold_critical" {
  description = "Critical threshold for primary detector"
  type        = number
  default     = 1
}

# secondary detector

variable "secondary_notifications" {
  description = "Notification recipients list per severity overridden for secondary detector"
  type        = map(list(string))
  default     = {}
}

variable "secondary_aggregation_function" {
  description = "Aggregation function and group by for secondary detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".max(by=['cluster'])"
}

variable "secondary_transformation_function" {
  description = "Transformation function for secondary detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='5m')"
}

variable "secondary_disabled" {
  description = "Disable all alerting rules for secondary detector"
  type        = bool
  default     = null
}

variable "secondary_threshold_critical" {
  description = "Critical threshold for secondary detector"
  type        = number
  default     = 2
}

# replication_lag detector

variable "replication_lag_notifications" {
  description = "Notification recipients list per severity overridden for replication_lag detector"
  type        = map(list(string))
  default     = {}
}

variable "replication_lag_aggregation_function" {
  description = "Aggregation function and group by for replication_lag detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "replication_lag_transformation_function" {
  description = "Transformation function for replication_lag detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".mean(over='15m')"
}

variable "replication_lag_disabled" {
  description = "Disable all alerting rules for replication_lag detector"
  type        = bool
  default     = null
}

variable "replication_lag_disabled_critical" {
  description = "Disable critical alerting rule for replication_lag detector"
  type        = bool
  default     = null
}

variable "replication_lag_disabled_major" {
  description = "Disable major alerting rule for replication_lag detector"
  type        = bool
  default     = null
}

variable "replication_lag_threshold_critical" {
  description = "Critical threshold for replication_lag detector"
  type        = number
  default     = 10
}

variable "replication_lag_threshold_major" {
  description = "Major threshold for replication_lag detector"
  type        = number
  default     = 3
}


