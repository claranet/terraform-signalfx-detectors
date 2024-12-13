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

# cpu detector

variable "cpu_notifications" {
  description = "Notification recipients list per severity overridden for cpu detector"
  type        = map(list(string))
  default     = {}
}

variable "cpu_aggregation_function" {
  description = "Aggregation function and group by for cpu detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "cpu_transformation_function" {
  description = "Transformation function for cpu detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "cpu_max_delay" {
  description = "Enforce max delay for cpu detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "cpu_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "cpu_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "cpu_disabled" {
  description = "Disable all alerting rules for cpu detector"
  type        = bool
  default     = null
}

variable "cpu_disabled_critical" {
  description = "Disable critical alerting rule for cpu detector"
  type        = bool
  default     = null
}

variable "cpu_disabled_major" {
  description = "Disable major alerting rule for cpu detector"
  type        = bool
  default     = null
}

variable "cpu_threshold_critical" {
  description = "Critical threshold for cpu detector in %"
  type        = number
  default     = 90
}

variable "cpu_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "1h"
}

variable "cpu_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "cpu_threshold_major" {
  description = "Major threshold for cpu detector in %"
  type        = number
  default     = 85
}

variable "cpu_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "1h"
}

variable "cpu_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# load detector

variable "load_notifications" {
  description = "Notification recipients list per severity overridden for load detector"
  type        = map(list(string))
  default     = {}
}

variable "load_aggregation_function" {
  description = "Aggregation function and group by for load detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "load_transformation_function" {
  description = "Transformation function for load detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "load_max_delay" {
  description = "Enforce max delay for load detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "load_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "load_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "load_disabled" {
  description = "Disable all alerting rules for load detector"
  type        = bool
  default     = null
}

variable "load_disabled_critical" {
  description = "Disable critical alerting rule for load detector"
  type        = bool
  default     = null
}

variable "load_disabled_major" {
  description = "Disable major alerting rule for load detector"
  type        = bool
  default     = null
}

variable "load_threshold_critical" {
  description = "Critical threshold for load detector"
  type        = number
  default     = 2.5
}

variable "load_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "30m"
}

variable "load_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "load_threshold_major" {
  description = "Major threshold for load detector"
  type        = number
  default     = 2
}

variable "load_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "30m"
}

variable "load_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# disk_space detector

variable "disk_space_notifications" {
  description = "Notification recipients list per severity overridden for disk_space detector"
  type        = map(list(string))
  default     = {}
}

variable "disk_space_aggregation_function" {
  description = "Aggregation function and group by for disk_space detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "disk_space_transformation_function" {
  description = "Transformation function for disk_space detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "disk_space_max_delay" {
  description = "Enforce max delay for disk_space detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "disk_space_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "disk_space_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "disk_space_disabled" {
  description = "Disable all alerting rules for disk_space detector"
  type        = bool
  default     = null
}

variable "disk_space_disabled_critical" {
  description = "Disable critical alerting rule for disk_space detector"
  type        = bool
  default     = null
}

variable "disk_space_disabled_major" {
  description = "Disable major alerting rule for disk_space detector"
  type        = bool
  default     = null
}

variable "disk_space_threshold_critical" {
  description = "Critical threshold for disk_space detector in %"
  type        = number
  default     = 90
}

variable "disk_space_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "5m"
}

variable "disk_space_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "disk_space_threshold_major" {
  description = "Major threshold for disk_space detector in %"
  type        = number
  default     = 80
}

variable "disk_space_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "5m"
}

variable "disk_space_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# filesystem_inodes detector

variable "filesystem_inodes_notifications" {
  description = "Notification recipients list per severity overridden for filesystem_inodes detector"
  type        = map(list(string))
  default     = {}
}

variable "filesystem_inodes_aggregation_function" {
  description = "Aggregation function and group by for filesystem_inodes detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "filesystem_inodes_transformation_function" {
  description = "Transformation function for filesystem_inodes detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "filesystem_inodes_max_delay" {
  description = "Enforce max delay for filesystem_inodes detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "filesystem_inodes_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "filesystem_inodes_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "filesystem_inodes_disabled" {
  description = "Disable all alerting rules for filesystem_inodes detector"
  type        = bool
  default     = null
}

variable "filesystem_inodes_disabled_critical" {
  description = "Disable critical alerting rule for filesystem_inodes detector"
  type        = bool
  default     = null
}

