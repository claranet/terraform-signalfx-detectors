# messages_ready detector

variable "messages_ready_notifications" {
  description = "Notification recipients list per severity overridden for messages_ready detector"
  type        = map(list(string))
  default     = {}
}

variable "messages_ready_aggregation_function" {
  description = "Aggregation function and group by for messages_ready detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "messages_ready_transformation_function" {
  description = "Transformation function for messages_ready detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "messages_ready_max_delay" {
  description = "Enforce max delay for messages_ready detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "messages_ready_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "messages_ready_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "messages_ready_disabled" {
  description = "Disable all alerting rules for messages_ready detector"
  type        = bool
  default     = null
}

variable "messages_ready_disabled_critical" {
  description = "Disable critical alerting rule for messages_ready detector"
  type        = bool
  default     = null
}

variable "messages_ready_disabled_major" {
  description = "Disable major alerting rule for messages_ready detector"
  type        = bool
  default     = null
}

variable "messages_ready_threshold_critical" {
  description = "Critical threshold for messages_ready detector"
  type        = number
  default     = 15000
}

variable "messages_ready_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "20m"
}

variable "messages_ready_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "messages_ready_threshold_major" {
  description = "Major threshold for messages_ready detector"
  type        = number
  default     = 10000
}

variable "messages_ready_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "20m"
}

variable "messages_ready_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# messages_unacknowledged detector

variable "messages_unacknowledged_notifications" {
  description = "Notification recipients list per severity overridden for messages_unacknowledged detector"
  type        = map(list(string))
  default     = {}
}

variable "messages_unacknowledged_aggregation_function" {
  description = "Aggregation function and group by for messages_unacknowledged detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "messages_unacknowledged_transformation_function" {
  description = "Transformation function for messages_unacknowledged detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "messages_unacknowledged_max_delay" {
  description = "Enforce max delay for messages_unacknowledged detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "messages_unacknowledged_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "messages_unacknowledged_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "messages_unacknowledged_disabled" {
  description = "Disable all alerting rules for messages_unacknowledged detector"
  type        = bool
  default     = true
}

variable "messages_unacknowledged_disabled_critical" {
  description = "Disable critical alerting rule for messages_unacknowledged detector"
  type        = bool
  default     = null
}

variable "messages_unacknowledged_disabled_major" {
  description = "Disable major alerting rule for messages_unacknowledged detector"
  type        = bool
  default     = null
}

variable "messages_unacknowledged_threshold_critical" {
  description = "Critical threshold for messages_unacknowledged detector"
  type        = number
  default     = 15000
}

variable "messages_unacknowledged_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "20m"
}

variable "messages_unacknowledged_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "messages_unacknowledged_threshold_major" {
  description = "Major threshold for messages_unacknowledged detector"
  type        = number
  default     = 10000
}

variable "messages_unacknowledged_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "20m"
}

variable "messages_unacknowledged_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# messages_ack_rate detector

variable "messages_ack_rate_notifications" {
  description = "Notification recipients list per severity overridden for messages_ack_rate detector"
  type        = map(list(string))
  default     = {}
}

variable "messages_ack_rate_aggregation_function" {
  description = "Aggregation function and group by for messages_ack_rate detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "messages_ack_rate_transformation_function" {
  description = "Transformation function for messages_ack_rate detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "messages_ack_rate_max_delay" {
  description = "Enforce max delay for messages_ack_rate detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "messages_ack_rate_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "messages_ack_rate_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "messages_ack_rate_disabled" {
  description = "Disable all alerting rules for messages_ack_rate detector"
  type        = bool
  default     = true
}

variable "messages_ack_rate_disabled_critical" {
  description = "Disable critical alerting rule for messages_ack_rate detector"
  type        = bool
  default     = null
}

variable "messages_ack_rate_disabled_major" {
  description = "Disable major alerting rule for messages_ack_rate detector"
  type        = bool
  default     = null
}

variable "messages_ack_rate_threshold_critical" {
  description = "Critical threshold for messages_ack_rate detector"
  type        = number
  default     = 0.016666666666666666
}

variable "messages_ack_rate_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "10m"
}

variable "messages_ack_rate_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 0.9
}
variable "messages_ack_rate_threshold_major" {
  description = "Major threshold for messages_ack_rate detector"
  type        = number
  default     = 0.03333333333333333
}

variable "messages_ack_rate_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "10m"
}

variable "messages_ack_rate_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 0.9
}
# memory_used detector

variable "memory_used_notifications" {
  description = "Notification recipients list per severity overridden for memory_used detector"
  type        = map(list(string))
  default     = {}
}

variable "memory_used_aggregation_function" {
  description = "Aggregation function and group by for memory_used detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "memory_used_transformation_function" {
  description = "Transformation function for memory_used detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "memory_used_max_delay" {
  description = "Enforce max delay for memory_used detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "memory_used_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "memory_used_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "memory_used_disabled" {
  description = "Disable all alerting rules for memory_used detector"
  type        = bool
  default     = null
}

variable "memory_used_disabled_critical" {
  description = "Disable critical alerting rule for memory_used detector"
  type        = bool
  default     = null
}

variable "memory_used_disabled_major" {
  description = "Disable major alerting rule for memory_used detector"
  type        = bool
  default     = null
}

variable "memory_used_threshold_critical" {
  description = "Critical threshold for memory_used detector in %"
  type        = number
  default     = 90
}

variable "memory_used_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "10m"
}

variable "memory_used_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "memory_used_threshold_major" {
  description = "Major threshold for memory_used detector in %"
  type        = number
  default     = 80
}

variable "memory_used_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "10m"
}

variable "memory_used_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# disk_free detector

variable "disk_free_notifications" {
  description = "Notification recipients list per severity overridden for disk_free detector"
  type        = map(list(string))
  default     = {}
}

variable "disk_free_aggregation_function" {
  description = "Aggregation function and group by for disk_free detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "disk_free_transformation_function" {
  description = "Transformation function for disk_free detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "disk_free_max_delay" {
  description = "Enforce max delay for disk_free detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "disk_free_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "disk_free_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "disk_free_disabled" {
  description = "Disable all alerting rules for disk_free detector"
  type        = bool
  default     = null
}

variable "disk_free_disabled_critical" {
  description = "Disable critical alerting rule for disk_free detector"
  type        = bool
  default     = null
}

variable "disk_free_disabled_major" {
  description = "Disable major alerting rule for disk_free detector"
  type        = bool
  default     = null
}

variable "disk_free_threshold_critical" {
  description = "Critical threshold for disk_free detector in GiB"
  type        = number
  default     = 0.5
}

variable "disk_free_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "10m"
}

variable "disk_free_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "disk_free_threshold_major" {
  description = "Major threshold for disk_free detector in GiB"
  type        = number
  default     = 1
}

variable "disk_free_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "10m"
}

variable "disk_free_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
