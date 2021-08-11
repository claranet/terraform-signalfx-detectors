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
  default     = ".min(over='15m')"
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
  default     = null
}

variable "memory_used_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "memory_used_threshold_major" {
  description = "Major threshold for memory_used detector in %"
  type        = number
  default     = 70
}

variable "memory_used_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "memory_used_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# out_of_memory_errors detector

variable "out_of_memory_errors_notifications" {
  description = "Notification recipients list per severity overridden for out_of_memory_errors detector"
  type        = map(list(string))
  default     = {}
}

variable "out_of_memory_errors_aggregation_function" {
  description = "Aggregation function and group by for out_of_memory_errors detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "out_of_memory_errors_transformation_function" {
  description = "Transformation function for out_of_memory_errors detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='15m')"
}

variable "out_of_memory_errors_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "out_of_memory_errors_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "out_of_memory_errors_disabled" {
  description = "Disable all alerting rules for out_of_memory_errors detector"
  type        = bool
  default     = null
}

variable "out_of_memory_errors_threshold_critical" {
  description = "Critical threshold for out_of_memory_errors detector"
  type        = number
  default     = 0
}

variable "out_of_memory_errors_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "out_of_memory_errors_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# disk_write_queue detector

variable "disk_write_queue_notifications" {
  description = "Notification recipients list per severity overridden for disk_write_queue detector"
  type        = map(list(string))
  default     = {}
}

variable "disk_write_queue_aggregation_function" {
  description = "Aggregation function and group by for disk_write_queue detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "disk_write_queue_transformation_function" {
  description = "Transformation function for disk_write_queue detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='15m')"
}

variable "disk_write_queue_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "disk_write_queue_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "disk_write_queue_disabled" {
  description = "Disable all alerting rules for disk_write_queue detector"
  type        = bool
  default     = null
}

variable "disk_write_queue_disabled_critical" {
  description = "Disable critical alerting rule for disk_write_queue detector"
  type        = bool
  default     = null
}

variable "disk_write_queue_disabled_major" {
  description = "Disable major alerting rule for disk_write_queue detector"
  type        = bool
  default     = null
}

variable "disk_write_queue_threshold_critical" {
  description = "Critical threshold for disk_write_queue detector"
  type        = number
  default     = 300
}

variable "disk_write_queue_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "disk_write_queue_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "disk_write_queue_threshold_major" {
  description = "Major threshold for disk_write_queue detector"
  type        = number
  default     = 200
}

variable "disk_write_queue_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "disk_write_queue_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
