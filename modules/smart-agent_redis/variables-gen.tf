# heartbeat detector

variable "heartbeat_notifications" {
  description = "Notification recipients list per severity overridden for heartbeat detector"
  type        = map(list(string))
  default     = {}
}

variable "heartbeat_aggregation_function" {
  description = "Aggregation function and group by for heartbeat detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "heartbeat_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "heartbeat_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
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

# evicted_keys_change_rate detector

variable "evicted_keys_change_rate_notifications" {
  description = "Notification recipients list per severity overridden for evicted_keys_change_rate detector"
  type        = map(list(string))
  default     = {}
}

variable "evicted_keys_change_rate_aggregation_function" {
  description = "Aggregation function and group by for evicted_keys_change_rate detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "evicted_keys_change_rate_transformation_function" {
  description = "Transformation function for evicted_keys_change_rate detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "evicted_keys_change_rate_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "evicted_keys_change_rate_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "evicted_keys_change_rate_disabled" {
  description = "Disable all alerting rules for evicted_keys_change_rate detector"
  type        = bool
  default     = null
}

variable "evicted_keys_change_rate_disabled_critical" {
  description = "Disable critical alerting rule for evicted_keys_change_rate detector"
  type        = bool
  default     = null
}

variable "evicted_keys_change_rate_disabled_major" {
  description = "Disable major alerting rule for evicted_keys_change_rate detector"
  type        = bool
  default     = null
}

variable "evicted_keys_change_rate_threshold_critical" {
  description = "Critical threshold for evicted_keys_change_rate detector"
  type        = number
  default     = 50
}

variable "evicted_keys_change_rate_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "15m"
}

variable "evicted_keys_change_rate_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 0.5
}
variable "evicted_keys_change_rate_threshold_major" {
  description = "Major threshold for evicted_keys_change_rate detector"
  type        = number
  default     = 25
}

variable "evicted_keys_change_rate_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "15m"
}

variable "evicted_keys_change_rate_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 0.5
}
# expired_keys_change_rate detector

variable "expired_keys_change_rate_notifications" {
  description = "Notification recipients list per severity overridden for expired_keys_change_rate detector"
  type        = map(list(string))
  default     = {}
}

variable "expired_keys_change_rate_aggregation_function" {
  description = "Aggregation function and group by for expired_keys_change_rate detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "expired_keys_change_rate_transformation_function" {
  description = "Transformation function for expired_keys_change_rate detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "expired_keys_change_rate_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "expired_keys_change_rate_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "expired_keys_change_rate_disabled" {
  description = "Disable all alerting rules for expired_keys_change_rate detector"
  type        = bool
  default     = null
}

variable "expired_keys_change_rate_disabled_critical" {
  description = "Disable critical alerting rule for expired_keys_change_rate detector"
  type        = bool
  default     = null
}

variable "expired_keys_change_rate_disabled_major" {
  description = "Disable major alerting rule for expired_keys_change_rate detector"
  type        = bool
  default     = null
}

variable "expired_keys_change_rate_threshold_critical" {
  description = "Critical threshold for expired_keys_change_rate detector"
  type        = number
  default     = 100
}

variable "expired_keys_change_rate_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "15m"
}

variable "expired_keys_change_rate_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 0.5
}
variable "expired_keys_change_rate_threshold_major" {
  description = "Major threshold for expired_keys_change_rate detector"
  type        = number
  default     = 50
}

variable "expired_keys_change_rate_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "15m"
}

variable "expired_keys_change_rate_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 0.5
}
# blocked_over_connected_clients_ratio detector

variable "blocked_over_connected_clients_ratio_notifications" {
  description = "Notification recipients list per severity overridden for blocked_over_connected_clients_ratio detector"
  type        = map(list(string))
  default     = {}
}

variable "blocked_over_connected_clients_ratio_aggregation_function" {
  description = "Aggregation function and group by for blocked_over_connected_clients_ratio detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "blocked_over_connected_clients_ratio_transformation_function" {
  description = "Transformation function for blocked_over_connected_clients_ratio detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "blocked_over_connected_clients_ratio_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "blocked_over_connected_clients_ratio_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "blocked_over_connected_clients_ratio_disabled" {
  description = "Disable all alerting rules for blocked_over_connected_clients_ratio detector"
  type        = bool
  default     = null
}

variable "blocked_over_connected_clients_ratio_disabled_critical" {
  description = "Disable critical alerting rule for blocked_over_connected_clients_ratio detector"
  type        = bool
  default     = null
}

variable "blocked_over_connected_clients_ratio_disabled_major" {
  description = "Disable major alerting rule for blocked_over_connected_clients_ratio detector"
  type        = bool
  default     = null
}

variable "blocked_over_connected_clients_ratio_threshold_critical" {
  description = "Critical threshold for blocked_over_connected_clients_ratio detector in %"
  type        = number
  default     = 5
}

variable "blocked_over_connected_clients_ratio_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "1h"
}

variable "blocked_over_connected_clients_ratio_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 0.5
}
variable "blocked_over_connected_clients_ratio_threshold_major" {
  description = "Major threshold for blocked_over_connected_clients_ratio detector in %"
  type        = number
  default     = 0
}

