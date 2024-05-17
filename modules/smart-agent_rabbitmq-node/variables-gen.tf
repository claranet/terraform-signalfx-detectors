# heartbeat detector

variable "heartbeat_notifications" {
  description = "Notification recipients list per severity overridden for heartbeat detector"
  type        = map(list(string))
  default     = {}
}

variable "heartbeat_aggregation_function" {
  description = "Aggregation function and group by for heartbeat detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['name'])"
}

variable "heartbeat_transformation_function" {
  description = "Transformation function for heartbeat detector (i.e. \".mean(over='5m')\")"
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
  description = "Timeframe for heartbeat detector (i.e. \"25m\"). Must be at least \"25m\" if exclude_not_running_vm is true"
  type        = string
  default     = "25m"
}

# file_descriptors detector

variable "file_descriptors_notifications" {
  description = "Notification recipients list per severity overridden for file_descriptors detector"
  type        = map(list(string))
  default     = {}
}

variable "file_descriptors_aggregation_function" {
  description = "Aggregation function and group by for file_descriptors detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['name'])"
}

variable "file_descriptors_transformation_function" {
  description = "Transformation function for file_descriptors detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='10m')"
}

variable "file_descriptors_max_delay" {
  description = "Enforce max delay for file_descriptors detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "file_descriptors_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "file_descriptors_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "file_descriptors_disabled" {
  description = "Disable all alerting rules for file_descriptors detector"
  type        = bool
  default     = null
}

variable "file_descriptors_disabled_critical" {
  description = "Disable critical alerting rule for file_descriptors detector"
  type        = bool
  default     = null
}

variable "file_descriptors_disabled_major" {
  description = "Disable major alerting rule for file_descriptors detector"
  type        = bool
  default     = null
}

variable "file_descriptors_threshold_critical" {
  description = "Critical threshold for file_descriptors detector"
  type        = number
  default     = 90
}

variable "file_descriptors_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "file_descriptors_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "file_descriptors_threshold_major" {
  description = "Major threshold for file_descriptors detector"
  type        = number
  default     = 80
}

variable "file_descriptors_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "file_descriptors_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# processes detector

variable "processes_notifications" {
  description = "Notification recipients list per severity overridden for processes detector"
  type        = map(list(string))
  default     = {}
}

variable "processes_aggregation_function" {
  description = "Aggregation function and group by for processes detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['name'])"
}

variable "processes_transformation_function" {
  description = "Transformation function for processes detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='10m')"
}

variable "processes_max_delay" {
  description = "Enforce max delay for processes detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "processes_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "processes_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "processes_disabled" {
  description = "Disable all alerting rules for processes detector"
  type        = bool
  default     = null
}

variable "processes_disabled_critical" {
  description = "Disable critical alerting rule for processes detector"
  type        = bool
  default     = null
}

variable "processes_disabled_major" {
  description = "Disable major alerting rule for processes detector"
  type        = bool
  default     = null
}

variable "processes_threshold_critical" {
  description = "Critical threshold for processes detector"
  type        = number
  default     = 90
}

variable "processes_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "processes_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "processes_threshold_major" {
  description = "Major threshold for processes detector"
  type        = number
  default     = 80
}

variable "processes_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "processes_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# sockets detector

variable "sockets_notifications" {
  description = "Notification recipients list per severity overridden for sockets detector"
  type        = map(list(string))
  default     = {}
}

variable "sockets_aggregation_function" {
  description = "Aggregation function and group by for sockets detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['name'])"
}

variable "sockets_transformation_function" {
  description = "Transformation function for sockets detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='10m')"
}

variable "sockets_max_delay" {
  description = "Enforce max delay for sockets detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "sockets_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "sockets_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "sockets_disabled" {
  description = "Disable all alerting rules for sockets detector"
  type        = bool
  default     = null
}

variable "sockets_disabled_critical" {
  description = "Disable critical alerting rule for sockets detector"
  type        = bool
  default     = null
}

variable "sockets_disabled_major" {
  description = "Disable major alerting rule for sockets detector"
  type        = bool
  default     = null
}

variable "sockets_threshold_critical" {
  description = "Critical threshold for sockets detector"
  type        = number
  default     = 90
}

variable "sockets_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "sockets_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "sockets_threshold_major" {
  description = "Major threshold for sockets detector"
  type        = number
  default     = 80
}

variable "sockets_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "sockets_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# vm_memory detector

variable "vm_memory_notifications" {
  description = "Notification recipients list per severity overridden for vm_memory detector"
  type        = map(list(string))
  default     = {}
}

variable "vm_memory_aggregation_function" {
  description = "Aggregation function and group by for vm_memory detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['name'])"
}

variable "vm_memory_transformation_function" {
  description = "Transformation function for vm_memory detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='10m')"
}

variable "vm_memory_max_delay" {
  description = "Enforce max delay for vm_memory detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "vm_memory_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "vm_memory_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "vm_memory_disabled" {
  description = "Disable all alerting rules for vm_memory detector"
  type        = bool
  default     = null
}

variable "vm_memory_disabled_critical" {
  description = "Disable critical alerting rule for vm_memory detector"
  type        = bool
  default     = null
}

variable "vm_memory_disabled_major" {
  description = "Disable major alerting rule for vm_memory detector"
  type        = bool
  default     = null
}

variable "vm_memory_threshold_critical" {
  description = "Critical threshold for vm_memory detector"
  type        = number
  default     = 90
}

variable "vm_memory_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "vm_memory_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "vm_memory_threshold_major" {
  description = "Major threshold for vm_memory detector"
  type        = number
  default     = 80
}

variable "vm_memory_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "vm_memory_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
