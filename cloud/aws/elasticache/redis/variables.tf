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

# AWS ElastiCache detectors specific

# Cache_hits detectors

variable "cache_hits_disabled" {
  description = "Disable all alerting rules for cache_hits detector"
  type        = bool
  default     = null
}

variable "cache_hits_disabled_critical" {
  description = "Disable critical alerting rule for cache_hits detector"
  type        = bool
  default     = null
}

variable "cache_hits_disabled_warning" {
  description = "Disable warning alerting rule for cache_hits detector"
  type        = bool
  default     = null
}

variable "cache_hits_notifications" {
  description = "Notification recipients list for every alerting rules of cache_hits detector"
  type        = list
  default     = []
}

variable "cache_hits_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of cache_hits detector"
  type        = list
  default     = []
}

variable "cache_hits_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of cache_hits detector"
  type        = list
  default     = []
}

variable "cache_hits_aggregation_function" {
  description = "Aggregation function and group by for elb_4xx detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "cache_hits_transformation_function" {
  description = "Transformation function for elb_4xx detector (i.e. \".mean(over='5m')\"))"
  type        = string
  default     = ""
}

variable "cache_hits_lasting_duration_seconds" {
  description = "Minimum duration that conditions must be true before raising alert (in seconds)"
  type        = number
  default     = 300
}

variable "cache_hits_at_least_percentage" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 0.9
}

variable "cache_hits_threshold_critical" {
  description = "Critical threshold for cache_hits detector"
  type        = number
  default     = 60
}

variable "cache_hits_threshold_warning" {
  description = "Warning threshold for cache_hits detector"
  type        = number
  default     = 80
}

# cpu_high detectors

variable "cpu_high_disabled" {
  description = "Disable all alerting rules for cpu_high detector"
  type        = bool
  default     = null
}

variable "cpu_high_disabled_critical" {
  description = "Disable critical alerting rule for cpu_high detector"
  type        = bool
  default     = null
}

variable "cpu_high_disabled_warning" {
  description = "Disable warning alerting rule for httpcode 5xx erros detector"
  type        = bool
  default     = null
}

variable "cpu_high_notifications" {
  description = "Notification recipients list for every alerting rules of cpu_high detector"
  type        = list
  default     = []
}

variable "cpu_high_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of cpu_high detector"
  type        = list
  default     = []
}

variable "cpu_high_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of cpu_high detector"
  type        = list
  default     = []
}

variable "cpu_high_aggregation_function" {
  description = "Aggregation function and group by for cpu_high detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "cpu_high_transformation_function" {
  description = "Transformation function for cpu_high detector (i.e. \".mean(over='5m')\"))"
  type        = string
  default     = ".min(over='15m')"
}

variable "cpu_high_threshold_critical" {
  description = "Critical threshold for cpu_high detector"
  type        = number
  default     = 90
}

variable "cpu_high_threshold_warning" {
  description = "Warning threshold for cpu_high detector"
  type        = number
  default     = 75
}

# Replication_lag detectors

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

variable "replication_lag_disabled_warning" {
  description = "Disable warning alerting rule for replication_lag detector"
  type        = bool
  default     = null
}

variable "replication_lag_notifications" {
  description = "Notification recipients list for every alerting rules of replication_lag detector"
  type        = list
  default     = []
}

variable "replication_lag_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of replication_lag detector"
  type        = list
  default     = []
}

variable "replication_lag_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of replication_lag detector"
  type        = list
  default     = []
}

variable "replication_lag_aggregation_function" {
  description = "Aggregation function and group by for replication_lag detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "replication_lag_transformation_function" {
  description = "Transformation function for replication_lag detector (i.e. \".mean(over='5m')\"))"
  type        = string
  default     = ".min(over='10m')"
}

variable "replication_lag_threshold_critical" {
  description = "Critical threshold for replication_lag detector"
  type        = number
  default     = 180
}

variable "replication_lag_threshold_warning" {
  description = "Warning threshold for replication_lag detector"
  type        = number
  default     = 90
}

# Commands detectors

variable "commands_disabled" {
  description = "Disable all alerting rules for commands detector"
  type        = bool
  default     = null
}

variable "commands_disabled_critical" {
  description = "Disable critical alerting rule for commands detector"
  type        = bool
  default     = null
}

variable "commands_disabled_warning" {
  description = "Disable warning alerting rule for commands detector"
  type        = bool
  default     = null
}

variable "commands_notifications" {
  description = "Notification recipients list for every alerting rules of commands detector"
  type        = list
  default     = []
}

variable "commands_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of commands detector"
  type        = list
  default     = []
}

variable "commands_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of commands detector"
  type        = list
  default     = []
}

variable "commands_aggregation_function" {
  description = "Aggregation function and group by for commands detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "commands_transformation_function" {
  description = "Transformation function for commands detector (i.e. \".mean(over='5m')\"))"
  type        = string
  default     = ".sum(over='15m')"
}

variable "commands_threshold_critical" {
  description = "Critical threshold for commands detector"
  type        = number
  # by default we want avoid trigger critical but could be useful in some cases
  default = -1 # impossible to raise alert by default but make it possible to customize
}

variable "commands_threshold_warning" {
  description = "Warning threshold for commands detector"
  type        = number
  default     = 0
}

