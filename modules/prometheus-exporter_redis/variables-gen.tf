# heartbeat detector

variable "heartbeat_notifications" {
  description = "Notification recipients list per severity overridden for heartbeat detector"
  type        = map(list(string))
  default     = {}
}

variable "heartbeat_aggregation_function" {
  description = "Aggregation function and group by for heartbeat detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".sum(by=['k8s.workload.name', 'k8s.namespace.name', 'k8s.cluster.name'], allow_missing=True)"
}

variable "heartbeat_max_delay" {
  description = "Enforce max delay for heartbeat detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
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

variable "heartbeat_exclude_not_running_vm" {
  description = "Don’t send alerts if associated VM is stopped or stopping (metadata provided by cloud provider integration). Can be useful for ephemeral infrastructure (such as auto scaling groups) as VM will be stopped and started regularly. Note that timeframe must be at least 25 minutes for the metadata to be available to the detector."
  type        = bool
  default     = true
}

variable "heartbeat_timeframe" {
  description = "Timeframe for heartbeat detector (i.e. \"25m\"). Must be at least \"25m\" if \"heartbeat_exclude_not_running_vm\" is true"
  type        = string
  default     = "25m"
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
  default     = ".sum(by=['k8s.workload.name', 'k8s.namespace.name', 'k8s.cluster.name'], allow_missing=True)"
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
# evicted_keys_change_rate detector

variable "evicted_keys_change_rate_notifications" {
  description = "Notification recipients list per severity overridden for evicted_keys_change_rate detector"
  type        = map(list(string))
  default     = {}
}

variable "evicted_keys_change_rate_aggregation_function" {
  description = "Aggregation function and group by for evicted_keys_change_rate detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".sum(by=['k8s.workload.name', 'k8s.namespace.name', 'k8s.cluster.name'], allow_missing=True)"
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
  default     = ".sum(by=['k8s.workload.name', 'k8s.namespace.name', 'k8s.cluster.name'], allow_missing=True)"
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
# rejected_connections detector

variable "rejected_connections_notifications" {
  description = "Notification recipients list per severity overridden for rejected_connections detector"
  type        = map(list(string))
  default     = {}
}

variable "rejected_connections_aggregation_function" {
  description = "Aggregation function and group by for rejected_connections detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".sum(by=['k8s.workload.name', 'k8s.namespace.name', 'k8s.cluster.name'], allow_missing=True)"
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
