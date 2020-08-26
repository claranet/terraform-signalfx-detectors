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
  description = "Transformation function for evicted_keys detector (i.e. \".mean(over='5m')\"))"
  type        = string
  default     = ".mean(over='15m')"
}

variable "evicted_keys_threshold_critical" {
  description = "Critical threshold for evicted_keys detector"
  type        = number
  default     = 50
}

variable "evicted_keys_threshold_warning" {
  description = "Warning threshold for evicted_keys detector"
  type        = number
  default     = 25
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
  description = "Transformation function for expirations detector (i.e. \".mean(over='5m')\"))"
  type        = string
  default     = ".mean(over='15m')"
}

variable "expirations_threshold_critical" {
  description = "Critical threshold for expirations detector"
  type        = number
  default     = 100
}

variable "expirations_threshold_warning" {
  description = "Warning threshold for expirations detector"
  type        = number
  default     = 50
}

# Blocked_clients detectors

variable "blocked_clients_disabled" {
  description = "Disable all alerting rules for blocked_clients detector"
  type        = bool
  default     = null
}

variable "blocked_clients_disabled_major" {
  description = "Disable major alerting rule for blocked_clients detector"
  type        = bool
  default     = null
}

variable "blocked_clients_disabled_minor" {
  description = "Disable minor alerting rule for blocked_clients detector"
  type        = bool
  default     = null
}

variable "blocked_clients_notifications" {
  description = "Notification recipients list for every alerting rules of blocked_clients detector"
  type        = list
  default     = []
}

variable "blocked_clients_notifications_minor" {
  description = "Notification recipients list for minor alerting rule of blocked_clients detector"
  type        = list
  default     = []
}

variable "blocked_clients_notifications_major" {
  description = "Notification recipients list for major alerting rule of blocked_clients detector"
  type        = list
  default     = []
}

variable "blocked_clients_aggregation_function" {
  description = "Aggregation function and group by for blocked_clients detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "blocked_clients_transformation_function" {
  description = "Transformation function for blocked_clients detector (i.e. \".mean(over='5m')\"))"
  type        = string
  default     = ".mean(over='1h')"
}

variable "blocked_clients_threshold_major" {
  description = "major threshold for blocked_clients detector"
  type        = number
  default     = 5
}

variable "blocked_clients_threshold_minor" {
  description = "minor threshold for blocked_clients detector"
  type        = number
  default     = 0
}

# Keyspace_full detectors

variable "keyspace_full_disabled" {
  description = "Disable all alerting rules for keyspace_full detector"
  type        = bool
  default     = true
}

variable "keyspace_full_notifications" {
  description = "Notification recipients list for every alerting rules of keyspace_full detector"
  type        = list
  default     = []
}

variable "keyspace_full_aggregation_function" {
  description = "Aggregation function and group by for keyspace_full detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "keyspace_full_transformation_function" {
  description = "Transformation function for keyspace_full detector (i.e. \".mean(over='5m')\"))"
  type        = string
  default     = ".sum(over='1h')"
}

# Memory_used_max detectors

variable "memory_used_max_disabled" {
  description = "Disable all alerting rules for memory_used_max detector"
  type        = bool
  default     = null
}

variable "memory_used_max_disabled_critical" {
  description = "Disable critical alerting rule for memory_used_max detector"
  type        = bool
  default     = null
}

variable "memory_used_max_disabled_warning" {
  description = "Disable warning alerting rule for memory_used_max detector"
  type        = bool
  default     = null
}

variable "memory_used_max_notifications" {
  description = "Notification recipients list for every alerting rules of memory_used_max detector"
  type        = list
  default     = []
}

variable "memory_used_max_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of memory_used_max detector"
  type        = list
  default     = []
}

variable "memory_used_max_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of memory_used_max detector"
  type        = list
  default     = []
}

variable "memory_used_max_aggregation_function" {
  description = "Aggregation function and group by for memory_used_max detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "memory_used_max_transformation_function" {
  description = "Transformation function for memory_used_max detector (i.e. \".mean(over='5m')\"))"
  type        = string
  default     = ".min(over='10m')"
}

variable "memory_used_max_threshold_critical" {
  description = "Critical threshold for memory_used_max detector"
  type        = number
  default     = 95
}

variable "memory_used_max_threshold_warning" {
  description = "Warning threshold for memory_used_max detector"
  type        = number
  default     = 85
}

# Memory_used_total detectors

variable "memory_used_total_disabled" {
  description = "Disable all alerting rules for memory_used_total detector"
  type        = bool
  default     = null
}

