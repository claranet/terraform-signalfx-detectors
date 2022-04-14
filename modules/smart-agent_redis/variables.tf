# Module specific

variable "use_otel_receiver" {
  description = "Set to true when metrics are collected by redisreceiver from otel collector instead of collectd/redis monitor of smart agent."
  type        = bool
  default     = false
}

# Heartbeat detector

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

variable "heartbeat_notifications" {
  description = "Notification recipients list per severity overridden for heartbeat detector"
  type        = map(list(string))
  default     = {}
}

variable "heartbeat_timeframe" {
  description = "Timeframe for heartbeat detector (i.e. \"10m\")"
  type        = string
  default     = "10m"
}

variable "heartbeat_aggregation_function" {
  description = "Aggregation function and group by for heartbeat detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

# Evicted_keys detector

variable "evicted_keys_max_delay" {
  description = "Enforce max delay for evicted_keys detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "evicted_keys_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "evicted_keys_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

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

variable "evicted_keys_disabled_major" {
  description = "Disable major alerting rule for evicted_keys detector"
  type        = bool
  default     = null
}

variable "evicted_keys_notifications" {
  description = "Notification recipients list per severity overridden for evicted_keys detector"
  type        = map(list(string))
  default     = {}
}

variable "evicted_keys_aggregation_function" {
  description = "Aggregation function and group by for evicted_keys detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "evicted_keys_transformation_function" {
  description = "Transformation function for evicted_keys detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".mean(over='15m')"
}

variable "evicted_keys_threshold_critical" {
  description = "Critical threshold for evicted_keys detector"
  type        = number
  default     = 50
}

variable "evicted_keys_threshold_major" {
  description = "Major threshold for evicted_keys detector"
  type        = number
  default     = 25
}

# Expirations detector

variable "expirations_max_delay" {
  description = "Enforce max delay for expirations detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "expirations_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "expirations_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

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

variable "expirations_disabled_major" {
  description = "Disable major alerting rule for expirations detector"
  type        = bool
  default     = null
}

variable "expirations_notifications" {
  description = "Notification recipients list per severity overridden for expirations detector"
  type        = map(list(string))
  default     = {}
}

variable "expirations_aggregation_function" {
  description = "Aggregation function and group by for expirations detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "expirations_transformation_function" {
  description = "Transformation function for expirations detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".mean(over='15m')"
}

variable "expirations_threshold_critical" {
  description = "Critical threshold for expirations detector"
  type        = number
  default     = 100
}

variable "expirations_threshold_major" {
  description = "Major threshold for expirations detector"
  type        = number
  default     = 50
}

# Blocked_clients detector

variable "blocked_clients_max_delay" {
  description = "Enforce max delay for blocked_clients detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "blocked_clients_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "blocked_clients_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "blocked_clients_disabled" {
  description = "Disable all alerting rules for blocked_clients detector"
  type        = bool
  default     = null
}

variable "blocked_clients_disabled_minor" {
  description = "Disable minor alerting rule for blocked_clients detector"
  type        = bool
  default     = null
}

variable "blocked_clients_disabled_warning" {
  description = "Disable warning alerting rule for blocked_clients detector"
  type        = bool
  default     = null
}

variable "blocked_clients_notifications" {
  description = "Notification recipients list per severity overridden for blocked_clients detector"
  type        = map(list(string))
  default     = {}
}

variable "blocked_clients_aggregation_function" {
  description = "Aggregation function and group by for blocked_clients detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "blocked_clients_transformation_function" {
  description = "Transformation function for blocked_clients detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".mean(over='1h')"
}

variable "blocked_clients_threshold_minor" {
  description = "minor threshold for blocked_clients detector"
  type        = number
  default     = 5
}

variable "blocked_clients_threshold_warning" {
  description = "warning threshold for blocked_clients detector"
  type        = number
  default     = 0
}

# Keyspace_full detector

variable "keyspace_full_max_delay" {
  description = "Enforce max delay for keyspace_full detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "keyspace_full_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "keyspace_full_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "keyspace_full_disabled" {
  description = "Disable all alerting rules for keyspace_full detector"
  type        = bool
  default     = true
}

variable "keyspace_full_notifications" {
  description = "Notification recipients list per severity overridden for keyspace_full detector"
  type        = map(list(string))
  default     = {}
}

variable "keyspace_full_aggregation_function" {
  description = "Aggregation function and group by for keyspace_full detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "keyspace_full_transformation_function" {
  description = "Transformation function for keyspace_full detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".sum(over='1h')"
}

# Memory_used_max detector

variable "memory_used_max_max_delay" {
  description = "Enforce max delay for memory_used_max detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "memory_used_max_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "memory_used_max_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

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

variable "memory_used_max_disabled_major" {
  description = "Disable major alerting rule for memory_used_max detector"
  type        = bool
  default     = null
}

variable "memory_used_max_notifications" {
  description = "Notification recipients list per severity overridden for memory_used_max detector"
  type        = map(list(string))
  default     = {}
}

variable "memory_used_max_aggregation_function" {
  description = "Aggregation function and group by for memory_used_max detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "memory_used_max_transformation_function" {
  description = "Transformation function for memory_used_max detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='10m')"
}

variable "memory_used_max_threshold_critical" {
  description = "Critical threshold for memory_used_max detector"
  type        = number
  default     = 95
}

variable "memory_used_max_threshold_major" {
  description = "Major threshold for memory_used_max detector"
  type        = number
  default     = 85
}

# Memory_used_total detector

variable "memory_used_total_max_delay" {
  description = "Enforce max delay for memory_used_total detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "memory_used_total_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "memory_used_total_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

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

variable "memory_used_total_disabled_major" {
  description = "Disable major alerting rule for memory_used_total detector"
  type        = bool
  default     = null
}

variable "memory_used_total_notifications" {
  description = "Notification recipients list per severity overridden for memory_used_total detector"
  type        = map(list(string))
  default     = {}
}

variable "memory_used_total_aggregation_function" {
  description = "Aggregation function and group by for memory_used_total detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "memory_used_total_transformation_function" {
  description = "Transformation function for memory_used_total detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='10m')"
}

variable "memory_used_total_threshold_critical" {
  description = "Critical threshold for memory_used_total detector"
  type        = number
  default     = 95
}

variable "memory_used_total_threshold_major" {
  description = "Major threshold for memory_used_total detector"
  type        = number
  default     = 85
}

# Memory_frag_high detector

variable "memory_frag_high_max_delay" {
  description = "Enforce max delay for memory_frag_high detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "memory_frag_high_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "memory_frag_high_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

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

variable "memory_frag_high_disabled_major" {
  description = "Disable major alerting rule for memory_frag_high detector"
  type        = bool
  default     = null
}

variable "memory_frag_high_notifications" {
  description = "Notification recipients list per severity overridden for memory_frag_high detector"
  type        = map(list(string))
  default     = {}
}

variable "memory_frag_high_aggregation_function" {
  description = "Aggregation function and group by for memory_frag_high detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "memory_frag_high_transformation_function" {
  description = "Transformation function for memory_frag_high detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".mean(over='15m')"
}

variable "memory_frag_high_threshold_critical" {
  description = "Critical threshold for memory_frag_high detector"
  type        = number
  default     = 5
}

variable "memory_frag_high_threshold_major" {
  description = "Major threshold for memory_frag_high detector"
  type        = number
  default     = 2
}

# Memory_frag_low detector

variable "memory_frag_low_max_delay" {
  description = "Enforce max delay for memory_frag_low detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "memory_frag_low_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "memory_frag_low_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

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

variable "memory_frag_low_disabled_major" {
  description = "Disable major alerting rule for memory_frag_low detector"
  type        = bool
  default     = null
}

variable "memory_frag_low_notifications" {
  description = "Notification recipients list per severity overridden for memory_frag_low detector"
  type        = map(list(string))
  default     = {}
}

variable "memory_frag_low_aggregation_function" {
  description = "Aggregation function and group by for memory_frag_low detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "memory_frag_low_transformation_function" {
  description = "Transformation function for memory_frag_low detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".mean(over='15m')"
}

variable "memory_frag_low_threshold_critical" {
  description = "Critical threshold for memory_frag_low detector"
  type        = number
  default     = 0.75
}

variable "memory_frag_low_threshold_major" {
  description = "Major threshold for memory_frag_low detector"
  type        = number
  default     = 1
}

# rejected_connections detector

variable "rejected_connections_max_delay" {
  description = "Enforce max delay for rejected_connections detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "rejected_connections_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
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
  default     = "sum(over='5m')"
}

variable "rejected_connections_threshold_critical" {
  description = "Critical threshold for rejected_connections detector"
  type        = number
  default     = 5
}

variable "rejected_connections_threshold_major" {
  description = "Major threshold for rejected_connections detector"
  type        = number
  default     = 0
}

# Hitrate detector

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
  description = "Transformation function for hitrate (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".max(over='5m')"
}

variable "hitrate_threshold_critical" {
  description = "Critical threshold for hitrate detector"
  type        = number
  default     = 10
}

variable "hitrate_threshold_major" {
  description = "Major threshold for hitrate detector"
  type        = number
  default     = 30
}

