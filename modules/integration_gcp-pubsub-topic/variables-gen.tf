# sending_operations detector

variable "sending_operations_notifications" {
  description = "Notification recipients list per severity overridden for sending_operations detector"
  type        = map(list(string))
  default     = {}
}

variable "sending_operations_aggregation_function" {
  description = "Aggregation function and group by for sending_operations detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "sending_operations_transformation_function" {
  description = "Transformation function for sending_operations detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".sum(over='30m')"
}

variable "sending_operations_max_delay" {
  description = "Enforce max delay for sending_operations detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "sending_operations_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "sending_operations_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "sending_operations_disabled" {
  description = "Disable all alerting rules for sending_operations detector"
  type        = bool
  default     = null
}

variable "sending_operations_threshold_major" {
  description = "Major threshold for sending_operations detector"
  type        = number
  default     = 1
}

variable "sending_operations_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "sending_operations_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# unavailable_sending_operations detector

variable "unavailable_sending_operations_notifications" {
  description = "Notification recipients list per severity overridden for unavailable_sending_operations detector"
  type        = map(list(string))
  default     = {}
}

variable "unavailable_sending_operations_aggregation_function" {
  description = "Aggregation function and group by for unavailable_sending_operations detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "unavailable_sending_operations_transformation_function" {
  description = "Transformation function for unavailable_sending_operations detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".sum(over='15m')"
}

variable "unavailable_sending_operations_max_delay" {
  description = "Enforce max delay for unavailable_sending_operations detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "unavailable_sending_operations_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "unavailable_sending_operations_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "unavailable_sending_operations_disabled" {
  description = "Disable all alerting rules for unavailable_sending_operations detector"
  type        = bool
  default     = null
}

variable "unavailable_sending_operations_disabled_critical" {
  description = "Disable critical alerting rule for unavailable_sending_operations detector"
  type        = bool
  default     = null
}

variable "unavailable_sending_operations_disabled_major" {
  description = "Disable major alerting rule for unavailable_sending_operations detector"
  type        = bool
  default     = null
}

variable "unavailable_sending_operations_threshold_critical" {
  description = "Critical threshold for unavailable_sending_operations detector"
  type        = number
  default     = 5
}

variable "unavailable_sending_operations_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "unavailable_sending_operations_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "unavailable_sending_operations_threshold_major" {
  description = "Major threshold for unavailable_sending_operations detector"
  type        = number
  default     = 0
}

variable "unavailable_sending_operations_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "unavailable_sending_operations_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# unavailable_sending_operations_ratio detector

variable "unavailable_sending_operations_ratio_notifications" {
  description = "Notification recipients list per severity overridden for unavailable_sending_operations_ratio detector"
  type        = map(list(string))
  default     = {}
}

variable "unavailable_sending_operations_ratio_aggregation_function" {
  description = "Aggregation function and group by for unavailable_sending_operations_ratio detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "unavailable_sending_operations_ratio_transformation_function" {
  description = "Transformation function for unavailable_sending_operations_ratio detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".sum(over='15m')"
}

variable "unavailable_sending_operations_ratio_max_delay" {
  description = "Enforce max delay for unavailable_sending_operations_ratio detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "unavailable_sending_operations_ratio_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "unavailable_sending_operations_ratio_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "unavailable_sending_operations_ratio_disabled" {
  description = "Disable all alerting rules for unavailable_sending_operations_ratio detector"
  type        = bool
  default     = null
}

variable "unavailable_sending_operations_ratio_disabled_critical" {
  description = "Disable critical alerting rule for unavailable_sending_operations_ratio detector"
  type        = bool
  default     = null
}

variable "unavailable_sending_operations_ratio_disabled_major" {
  description = "Disable major alerting rule for unavailable_sending_operations_ratio detector"
  type        = bool
  default     = null
}

variable "unavailable_sending_operations_ratio_threshold_critical" {
  description = "Critical threshold for unavailable_sending_operations_ratio detector"
  type        = number
  default     = 20
}

variable "unavailable_sending_operations_ratio_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "unavailable_sending_operations_ratio_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "unavailable_sending_operations_ratio_threshold_major" {
  description = "Major threshold for unavailable_sending_operations_ratio detector"
  type        = number
  default     = 0
}

variable "unavailable_sending_operations_ratio_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "unavailable_sending_operations_ratio_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