variable "blocked_over_connected_clients_ratio_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "1h"
}

variable "blocked_over_connected_clients_ratio_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 0.5
}
# stored_keys_change_rate detector

variable "stored_keys_change_rate_notifications" {
  description = "Notification recipients list per severity overridden for stored_keys_change_rate detector"
  type        = map(list(string))
  default     = {}
}

variable "stored_keys_change_rate_aggregation_function" {
  description = "Aggregation function and group by for stored_keys_change_rate detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "stored_keys_change_rate_transformation_function" {
  description = "Transformation function for stored_keys_change_rate detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "stored_keys_change_rate_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "stored_keys_change_rate_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "stored_keys_change_rate_disabled" {
  description = "Disable all alerting rules for stored_keys_change_rate detector"
  type        = bool
  default     = null
}

variable "stored_keys_change_rate_threshold_major" {
  description = "Major threshold for stored_keys_change_rate detector"
  type        = number
  default     = 0
}

variable "stored_keys_change_rate_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "1h"
}

variable "stored_keys_change_rate_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# used_over_maximum_memory_ratio detector

variable "used_over_maximum_memory_ratio_notifications" {
  description = "Notification recipients list per severity overridden for used_over_maximum_memory_ratio detector"
  type        = map(list(string))
  default     = {}
}

variable "used_over_maximum_memory_ratio_aggregation_function" {
  description = "Aggregation function and group by for used_over_maximum_memory_ratio detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "used_over_maximum_memory_ratio_transformation_function" {
  description = "Transformation function for used_over_maximum_memory_ratio detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "used_over_maximum_memory_ratio_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "used_over_maximum_memory_ratio_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "used_over_maximum_memory_ratio_disabled" {
  description = "Disable all alerting rules for used_over_maximum_memory_ratio detector"
  type        = bool
  default     = null
}

variable "used_over_maximum_memory_ratio_disabled_critical" {
  description = "Disable critical alerting rule for used_over_maximum_memory_ratio detector"
  type        = bool
  default     = null
}

variable "used_over_maximum_memory_ratio_disabled_major" {
  description = "Disable major alerting rule for used_over_maximum_memory_ratio detector"
  type        = bool
  default     = null
}

variable "used_over_maximum_memory_ratio_threshold_critical" {
  description = "Critical threshold for used_over_maximum_memory_ratio detector in %"
  type        = number
  default     = 95
}

variable "used_over_maximum_memory_ratio_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "10m"
}

variable "used_over_maximum_memory_ratio_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "used_over_maximum_memory_ratio_threshold_major" {
  description = "Major threshold for used_over_maximum_memory_ratio detector in %"
  type        = number
  default     = 85
}

variable "used_over_maximum_memory_ratio_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "10m"
}

variable "used_over_maximum_memory_ratio_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# used_over_system_memory_ratio detector

variable "used_over_system_memory_ratio_notifications" {
  description = "Notification recipients list per severity overridden for used_over_system_memory_ratio detector"
  type        = map(list(string))
  default     = {}
}

variable "used_over_system_memory_ratio_aggregation_function" {
  description = "Aggregation function and group by for used_over_system_memory_ratio detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "used_over_system_memory_ratio_transformation_function" {
  description = "Transformation function for used_over_system_memory_ratio detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "used_over_system_memory_ratio_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "used_over_system_memory_ratio_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "used_over_system_memory_ratio_disabled" {
  description = "Disable all alerting rules for used_over_system_memory_ratio detector"
  type        = bool
  default     = null
}

variable "used_over_system_memory_ratio_disabled_critical" {
  description = "Disable critical alerting rule for used_over_system_memory_ratio detector"
  type        = bool
  default     = null
}

variable "used_over_system_memory_ratio_disabled_major" {
  description = "Disable major alerting rule for used_over_system_memory_ratio detector"
  type        = bool
  default     = null
}

variable "used_over_system_memory_ratio_threshold_critical" {
  description = "Critical threshold for used_over_system_memory_ratio detector in %"
  type        = number
  default     = 95
}

variable "used_over_system_memory_ratio_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "10m"
}

variable "used_over_system_memory_ratio_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "used_over_system_memory_ratio_threshold_major" {
  description = "Major threshold for used_over_system_memory_ratio detector in %"
  type        = number
  default     = 85
}

variable "used_over_system_memory_ratio_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "10m"
}

variable "used_over_system_memory_ratio_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# high_memory_fragmentation_ratio detector

variable "high_memory_fragmentation_ratio_notifications" {
  description = "Notification recipients list per severity overridden for high_memory_fragmentation_ratio detector"
  type        = map(list(string))
  default     = {}
}

variable "high_memory_fragmentation_ratio_aggregation_function" {
  description = "Aggregation function and group by for high_memory_fragmentation_ratio detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "high_memory_fragmentation_ratio_transformation_function" {
  description = "Transformation function for high_memory_fragmentation_ratio detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "high_memory_fragmentation_ratio_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "high_memory_fragmentation_ratio_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = "https://www.dynatrace.com/news/blog/introducing-redis-server-monitoring/#key-metrics"
}

