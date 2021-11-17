# listener detector

variable "listener_notifications" {
  description = "Notification recipients list per severity overridden for listener detector"
  type        = map(list(string))
  default     = {}
}

variable "listener_aggregation_function" {
  description = "Aggregation function and group by for listener detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "listener_transformation_function" {
  description = "Transformation function for listener detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "listener_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = <<-EOF
    the listener process is not started, means that application can not connect to the database
EOF
}

variable "listener_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "listener_disabled" {
  description = "Disable all alerting rules for listener detector"
  type        = bool
  default     = null
}

variable "listener_threshold_critical" {
  description = "Critical threshold for listener detector"
  type        = number
  default     = 1
}

variable "listener_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "5m"
}

variable "listener_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
