# s3_5xxerrors detector

variable "s3_5xxerrors_notifications" {
  description = "Notification recipients list per severity overridden for s3_5xxerrors detector"
  type        = map(list(string))
  default     = {}
}

variable "s3_5xxerrors_aggregation_function" {
  description = "Aggregation function and group by for s3_5xxerrors detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "s3_5xxerrors_transformation_function" {
  description = "Transformation function for s3_5xxerrors detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "s3_5xxerrors_max_delay" {
  description = "Enforce max delay for s3_5xxerrors detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "s3_5xxerrors_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "s3_5xxerrors_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "s3_5xxerrors_disabled" {
  description = "Disable all alerting rules for s3_5xxerrors detector"
  type        = bool
  default     = null
}

variable "s3_5xxerrors_disabled_critical" {
  description = "Disable critical alerting rule for s3_5xxerrors detector"
  type        = bool
  default     = null
}

variable "s3_5xxerrors_disabled_major" {
  description = "Disable major alerting rule for s3_5xxerrors detector"
  type        = bool
  default     = null
}

variable "s3_5xxerrors_threshold_critical" {
  description = "Critical threshold for s3_5xxerrors detector in %"
  type        = number
  default     = 10
}

variable "s3_5xxerrors_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "5m"
}

variable "s3_5xxerrors_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 0.9
}
variable "s3_5xxerrors_threshold_major" {
  description = "Major threshold for s3_5xxerrors detector in %"
  type        = number
  default     = 5
}

variable "s3_5xxerrors_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "5m"
}

variable "s3_5xxerrors_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 0.9
}
