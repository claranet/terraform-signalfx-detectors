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

# Redis detectors specific

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

# Evicted_keys detectors

variable "evicted_keys_disabled" {
  description = "Disable all alerting rules for evicted_keys detector"
  type        = bool
  default     = null
}

variable "evicted_keys_disabled_critical" {
  description = "Disable critical alerting rule for evicted_keys detector"
  type        = bool
  default     = null
}

variable "evicted_keys_disabled_warning" {
  description = "Disable warning alerting rule for evicted_keys detector"
  type        = bool
  default     = null
}

variable "evicted_keys_notifications" {
  description = "Notification recipients list for every alerting rules of evicted_keys detector"
  type        = list
  default     = []
}

variable "evicted_keys_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of evicted_keys detector"
  type        = list
  default     = []
}

variable "evicted_keys_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of evicted_keys detector"
  type        = list
  default     = []
}

variable "evicted_keys_aggregation_function" {
  description = "Aggregation function and group by for evicted_keys detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "evicted_keys_transformation_function" {
  description = "Transformation function for evicted_keys detector (mean, min, max)"
  type        = string
  default     = "mean"
}

variable "evicted_keys_transformation_window" {
  description = "Transformation window for evicted_keys detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "evicted_keys_threshold_critical" {
  description = "Critical threshold for evicted_keys detector"
  type        = number
  default     = 100
}

variable "evicted_keys_threshold_warning" {
  description = "Warning threshold for evicted_keys detector"
  type        = number
  default     = 20
}

# Expirations detectors

variable "expirations_disabled" {
  description = "Disable all alerting rules for expirations detector"
  type        = bool
  default     = null
}

variable "expirations_disabled_critical" {
  description = "Disable critical alerting rule for expirations detector"
  type        = bool
  default     = null
}

variable "expirations_disabled_warning" {
  description = "Disable warning alerting rule for expirations detector"
  type        = bool
  default     = null
}

variable "expirations_notifications" {
  description = "Notification recipients list for every alerting rules of expirations detector"
  type        = list
  default     = []
}

variable "expirations_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of expirations detector"
  type        = list
  default     = []
}

variable "expirations_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of expirations detector"
  type        = list
  default     = []
}

variable "expirations_aggregation_function" {
  description = "Aggregation function and group by for expirations detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "expirations_transformation_function" {
  description = "Transformation function for expirations detector (mean, min, max)"
  type        = string
  default     = "min"
}

variable "expirations_transformation_window" {
  description = "Transformation window for expirations detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "expirations_threshold_critical" {
  description = "Critical threshold for expirations detector"
  type        = number
  default     = 80
}

variable "expirations_threshold_warning" {
  description = "Warning threshold for expirations detector"
  type        = number
  default     = 60
}

# Blocked_clients detectors

variable "blocked_clients_disabled" {
  description = "Disable all alerting rules for blocked_clients detector"
  type        = bool
  default     = null
}

variable "blocked_clients_disabled_critical" {
  description = "Disable critical alerting rule for blocked_clients detector"
  type        = bool
  default     = null
}

variable "blocked_clients_disabled_warning" {
  description = "Disable warning alerting rule for blocked_clients detector"
  type        = bool
  default     = null
}

variable "blocked_clients_notifications" {
  description = "Notification recipients list for every alerting rules of blocked_clients detector"
  type        = list
  default     = []
}

variable "blocked_clients_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of blocked_clients detector"
  type        = list
  default     = []
}

variable "blocked_clients_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of blocked_clients detector"
  type        = list
  default     = []
}

variable "blocked_clients_aggregation_function" {
  description = "Aggregation function and group by for blocked_clients detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "blocked_clients_transformation_function" {
  description = "Transformation function for blocked_clients detector (mean, min, max)"
  type        = string
  default     = "min"
}

variable "blocked_clients_transformation_window" {
  description = "Transformation window for blocked_clients detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "blocked_clients_threshold_critical" {
  description = "Critical threshold for blocked_clients detector"
  type        = number
  default     = 30
}

variable "blocked_clients_threshold_warning" {
  description = "Warning threshold for blocked_clients detector"
  type        = number
  default     = 10
}

# Keyspace_full detectors

variable "keyspace_full_disabled" {
  description = "Disable all alerting rules for keyspace_full detector"
  type        = bool
  default     = null
}

variable "keyspace_full_disabled_critical" {
  description = "Disable critical alerting rule for keyspace_full detector"
  type        = bool
  default     = null
}

variable "keyspace_full_disabled_warning" {
  description = "Disable warning alerting rule for keyspace_full detector"
  type        = bool
  default     = null
}

variable "keyspace_full_notifications" {
  description = "Notification recipients list for every alerting rules of keyspace_full detector"
  type        = list
  default     = []
}

variable "keyspace_full_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of keyspace_full detector"
  type        = list
  default     = []
}

variable "keyspace_full_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of keyspace_full detector"
  type        = list
  default     = []
}

variable "keyspace_full_aggregation_function" {
  description = "Aggregation function and group by for keyspace_full detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "keyspace_full_transformation_function" {
  description = "Transformation function for keyspace_full detector (mean, min, max)"
  type        = string
  default     = "min"
}

variable "keyspace_full_transformation_window" {
  description = "Transformation window for keyspace_full detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "keyspace_full_timeshift" {
  description = "Timeshift window for keyspace_full detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "keyspace_full_threshold_critical" {
  description = "Critical threshold for keyspace_full detector"
  type        = number
  default     = 0
}

