# Global

variable "environment" {
  description = "Infrastructure environment"
  type        = string
}

# SignalFx module specific

variable "notifications" {
  description = "Notification recipients list for every detectors"
  type        = list
}

variable "prefixes" {
  description = "Prefixes list to prepend between brackets on every monitors names before environment"
  type        = list
  default     = []
}

variable "filter_custom_includes" {
  description = "List of tags to include when custom filtering is used"
  type        = list
  default     = []
}

variable "filter_custom_excludes" {
  description = "List of tags to exclude when custom filtering is used"
  type        = list
  default     = []
}

variable "detectors_disabled" {
  description = "Disable all detectors in this module"
  type        = bool
  default     = false
}

# MongoDB detectors specific

variable "heartbeat_disabled" {
  description = "Disable all alerting rules for heartbeat detector"
  type        = bool
  default     = null
}

variable "heartbeat_notifications" {
  description = "Notification recipients list for every alerting rules of heartbeat detector"
  type        = list
  default     = []
}

variable "heartbeat_timeframe" {
  description = "Timeframe for system not reporting detector (i.e. \"10m\")"
  type        = string
  default     = "20m"
}


# Mongodb_primary detectors

variable "mongodb_primary_disabled" {
  description = "Disable all alerting rules for mongodb_replication detector"
  type        = bool
  default     = null
}

variable "mongodb_primary_disabled_critical" {
  description = "Disable critical alerting rule for mongodb_replication detector"
  type        = bool
  default     = null
}

variable "mongodb_primary_notifications" {
  description = "Notification recipients list for every alerting rules of mongodb_replication detector"
  type        = list
  default     = []
}

variable "mongodb_primary_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of mongodb_replication detector"
  type        = list
  default     = []
}

variable "mongodb_primary_aggregation_function" {
  description = "Aggregation function and group by for mongodb_replication detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "mongodb_primary_transformation_function" {
  description = "Transformation function for mongodb_replication detector (mean, min, max)"
  type        = string
  default     = "mean"
}

variable "mongodb_primary_transformation_window" {
  description = "Transformation window for mongodb_replication detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "1m"
}

variable "mongodb_primary_threshold_critical" {
  description = "Critical threshold for mongodb_replication detector"
  type        = number
  default     = 2
}

# Mongodb_secondary detectors

variable "mongodb_secondary_disabled" {
  description = "Disable all alerting rules for mongodb_replication detector"
  type        = bool
  default     = null
}

variable "mongodb_secondary_disabled_critical" {
  description = "Disable critical alerting rule for mongodb_replication detector"
  type        = bool
  default     = null
}

variable "mongodb_secondary_disabled_warning" {
  description = "Disable warning alerting rule for mongodb_replication detector"
  type        = bool
  default     = null
}

variable "mongodb_secondary_notifications" {
  description = "Notification recipients list for every alerting rules of mongodb_replication detector"
  type        = list
  default     = []
}

variable "mongodb_secondary_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of mongodb_replication detector"
  type        = list
  default     = []
}

variable "mongodb_secondary_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of mongodb_replication detector"
  type        = list
  default     = []
}

variable "mongodb_secondary_aggregation_function" {
  description = "Aggregation function and group by for mongodb_replication detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "mongodb_secondary_transformation_function" {
  description = "Transformation function for mongodb_replication detector (mean, min, max)"
  type        = string
  default     = "mean"
}

variable "mongodb_secondary_transformation_window" {
  description = "Transformation window for mongodb_replication detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "1m"
}

variable "mongodb_secondary_threshold_critical" {
  description = "Critical threshold for mongodb_replication detector"
  type        = number
  default     = 0
}

variable "mongodb_secondary_threshold_warning" {
  description = "Warning threshold for mongodb_replication detector"
  type        = number
  default     = 1
}

# Mongodb_server_count detectors

variable "mongodb_server_count_disabled" {
  description = "Disable all alerting rules for mongodb_replication detector"
  type        = bool
  default     = null
}

variable "mongodb_server_count_disabled_critical" {
  description = "Disable critical alerting rule for mongodb_replication detector"
  type        = bool
  default     = null
}

variable "mongodb_server_count_disabled_warning" {
  description = "Disable warning alerting rule for mongodb_replication detector"
  type        = bool
  default     = null
}

variable "mongodb_server_count_notifications" {
  description = "Notification recipients list for every alerting rules of mongodb_replication detector"
  type        = list
  default     = []
}

variable "mongodb_server_count_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of mongodb_replication detector"
  type        = list
  default     = []
}

variable "mongodb_server_count_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of mongodb_replication detector"
  type        = list
  default     = []
}

variable "mongodb_server_count_aggregation_function" {
  description = "Aggregation function and group by for mongodb_replication detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "mongodb_server_count_transformation_function" {
  description = "Transformation function for mongodb_replication detector (mean, min, max)"
  type        = string
  default     = "mean"
}

variable "mongodb_server_count_transformation_window" {
  description = "Transformation window for mongodb_replication detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "1m"
}

variable "mongodb_server_count_threshold_critical" {
  description = "Critical threshold for mongodb_replication detector"
  type        = number
  default     = 99
}

variable "mongodb_server_count_threshold_warning" {
  description = "Warning threshold for mongodb_replication detector"
  type        = number
  default     = 3
}


# Mongodb_replication detectors

variable "mongodb_replication_disabled" {
  description = "Disable all alerting rules for mongodb_replication detector"
  type        = bool
  default     = null
}

variable "mongodb_replication_disabled_critical" {
  description = "Disable critical alerting rule for mongodb_replication detector"
  type        = bool
  default     = null
}

variable "mongodb_replication_disabled_warning" {
  description = "Disable warning alerting rule for mongodb_replication detector"
  type        = bool
  default     = null
}

variable "mongodb_replication_notifications" {
  description = "Notification recipients list for every alerting rules of mongodb_replication detector"
  type        = list
  default     = []
}

variable "mongodb_replication_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of mongodb_replication detector"
  type        = list
  default     = []
}

variable "mongodb_replication_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of mongodb_replication detector"
  type        = list
  default     = []
}

variable "mongodb_replication_aggregation_function" {
  description = "Aggregation function and group by for mongodb_replication detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "mongodb_replication_transformation_function" {
  description = "Transformation function for mongodb_replication detector (mean, min, max)"
  type        = string
  default     = "mean"
}

variable "mongodb_replication_transformation_window" {
  description = "Transformation window for mongodb_replication detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "1m"
}

variable "mongodb_replication_threshold_critical" {
  description = "Critical threshold for mongodb_replication detector"
  type        = number
  default     = 5
}

variable "mongodb_replication_threshold_warning" {
  description = "Warning threshold for mongodb_replication detector"
  type        = number
  default     = 2
}