variable "high_memory_fragmentation_ratio_disabled" {
  description = "Disable all alerting rules for high_memory_fragmentation_ratio detector"
  type        = bool
  default     = null
}

variable "high_memory_fragmentation_ratio_disabled_critical" {
  description = "Disable critical alerting rule for high_memory_fragmentation_ratio detector"
  type        = bool
  default     = null
}

variable "high_memory_fragmentation_ratio_disabled_major" {
  description = "Disable major alerting rule for high_memory_fragmentation_ratio detector"
  type        = bool
  default     = null
}

variable "high_memory_fragmentation_ratio_threshold_critical" {
  description = "Critical threshold for high_memory_fragmentation_ratio detector"
  type        = number
  default     = 5
}

variable "high_memory_fragmentation_ratio_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "15m"
}

variable "high_memory_fragmentation_ratio_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 0.5
}
variable "high_memory_fragmentation_ratio_threshold_major" {
  description = "Major threshold for high_memory_fragmentation_ratio detector"
  type        = number
  default     = 2
}

variable "high_memory_fragmentation_ratio_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "15m"
}

variable "high_memory_fragmentation_ratio_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 0.5
}
# low_memory_fragmentation_ratio detector

variable "low_memory_fragmentation_ratio_notifications" {
  description = "Notification recipients list per severity overridden for low_memory_fragmentation_ratio detector"
  type        = map(list(string))
  default     = {}
}

variable "low_memory_fragmentation_ratio_aggregation_function" {
  description = "Aggregation function and group by for low_memory_fragmentation_ratio detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "low_memory_fragmentation_ratio_transformation_function" {
  description = "Transformation function for low_memory_fragmentation_ratio detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "low_memory_fragmentation_ratio_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "low_memory_fragmentation_ratio_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = "https://www.dynatrace.com/news/blog/introducing-redis-server-monitoring/#key-metrics"
}

variable "low_memory_fragmentation_ratio_disabled" {
  description = "Disable all alerting rules for low_memory_fragmentation_ratio detector"
  type        = bool
  default     = null
}

variable "low_memory_fragmentation_ratio_disabled_critical" {
  description = "Disable critical alerting rule for low_memory_fragmentation_ratio detector"
  type        = bool
  default     = null
}

variable "low_memory_fragmentation_ratio_disabled_major" {
  description = "Disable major alerting rule for low_memory_fragmentation_ratio detector"
  type        = bool
  default     = null
}

variable "low_memory_fragmentation_ratio_threshold_critical" {
  description = "Critical threshold for low_memory_fragmentation_ratio detector"
  type        = number
  default     = 0.75
}

variable "low_memory_fragmentation_ratio_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "15m"
}

variable "low_memory_fragmentation_ratio_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 0.5
}
variable "low_memory_fragmentation_ratio_threshold_major" {
  description = "Major threshold for low_memory_fragmentation_ratio detector"
  type        = number
  default     = 1
}

variable "low_memory_fragmentation_ratio_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "15m"
}

variable "low_memory_fragmentation_ratio_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 0.5
}
# rejected_connections detector

variable "rejected_connections_notifications" {
  description = "Notification recipients list per severity overridden for rejected_connections detector"
  type        = map(list(string))
  default     = {}
}

variable "rejected_connections_aggregation_function" {
  description = "Aggregation function and group by for rejected_connections detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "rejected_connections_transformation_function" {
  description = "Transformation function for rejected_connections detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".sum(over='5m')"
}

variable "rejected_connections_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = <<-EOF
    maxclient reached
EOF
}

variable "rejected_connections_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

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

variable "rejected_connections_disabled_major" {
  description = "Disable major alerting rule for rejected_connections detector"
  type        = bool
  default     = null
}

variable "rejected_connections_threshold_critical" {
  description = "Critical threshold for rejected_connections detector"
  type        = number
  default     = 5
}

variable "rejected_connections_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "rejected_connections_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "rejected_connections_threshold_major" {
  description = "Major threshold for rejected_connections detector"
  type        = number
  default     = 0
}

variable "rejected_connections_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "rejected_connections_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# hitrate detector

variable "hitrate_notifications" {
  description = "Notification recipients list per severity overridden for hitrate detector"
  type        = map(list(string))
  default     = {}
}

variable "hitrate_aggregation_function" {
  description = "Aggregation function and group by for hitrate detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "hitrate_transformation_function" {
  description = "Transformation function for hitrate detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "hitrate_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "hitrate_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

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

variable "hitrate_disabled_major" {
  description = "Disable major alerting rule for hitrate detector"
  type        = bool
  default     = null
}

variable "hitrate_threshold_critical" {
  description = "Critical threshold for hitrate detector in %"
  type        = number
  default     = 10
}

variable "hitrate_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "5m"
}

variable "hitrate_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "hitrate_threshold_major" {
  description = "Major threshold for hitrate detector in %"
  type        = number
  default     = 30
}

variable "hitrate_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "5m"
}

variable "hitrate_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