variable "memory_used_total_disabled_critical" {
  description = "Disable critical alerting rule for memory_used_total detector"
  type        = bool
  default     = null
}

variable "memory_used_total_disabled_warning" {
  description = "Disable warning alerting rule for memory_used_total detector"
  type        = bool
  default     = null
}

variable "memory_used_total_notifications" {
  description = "Notification recipients list for every alerting rules of memory_used_total detector"
  type        = list
  default     = []
}

variable "memory_used_total_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of memory_used_total detector"
  type        = list
  default     = []
}

variable "memory_used_total_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of memory_used_total detector"
  type        = list
  default     = []
}

variable "memory_used_total_aggregation_function" {
  description = "Aggregation function and group by for memory_used_total detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "memory_used_total_transformation_function" {
  description = "Transformation function for memory_used_total detector (i.e. \".mean(over='5m')\"))"
  type        = string
  default     = ".min(over='10m')"
}

variable "memory_used_total_threshold_critical" {
  description = "Critical threshold for memory_used_total detector"
  type        = number
  default     = 95
}

variable "memory_used_total_threshold_warning" {
  description = "Warning threshold for memory_used_total detector"
  type        = number
  default     = 85
}

# Memory_frag_high detectors

variable "memory_frag_high_disabled" {
  description = "Disable all alerting rules for memory_frag_high detector"
  type        = bool
  default     = null
}

variable "memory_frag_high_disabled_critical" {
  description = "Disable critical alerting rule for memory_frag_high detector"
  type        = bool
  default     = null
}

variable "memory_frag_high_disabled_warning" {
  description = "Disable warning alerting rule for memory_frag_high detector"
  type        = bool
  default     = null
}

variable "memory_frag_high_notifications" {
  description = "Notification recipients list for every alerting rules of memory_frag_high detector"
  type        = list
  default     = []
}

variable "memory_frag_high_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of memory_frag_high detector"
  type        = list
  default     = []
}

variable "memory_frag_high_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of memory_frag_high detector"
  type        = list
  default     = []
}

variable "memory_frag_high_aggregation_function" {
  description = "Aggregation function and group by for memory_frag_high detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "memory_frag_high_transformation_function" {
  description = "Transformation function for memory_frag_high detector (i.e. \".mean(over='5m')\"))"
  type        = string
  default     = ".mean(over='15m')"
}

variable "memory_frag_high_threshold_critical" {
  description = "Critical threshold for memory_frag_high detector"
  type        = number
  default     = 5
}

variable "memory_frag_high_threshold_warning" {
  description = "Warning threshold for memory_frag_high detector"
  type        = number
  default     = 2
}

# Memory_frag_low detectors

variable "memory_frag_low_disabled" {
  description = "Disable all alerting rules for memory_frag_low detector"
  type        = bool
  default     = null
}

variable "memory_frag_low_disabled_critical" {
  description = "Disable critical alerting rule for memory_frag_low detector"
  type        = bool
  default     = null
}

variable "memory_frag_low_disabled_warning" {
  description = "Disable warning alerting rule for memory_frag_low detector"
  type        = bool
  default     = null
}

variable "memory_frag_low_notifications" {
  description = "Notification recipients list for every alerting rules of memory_frag_low detector"
  type        = list
  default     = []
}

variable "memory_frag_low_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of memory_frag_low detector"
  type        = list
  default     = []
}

variable "memory_frag_low_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of memory_frag_low detector"
  type        = list
  default     = []
}

variable "memory_frag_low_aggregation_function" {
  description = "Aggregation function and group by for memory_frag_low detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "memory_frag_low_transformation_function" {
  description = "Transformation function for memory_frag_low detector (i.e. \".mean(over='5m')\"))"
  type        = string
  default     = ".mean(over='15m')"
}

variable "memory_frag_low_threshold_critical" {
  description = "Critical threshold for memory_frag_low detector"
  type        = number
  default     = 0.75
}

variable "memory_frag_low_threshold_warning" {
  description = "Warning threshold for memory_frag_low detector"
  type        = number
  default     = 1
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
  description = "Transformation function for rejected_connections detector (i.e. \".mean(over='5m')\"))"
  type        = string
  default     = "sum(over='5m')"
}

variable "rejected_connections_threshold_critical" {
  description = "Critical threshold for rejected_connections detector"
  type        = number
  default     = 5
}

variable "rejected_connections_threshold_warning" {
  description = "Warning threshold for rejected_connections detector"
  type        = number
  default     = 0
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
  description = "Transformation function for hitrate (i.e. \".mean(over='5m')\"))"
  type        = string
  default     = ".max(over='5m')"
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

