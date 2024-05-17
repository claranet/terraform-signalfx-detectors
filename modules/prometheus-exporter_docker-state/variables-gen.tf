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
  description = "Timeframe for heartbeat detector (i.e. \"25m\"). Must be at least \"25m\" if exclude_not_running_vm is true"
  type        = string
  default     = "25m"
}

# state_health_status detector

variable "state_health_status_notifications" {
  description = "Notification recipients list per severity overridden for state_health_status detector"
  type        = map(list(string))
  default     = {}
}

variable "state_health_status_aggregation_function" {
  description = "Aggregation function and group by for state_health_status detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "state_health_status_transformation_function" {
  description = "Transformation function for state_health_status detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='5m')"
}

variable "state_health_status_max_delay" {
  description = "Enforce max delay for state_health_status detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "state_health_status_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "state_health_status_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "state_health_status_disabled" {
  description = "Disable all alerting rules for state_health_status detector"
  type        = bool
  default     = null
}

variable "state_health_status_threshold_critical" {
  description = "Critical threshold for state_health_status detector"
  type        = number
  default     = 0
}

variable "state_health_status_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "state_health_status_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# state_status detector

variable "state_status_notifications" {
  description = "Notification recipients list per severity overridden for state_status detector"
  type        = map(list(string))
  default     = {}
}

variable "state_status_aggregation_function" {
  description = "Aggregation function and group by for state_status detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "state_status_transformation_function" {
  description = "Transformation function for state_status detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='5m')"
}

variable "state_status_max_delay" {
  description = "Enforce max delay for state_status detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "state_status_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "state_status_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "state_status_disabled" {
  description = "Disable all alerting rules for state_status detector"
  type        = bool
  default     = null
}

variable "state_status_threshold_critical" {
  description = "Critical threshold for state_status detector"
  type        = number
  default     = 0
}

variable "state_status_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "state_status_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# state_oom_killed detector

variable "state_oom_killed_notifications" {
  description = "Notification recipients list per severity overridden for state_oom_killed detector"
  type        = map(list(string))
  default     = {}
}

variable "state_oom_killed_aggregation_function" {
  description = "Aggregation function and group by for state_oom_killed detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "state_oom_killed_transformation_function" {
  description = "Transformation function for state_oom_killed detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='5m')"
}

variable "state_oom_killed_max_delay" {
  description = "Enforce max delay for state_oom_killed detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "state_oom_killed_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "state_oom_killed_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "state_oom_killed_disabled" {
  description = "Disable all alerting rules for state_oom_killed detector"
  type        = bool
  default     = null
}

variable "state_oom_killed_threshold_critical" {
  description = "Critical threshold for state_oom_killed detector"
  type        = number
  default     = 0
}

variable "state_oom_killed_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "state_oom_killed_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