variable "filesystem_inodes_disabled_major" {
  description = "Disable major alerting rule for filesystem_inodes detector"
  type        = bool
  default     = null
}

variable "filesystem_inodes_threshold_critical" {
  description = "Critical threshold for filesystem_inodes detector in %"
  type        = number
  default     = 95
}

variable "filesystem_inodes_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "5m"
}

variable "filesystem_inodes_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "filesystem_inodes_threshold_major" {
  description = "Major threshold for filesystem_inodes detector in %"
  type        = number
  default     = 90
}

variable "filesystem_inodes_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "5m"
}

variable "filesystem_inodes_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# disk_inodes detector

variable "disk_inodes_notifications" {
  description = "Notification recipients list per severity overridden for disk_inodes detector"
  type        = map(list(string))
  default     = {}
}

variable "disk_inodes_aggregation_function" {
  description = "Aggregation function and group by for disk_inodes detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "disk_inodes_transformation_function" {
  description = "Transformation function for disk_inodes detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "disk_inodes_max_delay" {
  description = "Enforce max delay for disk_inodes detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "disk_inodes_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "disk_inodes_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "disk_inodes_disabled" {
  description = "Disable all alerting rules for disk_inodes detector"
  type        = bool
  default     = null
}

variable "disk_inodes_disabled_critical" {
  description = "Disable critical alerting rule for disk_inodes detector"
  type        = bool
  default     = null
}

variable "disk_inodes_disabled_major" {
  description = "Disable major alerting rule for disk_inodes detector"
  type        = bool
  default     = null
}

variable "disk_inodes_threshold_critical" {
  description = "Critical threshold for disk_inodes detector in %"
  type        = number
  default     = 95
}

variable "disk_inodes_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "5m"
}

variable "disk_inodes_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "disk_inodes_threshold_major" {
  description = "Major threshold for disk_inodes detector in %"
  type        = number
  default     = 90
}

variable "disk_inodes_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "5m"
}

variable "disk_inodes_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# memory detector

variable "memory_notifications" {
  description = "Notification recipients list per severity overridden for memory detector"
  type        = map(list(string))
  default     = {}
}

variable "memory_aggregation_function" {
  description = "Aggregation function and group by for memory detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "memory_transformation_function" {
  description = "Transformation function for memory detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "memory_max_delay" {
  description = "Enforce max delay for memory detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "memory_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "memory_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "memory_disabled" {
  description = "Disable all alerting rules for memory detector"
  type        = bool
  default     = null
}

variable "memory_disabled_critical" {
  description = "Disable critical alerting rule for memory detector"
  type        = bool
  default     = null
}

variable "memory_disabled_major" {
  description = "Disable major alerting rule for memory detector"
  type        = bool
  default     = null
}

variable "memory_threshold_critical" {
  description = "Critical threshold for memory detector in %"
  type        = number
  default     = 95
}

variable "memory_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "5m"
}

variable "memory_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "memory_threshold_major" {
  description = "Major threshold for memory detector in %"
  type        = number
  default     = 90
}

variable "memory_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "5m"
}

variable "memory_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# swap_io detector

variable "swap_io_notifications" {
  description = "Notification recipients list per severity overridden for swap_io detector"
  type        = map(list(string))
  default     = {}
}

variable "swap_io_aggregation_function" {
  description = "Aggregation function and group by for swap_io detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "swap_io_transformation_function" {
  description = "Transformation function for swap_io detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "swap_io_max_delay" {
  description = "Enforce max delay for swap_io detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "swap_io_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = <<-EOF
    There not enough RAM on the host, either increase the RAM or decrease the memory pressure (by stopping or throttling some process)
EOF
}

variable "swap_io_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "swap_io_disabled" {
  description = "Disable all alerting rules for swap_io detector"
  type        = bool
  default     = true
}

variable "swap_io_disabled_critical" {
  description = "Disable critical alerting rule for swap_io detector"
  type        = bool
  default     = null
}

variable "swap_io_disabled_major" {
  description = "Disable major alerting rule for swap_io detector"
  type        = bool
  default     = null
}

variable "swap_io_threshold_critical" {
  description = "Critical threshold for swap_io detector in iops"
  type        = number
  default     = 400
}

variable "swap_io_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "10m"
}

variable "swap_io_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 0.5
}
variable "swap_io_threshold_major" {
  description = "Major threshold for swap_io detector in iops"
  type        = number
  default     = 200
}

variable "swap_io_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "10m"
}

variable "swap_io_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 0.5
}
