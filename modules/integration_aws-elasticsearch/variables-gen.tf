# jvm_memory_pressure detector

variable "jvm_memory_pressure_notifications" {
  description = "Notification recipients list per severity overridden for jvm_memory_pressure detector"
  type        = map(list(string))
  default     = {}
}

variable "jvm_memory_pressure_aggregation_function" {
  description = "Aggregation function and group by for jvm_memory_pressure detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "jvm_memory_pressure_transformation_function" {
  description = "Transformation function for jvm_memory_pressure detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='15m')"
}

variable "jvm_memory_pressure_max_delay" {
  description = "Enforce max delay for jvm_memory_pressure detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "jvm_memory_pressure_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = <<-EOF
    The cluster could encounter out of memory errors if usage increases. Consider scaling vertically.
EOF
}

variable "jvm_memory_pressure_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "jvm_memory_pressure_disabled" {
  description = "Disable all alerting rules for jvm_memory_pressure detector"
  type        = bool
  default     = null
}

variable "jvm_memory_pressure_disabled_critical" {
  description = "Disable critical alerting rule for jvm_memory_pressure detector"
  type        = bool
  default     = null
}

variable "jvm_memory_pressure_disabled_major" {
  description = "Disable major alerting rule for jvm_memory_pressure detector"
  type        = bool
  default     = null
}

variable "jvm_memory_pressure_threshold_critical" {
  description = "Critical threshold for jvm_memory_pressure detector in %"
  type        = number
  default     = 90
}

variable "jvm_memory_pressure_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "jvm_memory_pressure_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "jvm_memory_pressure_threshold_major" {
  description = "Major threshold for jvm_memory_pressure detector in %"
  type        = number
  default     = 80
}

variable "jvm_memory_pressure_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "jvm_memory_pressure_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
