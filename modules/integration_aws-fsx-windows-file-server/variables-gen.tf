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

# free_space detector

variable "free_space_notifications" {
  description = "Notification recipients list per severity overridden for free_space detector"
  type        = map(list(string))
  default     = {}
}

variable "free_space_aggregation_function" {
  description = "Aggregation function and group by for free_space detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "free_space_transformation_function" {
  description = "Transformation function for free_space detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".max(over='15m')"
}

variable "free_space_max_delay" {
  description = "Enforce max delay for free_space detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "free_space_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "free_space_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "free_space_disabled" {
  description = "Disable all alerting rules for free_space detector"
  type        = bool
  default     = null
}

variable "free_space_disabled_critical" {
  description = "Disable critical alerting rule for free_space detector"
  type        = bool
  default     = null
}

variable "free_space_disabled_major" {
  description = "Disable major alerting rule for free_space detector"
  type        = bool
  default     = null
}

variable "free_space_threshold_critical" {
  description = "Critical threshold for free_space detector in Gibibyte"
  type        = number
}

variable "free_space_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "free_space_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "free_space_threshold_major" {
  description = "Major threshold for free_space detector in Gibibyte"
  type        = number
}

variable "free_space_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "free_space_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# cpu_utilization detector

variable "cpu_utilization_notifications" {
  description = "Notification recipients list per severity overridden for cpu_utilization detector"
  type        = map(list(string))
  default     = {}
}

variable "cpu_utilization_aggregation_function" {
  description = "Aggregation function and group by for cpu_utilization detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "cpu_utilization_transformation_function" {
  description = "Transformation function for cpu_utilization detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".max(over='15m')"
}

variable "cpu_utilization_max_delay" {
  description = "Enforce max delay for cpu_utilization detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "cpu_utilization_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "cpu_utilization_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "cpu_utilization_disabled" {
  description = "Disable all alerting rules for cpu_utilization detector"
  type        = bool
  default     = null
}

variable "cpu_utilization_disabled_major" {
  description = "Disable major alerting rule for cpu_utilization detector"
  type        = bool
  default     = null
}

variable "cpu_utilization_disabled_critical" {
  description = "Disable critical alerting rule for cpu_utilization detector"
  type        = bool
  default     = null
}

variable "cpu_utilization_threshold_major" {
  description = "Major threshold for cpu_utilization detector in %"
  type        = number
  default     = 60
}

variable "cpu_utilization_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "cpu_utilization_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "cpu_utilization_threshold_critical" {
  description = "Critical threshold for cpu_utilization detector in %"
  type        = number
  default     = 80
}

variable "cpu_utilization_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "cpu_utilization_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# memory_utilization detector

variable "memory_utilization_notifications" {
  description = "Notification recipients list per severity overridden for memory_utilization detector"
  type        = map(list(string))
  default     = {}
}

variable "memory_utilization_aggregation_function" {
  description = "Aggregation function and group by for memory_utilization detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "memory_utilization_transformation_function" {
  description = "Transformation function for memory_utilization detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".max(over='15m')"
}

variable "memory_utilization_max_delay" {
  description = "Enforce max delay for memory_utilization detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "memory_utilization_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "memory_utilization_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "memory_utilization_disabled" {
  description = "Disable all alerting rules for memory_utilization detector"
  type        = bool
  default     = null
}

variable "memory_utilization_disabled_major" {
  description = "Disable major alerting rule for memory_utilization detector"
  type        = bool
  default     = null
}

variable "memory_utilization_disabled_critical" {
  description = "Disable critical alerting rule for memory_utilization detector"
  type        = bool
  default     = null
}

variable "memory_utilization_threshold_major" {
  description = "Major threshold for memory_utilization detector in %"
  type        = number
  default     = 60
}

variable "memory_utilization_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "memory_utilization_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "memory_utilization_threshold_critical" {
  description = "Critical threshold for memory_utilization detector in %"
  type        = number
  default     = 80
}

variable "memory_utilization_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "memory_utilization_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# network_throughput_utilization detector

variable "network_throughput_utilization_notifications" {
  description = "Notification recipients list per severity overridden for network_throughput_utilization detector"
  type        = map(list(string))
  default     = {}
}

variable "network_throughput_utilization_aggregation_function" {
  description = "Aggregation function and group by for network_throughput_utilization detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "network_throughput_utilization_transformation_function" {
  description = "Transformation function for network_throughput_utilization detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".max(over='15m')"
}

