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

# clamav_queue_length detector

variable "clamav_queue_length_notifications" {
  description = "Notification recipients list per severity overridden for clamav_queue_length detector"
  type        = map(list(string))
  default     = {}
}

variable "clamav_queue_length_aggregation_function" {
  description = "Aggregation function and group by for clamav_queue_length detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "clamav_queue_length_transformation_function" {
  description = "Transformation function for clamav_queue_length detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "clamav_queue_length_max_delay" {
  description = "Enforce max delay for clamav_queue_length detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "clamav_queue_length_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "clamav_queue_length_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "clamav_queue_length_disabled" {
  description = "Disable all alerting rules for clamav_queue_length detector"
  type        = bool
  default     = null
}

variable "clamav_queue_length_threshold_critical" {
  description = "Critical threshold for clamav_queue_length detector"
  type        = number
  default     = 100
}

variable "clamav_queue_length_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "15m"
}

variable "clamav_queue_length_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
