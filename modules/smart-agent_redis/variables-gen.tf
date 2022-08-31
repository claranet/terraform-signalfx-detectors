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

variable "heartbeat_max_delay" {
  description = "Enforce max delay for heartbeat detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = 900
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
  default     = "10m"
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

variable "evicted_keys_change_rate_max_delay" {
  description = "Enforce max delay for evicted_keys_change_rate detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
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

variable "expired_keys_change_rate_max_delay" {
  description = "Enforce max delay for expired_keys_change_rate detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
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

variable "blocked_over_connected_clients_ratio_max_delay" {
  description = "Enforce max delay for blocked_over_connected_clients_ratio detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
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

variable "stored_keys_change_rate_max_delay" {
  description = "Enforce max delay for stored_keys_change_rate detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "stored_keys_change_rate_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = <<-EOF
    no change on keyspace over a long period can indicate it is full. if you don't use redis as cache but as queue broker or database so it can be normal to not see any activity depending on your application and you should disable this detector
EOF
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
# percentage_memory_used_over_max_memory_set detector

variable "percentage_memory_used_over_max_memory_set_notifications" {
  description = "Notification recipients list per severity overridden for percentage_memory_used_over_max_memory_set detector"
  type        = map(list(string))
  default     = {}
}

variable "percentage_memory_used_over_max_memory_set_aggregation_function" {
  description = "Aggregation function and group by for percentage_memory_used_over_max_memory_set detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "percentage_memory_used_over_max_memory_set_transformation_function" {
  description = "Transformation function for percentage_memory_used_over_max_memory_set detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "percentage_memory_used_over_max_memory_set_max_delay" {
  description = "Enforce max delay for percentage_memory_used_over_max_memory_set detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "percentage_memory_used_over_max_memory_set_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = <<-EOF
    max memory needs to be set in redis server configuration or this detector will never raise alert
EOF
}

variable "percentage_memory_used_over_max_memory_set_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "percentage_memory_used_over_max_memory_set_disabled" {
  description = "Disable all alerting rules for percentage_memory_used_over_max_memory_set detector"
  type        = bool
  default     = null
}

variable "percentage_memory_used_over_max_memory_set_disabled_critical" {
  description = "Disable critical alerting rule for percentage_memory_used_over_max_memory_set detector"
  type        = bool
  default     = null
}

variable "percentage_memory_used_over_max_memory_set_disabled_major" {
  description = "Disable major alerting rule for percentage_memory_used_over_max_memory_set detector"
  type        = bool
  default     = null
}

variable "percentage_memory_used_over_max_memory_set_threshold_critical" {
  description = "Critical threshold for percentage_memory_used_over_max_memory_set detector in %"
  type        = number
  default     = 95
}

variable "percentage_memory_used_over_max_memory_set_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "10m"
}

variable "percentage_memory_used_over_max_memory_set_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "percentage_memory_used_over_max_memory_set_threshold_major" {
  description = "Major threshold for percentage_memory_used_over_max_memory_set detector in %"
  type        = number
  default     = 85
}

variable "percentage_memory_used_over_max_memory_set_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "10m"
}

variable "percentage_memory_used_over_max_memory_set_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# percentage_memory_used_over_system_memory detector

variable "percentage_memory_used_over_system_memory_notifications" {
  description = "Notification recipients list per severity overridden for percentage_memory_used_over_system_memory detector"
  type        = map(list(string))
  default     = {}
}

variable "percentage_memory_used_over_system_memory_aggregation_function" {
  description = "Aggregation function and group by for percentage_memory_used_over_system_memory detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "percentage_memory_used_over_system_memory_transformation_function" {
  description = "Transformation function for percentage_memory_used_over_system_memory detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "percentage_memory_used_over_system_memory_max_delay" {
  description = "Enforce max delay for percentage_memory_used_over_system_memory detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "percentage_memory_used_over_system_memory_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "percentage_memory_used_over_system_memory_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "percentage_memory_used_over_system_memory_disabled" {
  description = "Disable all alerting rules for percentage_memory_used_over_system_memory detector"
  type        = bool
  default     = null
}

variable "percentage_memory_used_over_system_memory_disabled_critical" {
  description = "Disable critical alerting rule for percentage_memory_used_over_system_memory detector"
  type        = bool
  default     = null
}

variable "percentage_memory_used_over_system_memory_disabled_major" {
  description = "Disable major alerting rule for percentage_memory_used_over_system_memory detector"
  type        = bool
  default     = null
}

variable "percentage_memory_used_over_system_memory_threshold_critical" {
  description = "Critical threshold for percentage_memory_used_over_system_memory detector in %"
  type        = number
  default     = 95
}

variable "percentage_memory_used_over_system_memory_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "10m"
}

variable "percentage_memory_used_over_system_memory_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "percentage_memory_used_over_system_memory_threshold_major" {
  description = "Major threshold for percentage_memory_used_over_system_memory detector in %"
  type        = number
  default     = 85
}

variable "percentage_memory_used_over_system_memory_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "10m"
}

variable "percentage_memory_used_over_system_memory_at_least_percentage_major" {
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

variable "high_memory_fragmentation_ratio_max_delay" {
  description = "Enforce max delay for high_memory_fragmentation_ratio detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "high_memory_fragmentation_ratio_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = <<-EOF
    restart redis to recover memory previously unusable due to fragmentation or enable the new active defragmentation feature available since redis 4
EOF
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
  default     = 1
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
  default     = 1
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

variable "low_memory_fragmentation_ratio_max_delay" {
  description = "Enforce max delay for low_memory_fragmentation_ratio detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "low_memory_fragmentation_ratio_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = <<-EOF
    increase the memory available on the host or reduce the memory usage from your application
EOF
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

variable "rejected_connections_max_delay" {
  description = "Enforce max delay for rejected_connections detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
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

variable "hitrate_max_delay" {
  description = "Enforce max delay for hitrate detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
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

variable "hitrate_disabled_major" {
  description = "Disable major alerting rule for hitrate detector"
  type        = bool
  default     = null
}

variable "hitrate_disabled_minor" {
  description = "Disable minor alerting rule for hitrate detector"
  type        = bool
  default     = null
}

variable "hitrate_threshold_major" {
  description = "Major threshold for hitrate detector in %"
  type        = number
  default     = 10
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
variable "hitrate_threshold_minor" {
  description = "Minor threshold for hitrate detector in %"
  type        = number
  default     = 30
}

variable "hitrate_lasting_duration_minor" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "5m"
}

variable "hitrate_at_least_percentage_minor" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