variable "network_throughput_utilization_max_delay" {
  description = "Enforce max delay for network_throughput_utilization detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "network_throughput_utilization_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "network_throughput_utilization_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "network_throughput_utilization_disabled" {
  description = "Disable all alerting rules for network_throughput_utilization detector"
  type        = bool
  default     = null
}

variable "network_throughput_utilization_disabled_major" {
  description = "Disable major alerting rule for network_throughput_utilization detector"
  type        = bool
  default     = null
}

variable "network_throughput_utilization_disabled_critical" {
  description = "Disable critical alerting rule for network_throughput_utilization detector"
  type        = bool
  default     = null
}

variable "network_throughput_utilization_threshold_major" {
  description = "Major threshold for network_throughput_utilization detector in %"
  type        = number
  default     = 60
}

variable "network_throughput_utilization_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "network_throughput_utilization_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "network_throughput_utilization_threshold_critical" {
  description = "Critical threshold for network_throughput_utilization detector in %"
  type        = number
  default     = 80
}

variable "network_throughput_utilization_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "network_throughput_utilization_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# file_server_disk_throughput_utilization detector

variable "file_server_disk_throughput_utilization_notifications" {
  description = "Notification recipients list per severity overridden for file_server_disk_throughput_utilization detector"
  type        = map(list(string))
  default     = {}
}

variable "file_server_disk_throughput_utilization_aggregation_function" {
  description = "Aggregation function and group by for file_server_disk_throughput_utilization detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "file_server_disk_throughput_utilization_transformation_function" {
  description = "Transformation function for file_server_disk_throughput_utilization detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".max(over='15m')"
}

variable "file_server_disk_throughput_utilization_max_delay" {
  description = "Enforce max delay for file_server_disk_throughput_utilization detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "file_server_disk_throughput_utilization_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "file_server_disk_throughput_utilization_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "file_server_disk_throughput_utilization_disabled" {
  description = "Disable all alerting rules for file_server_disk_throughput_utilization detector"
  type        = bool
  default     = null
}

variable "file_server_disk_throughput_utilization_disabled_major" {
  description = "Disable major alerting rule for file_server_disk_throughput_utilization detector"
  type        = bool
  default     = null
}

variable "file_server_disk_throughput_utilization_disabled_critical" {
  description = "Disable critical alerting rule for file_server_disk_throughput_utilization detector"
  type        = bool
  default     = null
}

variable "file_server_disk_throughput_utilization_threshold_major" {
  description = "Major threshold for file_server_disk_throughput_utilization detector in %"
  type        = number
  default     = 60
}

variable "file_server_disk_throughput_utilization_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "file_server_disk_throughput_utilization_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "file_server_disk_throughput_utilization_threshold_critical" {
  description = "Critical threshold for file_server_disk_throughput_utilization detector in %"
  type        = number
  default     = 80
}

variable "file_server_disk_throughput_utilization_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "file_server_disk_throughput_utilization_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# storage_capacity_utilization detector

variable "storage_capacity_utilization_notifications" {
  description = "Notification recipients list per severity overridden for storage_capacity_utilization detector"
  type        = map(list(string))
  default     = {}
}

variable "storage_capacity_utilization_aggregation_function" {
  description = "Aggregation function and group by for storage_capacity_utilization detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "storage_capacity_utilization_transformation_function" {
  description = "Transformation function for storage_capacity_utilization detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".max(over='15m')"
}

variable "storage_capacity_utilization_max_delay" {
  description = "Enforce max delay for storage_capacity_utilization detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "storage_capacity_utilization_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "storage_capacity_utilization_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "storage_capacity_utilization_disabled" {
  description = "Disable all alerting rules for storage_capacity_utilization detector"
  type        = bool
  default     = null
}

variable "storage_capacity_utilization_disabled_major" {
  description = "Disable major alerting rule for storage_capacity_utilization detector"
  type        = bool
  default     = null
}

variable "storage_capacity_utilization_disabled_critical" {
  description = "Disable critical alerting rule for storage_capacity_utilization detector"
  type        = bool
  default     = null
}

variable "storage_capacity_utilization_threshold_major" {
  description = "Major threshold for storage_capacity_utilization detector in %"
  type        = number
  default     = 80
}

variable "storage_capacity_utilization_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "storage_capacity_utilization_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "storage_capacity_utilization_threshold_critical" {
  description = "Critical threshold for storage_capacity_utilization detector in %"
  type        = number
  default     = 90
}

variable "storage_capacity_utilization_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "storage_capacity_utilization_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
