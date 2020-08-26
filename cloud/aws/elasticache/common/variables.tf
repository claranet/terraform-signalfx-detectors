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

# Evictions detectors

variable "evictions_disabled" {
  description = "Disable all alerting rules for evictions detector"
  type        = bool
  default     = null
}

variable "evictions_disabled_critical" {
  description = "Disable critical alerting rule for evictions detector"
  type        = bool
  default     = null
}

variable "evictions_disabled_warning" {
  description = "Disable warning alerting rule for evictions detector"
  type        = bool
  default     = null
}

variable "evictions_notifications" {
  description = "Notification recipients list for every alerting rules of evictions detector"
  type        = list
  default     = []
}

variable "evictions_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of evictions detector"
  type        = list
  default     = []
}

variable "evictions_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of evictions detector"
  type        = list
  default     = []
}

variable "evictions_aggregation_function" {
  description = "Aggregation function and group by for evictions detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "evictions_transformation_function" {
  description = "Transformation function for evictions detector (i.e. \".mean(over='5m')\"))"
  type        = string
  default     = ".sum(over='15m')"
}

variable "evictions_threshold_critical" {
  description = "Critical threshold for evictions detector"
  type        = number
  default     = 30
}

variable "evictions_threshold_warning" {
  description = "Warning threshold for evictions detector"
  type        = number
  default     = 0
}

# Max_connection detectors

variable "max_connection_disabled" {
  description = "Disable all alerting rules for max_connection detector"
  type        = bool
  default     = null
}

variable "max_connection_disabled_critical" {
  description = "Disable critical alerting rule for max_connection detector"
  type        = bool
  default     = null
}

variable "max_connection_notifications" {
  description = "Notification recipients list for every alerting rules of max_connection detector"
  type        = list
  default     = []
}

variable "max_connection_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of max_connection detector"
  type        = list
  default     = []
}

variable "max_connection_aggregation_function" {
  description = "Aggregation function and group by for max_connection detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "max_connection_transformation_function" {
  description = "Transformation function for max_connection detector (i.e. \".mean(over='5m')\"))"
  type        = string
  default     = ".max(over='5m')"
}

variable "max_connection_threshold_critical" {
  description = "Critical threshold for max_connection detector"
  type        = number
  default     = 64999
}

# No_connection detectors

variable "no_connection_disabled" {
  description = "Disable all alerting rules for no_connection detector"
  type        = bool
  default     = null
}

variable "no_connection_disabled_critical" {
  description = "Disable critical alerting rule for no_connection detector"
  type        = bool
  default     = null
}

variable "no_connection_notifications" {
  description = "Notification recipients list for every alerting rules of no_connection detector"
  type        = list
  default     = []
}

variable "no_connection_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of no_connection detector"
  type        = list
  default     = []
}

variable "no_connection_aggregation_function" {
  description = "Aggregation function and group by for no_connection detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "no_connection_transformation_function" {
  description = "Transformation function for no_connection detector (i.e. \".mean(over='5m')\"))"
  type        = string
  default     = ".min(over='5m')"
}

variable "no_connection_threshold_critical" {
  description = "Critical threshold for no_connection detector"
  type        = number
  default     = 0
}

# Swap detectors

variable "swap_disabled" {
  description = "Disable all alerting rules for swap detector"
  type        = bool
  default     = null
}

variable "swap_disabled_critical" {
  description = "Disable critical alerting rule for swap detector"
  type        = bool
  default     = null
}

variable "swap_disabled_warning" {
  description = "Disable warning alerting rule for swap detector"
  type        = bool
  default     = null
}

variable "swap_notifications" {
  description = "Notification recipients list for every alerting rules of swap detector"
  type        = list
  default     = []
}

variable "swap_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of swap detector"
  type        = list
  default     = []
}

variable "swap_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of swap detector"
  type        = list
  default     = []
}

variable "swap_aggregation_function" {
  description = "Aggregation function and group by for swap detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "swap_transformation_function" {
  description = "Transformation function for swap detector (i.e. \".mean(over='5m')\"))"
  type        = string
  default     = ".min(over='5m')"
}

variable "swap_threshold_critical" {
  description = "Critical threshold for swap detector"
  type        = number
  default     = 50000000
}

variable "swap_threshold_warning" {
  description = "Warning threshold for swap detector"
  type        = number
  default     = 0
}

# Free_memory detectors

variable "free_memory_disabled" {
  description = "Disable all alerting rules for free_memory detector"
  type        = bool
  default     = null
}

variable "free_memory_disabled_critical" {
  description = "Disable critical alerting rule for free_memory detector"
  type        = bool
  default     = null
}

variable "free_memory_disabled_warning" {
  description = "Disable warning alerting rule for free_memory detector"
  type        = bool
  default     = null
}

variable "free_memory_notifications" {
  description = "Notification recipients list for every alerting rules of free_memory detector"
  type        = list
  default     = []
}

variable "free_memory_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of free_memory detector"
  type        = list
  default     = []
}

variable "free_memory_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of free_memory detector"
  type        = list
  default     = []
}

variable "free_memory_aggregation_function" {
  description = "Aggregation function and group by for free_memory detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "free_memory_transformation_function" {
  description = "Transformation function for free_memory detector (i.e. \".mean(over='5m')\"))"
  type        = string
  default     = ".mean(over='15m')"
}

variable "free_memory_threshold_critical" {
  description = "Critical threshold for free_memory detector"
  type        = number
  default     = -70
}

variable "free_memory_threshold_warning" {
  description = "Warning threshold for free_memory detector"
  type        = number
  default     = -50
}

# Evictions_growing detectors

variable "evictions_growing_disabled" {
  description = "Disable all alerting rules for evictions_growing detector"
  type        = bool
  default     = null
}

variable "evictions_growing_disabled_critical" {
  description = "Disable critical alerting rule for evictions_growing detector"
  type        = bool
  default     = null
}

variable "evictions_growing_disabled_warning" {
  description = "Disable warning alerting rule for evictions_growing detector"
  type        = bool
  default     = null
}

variable "evictions_growing_notifications" {
  description = "Notification recipients list for every alerting rules of evictions_growing detector"
  type        = list
  default     = []
}

variable "evictions_growing_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of evictions_growing detector"
  type        = list
  default     = []
}

variable "evictions_growing_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of evictions_growing detector"
  type        = list
  default     = []
}

variable "evictions_growing_aggregation_function" {
  description = "Aggregation function and group by for evictions_growing detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "evictions_growing_transformation_function" {
  description = "Transformation function for evictions_growing detector (i.e. \".mean(over='5m')\"))"
  type        = string
  default     = ".mean(over='5m')"
}

variable "evictions_growing_threshold_critical" {
  description = "Critical threshold for evictions_growing detector"
  type        = number
  default     = 30
}

variable "evictions_growing_threshold_warning" {
  description = "Warning threshold for evictions_growing detector"
  type        = number
  default     = 10
}

