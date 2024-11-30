# capacity detector

variable "capacity_notifications" {
  description = "Notification recipients list per severity overridden for capacity detector"
  type        = map(list(string))
  default     = {}
}

variable "capacity_aggregation_function" {
  description = "Aggregation function and group by for capacity detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".fill(None, duration='1d').mean(by=['fileshare', 'azure_resource_id'])"
}

variable "capacity_transformation_function" {
  description = "Transformation function for capacity detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='1d')"
}

variable "capacity_max_delay" {
  description = "Enforce max delay for capacity detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "capacity_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "capacity_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "capacity_disabled" {
  description = "Disable all alerting rules for capacity detector"
  type        = bool
  default     = null
}

variable "capacity_disabled_critical" {
  description = "Disable critical alerting rule for capacity detector"
  type        = bool
  default     = null
}

variable "capacity_disabled_major" {
  description = "Disable major alerting rule for capacity detector"
  type        = bool
  default     = null
}

variable "capacity_threshold_critical" {
  description = "Critical threshold for capacity detector in %"
  type        = number
  default     = 95
}

variable "capacity_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "capacity_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "capacity_threshold_major" {
  description = "Major threshold for capacity detector in %"
  type        = number
  default     = 90
}

variable "capacity_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "capacity_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# iops detector

variable "iops_notifications" {
  description = "Notification recipients list per severity overridden for iops detector"
  type        = map(list(string))
  default     = {}
}

variable "iops_aggregation_function" {
  description = "Aggregation function and group by for iops detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".sum(by=['FileShare', 'azure_resource_id'])"
}

variable "iops_transformation_function" {
  description = "Transformation function for iops detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='15m')"
}

variable "iops_max_delay" {
  description = "Enforce max delay for iops detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "iops_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "iops_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "iops_disabled" {
  description = "Disable all alerting rules for iops detector"
  type        = bool
  default     = null
}

variable "iops_disabled_critical" {
  description = "Disable critical alerting rule for iops detector"
  type        = bool
  default     = null
}

variable "iops_disabled_major" {
  description = "Disable major alerting rule for iops detector"
  type        = bool
  default     = null
}

variable "iops_threshold_critical" {
  description = "Critical threshold for iops detector in %"
  type        = number
  default     = 95
}

variable "iops_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "iops_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "iops_threshold_major" {
  description = "Major threshold for iops detector in %"
  type        = number
  default     = 90
}

variable "iops_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "iops_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# throughput detector

variable "throughput_notifications" {
  description = "Notification recipients list per severity overridden for throughput detector"
  type        = map(list(string))
  default     = {}
}

variable "throughput_aggregation_function" {
  description = "Aggregation function and group by for throughput detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".sum(by=['FileShare', 'azure_resource_id'])"
}

variable "throughput_transformation_function" {
  description = "Transformation function for throughput detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='15m')"
}

variable "throughput_max_delay" {
  description = "Enforce max delay for throughput detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "throughput_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "throughput_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "throughput_disabled" {
  description = "Disable all alerting rules for throughput detector"
  type        = bool
  default     = null
}

variable "throughput_disabled_critical" {
  description = "Disable critical alerting rule for throughput detector"
  type        = bool
  default     = null
}

variable "throughput_disabled_major" {
  description = "Disable major alerting rule for throughput detector"
  type        = bool
  default     = null
}

variable "throughput_threshold_critical" {
  description = "Critical threshold for throughput detector in %"
  type        = number
  default     = 95
}

variable "throughput_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "throughput_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "throughput_threshold_major" {
  description = "Major threshold for throughput detector in %"
  type        = number
  default     = 90
}

variable "throughput_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "throughput_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# throttling detector

variable "throttling_notifications" {
  description = "Notification recipients list per severity overridden for throttling detector"
  type        = map(list(string))
  default     = {}
}

variable "throttling_aggregation_function" {
  description = "Aggregation function and group by for throttling detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".sum(by=['FileShare', 'azure_resource_id'])"
}

variable "throttling_transformation_function" {
  description = "Transformation function for throttling detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='15m')"
}

variable "throttling_max_delay" {
  description = "Enforce max delay for throttling detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "throttling_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "throttling_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "throttling_disabled" {
  description = "Disable all alerting rules for throttling detector"
  type        = bool
  default     = null
}

variable "throttling_disabled_critical" {
  description = "Disable critical alerting rule for throttling detector"
  type        = bool
  default     = null
}

variable "throttling_disabled_major" {
  description = "Disable major alerting rule for throttling detector"
  type        = bool
  default     = null
}

variable "throttling_threshold_critical" {
  description = "Critical threshold for throttling detector in %"
  type        = number
  default     = 15
}

variable "throttling_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "throttling_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "throttling_threshold_major" {
  description = "Major threshold for throttling detector in %"
  type        = number
  default     = 0
}

variable "throttling_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "throttling_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# no_snapshots detector

variable "no_snapshots_notifications" {
  description = "Notification recipients list per severity overridden for no_snapshots detector"
  type        = map(list(string))
  default     = {}
}

variable "no_snapshots_max_delay" {
  description = "Enforce max delay for no_snapshots detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "no_snapshots_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "no_snapshots_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "no_snapshots_disabled" {
  description = "Disable all alerting rules for no_snapshots detector"
  type        = bool
  default     = null
}

variable "no_snapshots_threshold_major" {
  description = "Major threshold for no_snapshots detector"
  type        = number
  default     = 1
}

variable "no_snapshots_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "no_snapshots_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# snapshots_limit detector

variable "snapshots_limit_notifications" {
  description = "Notification recipients list per severity overridden for snapshots_limit detector"
  type        = map(list(string))
  default     = {}
}

variable "snapshots_limit_max_delay" {
  description = "Enforce max delay for snapshots_limit detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "snapshots_limit_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "snapshots_limit_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "snapshots_limit_disabled" {
  description = "Disable all alerting rules for snapshots_limit detector"
  type        = bool
  default     = null
}

variable "snapshots_limit_threshold_major" {
  description = "Major threshold for snapshots_limit detector"
  type        = number
  default     = 190
}

variable "snapshots_limit_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "snapshots_limit_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
