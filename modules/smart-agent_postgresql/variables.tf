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

# deadlocks detector

variable "deadlocks_disabled" {
  description = "Disable all alerting rules for deadlocks detector"
  type        = bool
  default     = null
}

variable "deadlocks_disabled_minor" {
  description = "Disable minor alerting rule for deadlocks detector"
  type        = bool
  default     = null
}

variable "deadlocks_disabled_major" {
  description = "Disable major alerting rule for deadlocks detector"
  type        = bool
  default     = null
}

variable "deadlocks_notifications" {
  description = "Notification recipients list per severity overridden for deadlocks detector"
  type        = map(list(string))
  default     = {}
}

variable "deadlocks_aggregation_function" {
  description = "Aggregation function and group by for deadlocks detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "deadlocks_transformation_function" {
  description = "Transformation function for deadlocks detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".max(over='5m')"
}

variable "deadlocks_threshold_minor" {
  description = "minor threshold for deadlocks detector"
  type        = number
  default     = 0
}

variable "deadlocks_threshold_major" {
  description = "Major threshold for deadlocks detector"
  type        = number
  default     = 0.1
}

# hit_ratio detector

variable "hit_ratio_disabled" {
  description = "Disable all alerting rules for hit_ratio detector"
  type        = bool
  default     = null
}

variable "hit_ratio_disabled_warning" {
  description = "Disable warning alerting rule for hit_ratio detector"
  type        = bool
  default     = null
}

variable "hit_ratio_disabled_minor" {
  description = "Disable minor alerting rule for hit_ratio detector"
  type        = bool
  default     = null
}

variable "hit_ratio_notifications" {
  description = "Notification recipients list per severity overridden for hit_ratio detector"
  type        = map(list(string))
  default     = {}
}

variable "hit_ratio_aggregation_function" {
  description = "Aggregation function and group by for hit_ratio detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "hit_ratio_transformation_function" {
  description = "Transformation function for hit_ratio detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".max(over='1h')"
}

variable "hit_ratio_threshold_warning" {
  description = "warning threshold for hit_ratio detector"
  type        = number
  default     = 50
}

variable "hit_ratio_threshold_minor" {
  description = "Minor threshold for hit_ratio detector"
  type        = number
  default     = 75
}

# rollbacks detector

variable "rollbacks_disabled" {
  description = "Disable all alerting rules for rollbacks detector"
  type        = bool
  default     = null
}

variable "rollbacks_disabled_major" {
  description = "Disable major alerting rule for rollbacks detector"
  type        = bool
  default     = null
}

variable "rollbacks_disabled_minor" {
  description = "Disable minor alerting rule for rollbacks detector"
  type        = bool
  default     = null
}

variable "rollbacks_notifications" {
  description = "Notification recipients list per severity overridden for rollbacks detector"
  type        = map(list(string))
  default     = {}
}

variable "rollbacks_aggregation_function" {
  description = "Aggregation function and group by for rollbacks detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "rollbacks_transformation_function" {
  description = "Transformation function for rollbacks detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='10m')"
}

variable "rollbacks_threshold_major" {
  description = "Major threshold for rollbacks detector"
  type        = number
  default     = 20
}

variable "rollbacks_threshold_minor" {
  description = "Minor threshold for rollbacks detector"
  type        = number
  default     = 10
}

# conflicts detector

variable "conflicts_disabled" {
  description = "Disable all alerting rules for conflicts detector"
  type        = bool
  default     = null
}

variable "conflicts_disabled_minor" {
  description = "Disable minor alerting rule for conflicts detector"
  type        = bool
  default     = null
}

variable "conflicts_disabled_major" {
  description = "Disable major alerting rule for conflicts detector"
  type        = bool
  default     = null
}

variable "conflicts_notifications" {
  description = "Notification recipients list per severity overridden for conflicts detector"
  type        = map(list(string))
  default     = {}
}

variable "conflicts_aggregation_function" {
  description = "Aggregation function and group by for conflicts detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "conflicts_transformation_function" {
  description = "Transformation function for conflicts detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".max(over='5m')"
}

variable "conflicts_threshold_minor" {
  description = "minor threshold for conflicts detector"
  type        = number
  default     = 0
}

variable "conflicts_threshold_major" {
  description = "major threshold for conflicts detector"
  type        = number
  default     = 1
}

# max_connections detector

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
  default     = ".min(over='1m')"
}

variable "max_connections_threshold_critical" {
  description = "Critical threshold for max_connections detector"
  type        = number
  default     = 90
}

variable "max_connections_threshold_major" {
  description = "Major threshold for max_connections detector"
  type        = number
  default     = 80
}

# replication_lag detector

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
  default     = ".min(over='5m')"
}

variable "replication_lag_threshold_critical" {
  description = "Critical threshold for replication_lag detector"
  type        = number
  default     = 200
}

variable "replication_lag_threshold_major" {
  description = "Major threshold for replication_lag detector"
  type        = number
  default     = 100
}

# replication_state detector

variable "replication_state_disabled" {
  description = "Disable all alerting rules for replication_state detector"
  type        = bool
  default     = null
}

variable "replication_state_notifications" {
  description = "Notification recipients list per severity overridden for replication_state detector"
  type        = map(list(string))
  default     = {}
}

variable "replication_state_aggregation_function" {
  description = "Aggregation function and group by for replication_state detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "replication_state_transformation_function" {
  description = "Transformation function for replication_state detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".max(over='5m')"
}

