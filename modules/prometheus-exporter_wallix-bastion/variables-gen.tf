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
  description = "Timeframe for heartbeat detector (i.e. \"25m\"). Must be at least \"25m\" if \"heartbeat_exclude_not_running_vm\" is true"
  type        = string
  default     = "25m"
}

# status detector

variable "status_notifications" {
  description = "Notification recipients list per severity overridden for status detector"
  type        = map(list(string))
  default     = {}
}

variable "status_aggregation_function" {
  description = "Aggregation function and group by for status detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "status_transformation_function" {
  description = "Transformation function for status detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "status_max_delay" {
  description = "Enforce max delay for status detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "status_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "status_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "status_disabled" {
  description = "Disable all alerting rules for status detector"
  type        = bool
  default     = null
}

variable "status_threshold_critical" {
  description = "Critical threshold for status detector"
  type        = number
  default     = 1
}

variable "status_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "5m"
}

variable "status_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# current_sessions detector

variable "current_sessions_notifications" {
  description = "Notification recipients list per severity overridden for current_sessions detector"
  type        = map(list(string))
  default     = {}
}

variable "current_sessions_aggregation_function" {
  description = "Aggregation function and group by for current_sessions detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "current_sessions_transformation_function" {
  description = "Transformation function for current_sessions detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".mean(over='5m')"
}

variable "current_sessions_max_delay" {
  description = "Enforce max delay for current_sessions detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "current_sessions_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "current_sessions_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "current_sessions_disabled" {
  description = "Disable all alerting rules for current_sessions detector"
  type        = bool
  default     = null
}

variable "current_sessions_disabled_major" {
  description = "Disable major alerting rule for current_sessions detector"
  type        = bool
  default     = null
}

variable "current_sessions_disabled_minor" {
  description = "Disable minor alerting rule for current_sessions detector"
  type        = bool
  default     = null
}

variable "current_sessions_threshold_major" {
  description = "Major threshold for current_sessions detector"
  type        = number
  default     = 75
}

variable "current_sessions_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "current_sessions_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "current_sessions_threshold_minor" {
  description = "Minor threshold for current_sessions detector"
  type        = number
  default     = 50
}

variable "current_sessions_lasting_duration_minor" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "current_sessions_at_least_percentage_minor" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# encryption_status detector

variable "encryption_status_notifications" {
  description = "Notification recipients list per severity overridden for encryption_status detector"
  type        = map(list(string))
  default     = {}
}

variable "encryption_status_aggregation_function" {
  description = "Aggregation function and group by for encryption_status detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "encryption_status_transformation_function" {
  description = "Transformation function for encryption_status detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "encryption_status_max_delay" {
  description = "Enforce max delay for encryption_status detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "encryption_status_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "encryption_status_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "encryption_status_disabled" {
  description = "Disable all alerting rules for encryption_status detector"
  type        = bool
  default     = null
}

variable "encryption_status_threshold_critical" {
  description = "Critical threshold for encryption_status detector"
  type        = number
  default     = 1
}

variable "encryption_status_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "encryption_status_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# license detector

variable "license_notifications" {
  description = "Notification recipients list per severity overridden for license detector"
  type        = map(list(string))
  default     = {}
}

variable "license_aggregation_function" {
  description = "Aggregation function and group by for license detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "license_transformation_function" {
  description = "Transformation function for license detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "license_max_delay" {
  description = "Enforce max delay for license detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "license_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "license_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "license_disabled" {
  description = "Disable all alerting rules for license detector"
  type        = bool
  default     = null
}

variable "license_threshold_critical" {
  description = "Critical threshold for license detector"
  type        = number
  default     = 0
}

variable "license_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "license_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
