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

# treatment_limit detector

variable "treatment_limit_notifications" {
  description = "Notification recipients list per severity overridden for treatment_limit detector"
  type        = map(list(string))
  default     = {}
}

variable "treatment_limit_aggregation_function" {
  description = "Aggregation function and group by for treatment_limit detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "treatment_limit_transformation_function" {
  description = "Transformation function for treatment_limit detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='15m')"
}

variable "treatment_limit_max_delay" {
  description = "Enforce max delay for treatment_limit detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "treatment_limit_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "treatment_limit_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "treatment_limit_disabled" {
  description = "Disable all alerting rules for treatment_limit detector"
  type        = bool
  default     = null
}

variable "treatment_limit_disabled_critical" {
  description = "Disable critical alerting rule for treatment_limit detector"
  type        = bool
  default     = null
}

variable "treatment_limit_disabled_major" {
  description = "Disable major alerting rule for treatment_limit detector"
  type        = bool
  default     = null
}

variable "treatment_limit_threshold_critical" {
  description = "Critical threshold for treatment_limit detector"
  type        = number
  default     = 20
}

variable "treatment_limit_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "treatment_limit_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "treatment_limit_threshold_major" {
  description = "Major threshold for treatment_limit detector"
  type        = number
  default     = 0
}

variable "treatment_limit_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "treatment_limit_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