variable "keyspace_full_threshold_warning" {
  description = "Warning threshold for keyspace_full detector"
  type        = number
  default     = 1
}

# Memory_used detectors

variable "memory_used_disabled" {
  description = "Disable all alerting rules for memory_used detector"
  type        = bool
  default     = null
}

variable "memory_used_disabled_critical" {
  description = "Disable critical alerting rule for memory_used detector"
  type        = bool
  default     = null
}

variable "memory_used_disabled_warning" {
  description = "Disable warning alerting rule for memory_used detector"
  type        = bool
  default     = null
}

variable "memory_used_notifications" {
  description = "Notification recipients list for every alerting rules of memory_used detector"
  type        = list
  default     = []
}

variable "memory_used_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of memory_used detector"
  type        = list
  default     = []
}

variable "memory_used_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of memory_used detector"
  type        = list
  default     = []
}

variable "memory_used_aggregation_function" {
  description = "Aggregation function and group by for memory_used detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "memory_used_transformation_function" {
  description = "Transformation function for memory_used detector (mean, min, max)"
  type        = string
  default     = "min"
}

variable "memory_used_transformation_window" {
  description = "Transformation window for memory_used detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "memory_used_threshold_critical" {
  description = "Critical threshold for memory_used detector"
  type        = number
  default     = 95
}

variable "memory_used_threshold_warning" {
  description = "Warning threshold for memory_used detector"
  type        = number
  default     = 85
}

# Memory_frag detectors

variable "memory_frag_disabled" {
  description = "Disable all alerting rules for memory_frag detector"
  type        = bool
  default     = null
}

variable "memory_frag_disabled_critical" {
  description = "Disable critical alerting rule for memory_frag detector"
  type        = bool
  default     = null
}

variable "memory_frag_disabled_warning" {
  description = "Disable warning alerting rule for memory_frag detector"
  type        = bool
  default     = null
}

variable "memory_frag_notifications" {
  description = "Notification recipients list for every alerting rules of memory_frag detector"
  type        = list
  default     = []
}

variable "memory_frag_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of memory_frag detector"
  type        = list
  default     = []
}

variable "memory_frag_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of memory_frag detector"
  type        = list
  default     = []
}

variable "memory_frag_aggregation_function" {
  description = "Aggregation function and group by for memory_frag detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "memory_frag_transformation_function" {
  description = "Transformation function for memory_frag detector (mean, min, max)"
  type        = string
  default     = "min"
}

variable "memory_frag_transformation_window" {
  description = "Transformation window for memory_frag detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "memory_frag_threshold_critical" {
  description = "Critical threshold for memory_frag detector"
  type        = number
  default     = 150
}

variable "memory_frag_threshold_warning" {
  description = "Warning threshold for memory_frag detector"
  type        = number
  default     = 130
}

# rejected_connections detectors

variable "rejected_connections_disabled" {
  description = "Disable all alerting rules for rejected_connections detector"
  type        = bool
  default     = null
}

variable "rejected_connections_disabled_critical" {
  description = "Disable critical alerting rule for rejected_connections detector"
  type        = bool
  default     = null
}

variable "rejected_connections_disabled_warning" {
  description = "Disable warning alerting rule for rejected_connections detector"
  type        = bool
  default     = null
}

variable "rejected_connections_notifications" {
  description = "Notification recipients list for every alerting rules of rejected_connections detector"
  type        = list
  default     = []
}

variable "rejected_connections_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of rejected_connections detector"
  type        = list
  default     = []
}

variable "rejected_connections_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of rejected_connections detector"
  type        = list
  default     = []
}

variable "rejected_connections_aggregation_function" {
  description = "Aggregation function and group by for rejected_connections detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "rejected_connections_transformation_function" {
  description = "Transformation function for rejected_connections detector (mean, min, max)"
  type        = string
  default     = "min"
}

variable "rejected_connections_transformation_window" {
  description = "Transformation window for rejected_connections detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "rejected_connections_threshold_critical" {
  description = "Critical threshold for rejected_connections detector"
  type        = number
  default     = 50
}

variable "rejected_connections_threshold_warning" {
  description = "Warning threshold for rejected_connections detector"
  type        = number
  default     = 10
}

# Hitrate detectors

variable "hitrate_disabled" {
  description = "Disable all alerting rules for hitrate detector"
  type        = bool
  default     = null
}

variable "hitrate_disabled_critical" {
  description = "Disable critical alerting rule for hitrate detector"
  type        = bool
  default     = null
}

variable "hitrate_disabled_warning" {
  description = "Disable warning alerting rule for hitrate detector"
  type        = bool
  default     = null
}

variable "hitrate_notifications" {
  description = "Notification recipients list for every alerting rules of hitrate detector"
  type        = list
  default     = []
}

variable "hitrate_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of hitrate detector"
  type        = list
  default     = []
}

variable "hitrate_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of hitrate detector"
  type        = list
  default     = []
}

variable "hitrate_aggregation_function" {
  description = "Aggregation function and group by for hitrate detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "hitrate_transformation_function" {
  description = "Transformation function for hitrate detector (mean, min, max)"
  type        = string
  default     = "max"
}

variable "hitrate_transformation_window" {
  description = "Transformation window for hitrate detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "5m"
}

variable "hitrate_threshold_critical" {
  description = "Critical threshold for hitrate detector"
  type        = number
  default     = 10
}

variable "hitrate_threshold_warning" {
  description = "Warning threshold for hitrate detector"
  type        = number
  default     = 30
}
