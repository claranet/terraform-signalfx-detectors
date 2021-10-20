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
# server_errors detector

variable "server_errors_notifications" {
  description = "Notification recipients list per severity overridden for server_errors detector"
  type        = map(list(string))
  default     = {}
}

variable "server_errors_aggregation_function" {
  description = "Aggregation function and group by for server_errors detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "server_errors_transformation_function" {
  description = "Transformation function for server_errors detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "server_errors_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "server_errors_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "server_errors_disabled" {
  description = "Disable all alerting rules for server_errors detector"
  type        = bool
  default     = null
}

variable "server_errors_disabled_critical" {
  description = "Disable critical alerting rule for server_errors detector"
  type        = bool
  default     = null
}

variable "server_errors_disabled_major" {
  description = "Disable major alerting rule for server_errors detector"
  type        = bool
  default     = null
}

variable "server_errors_threshold_critical" {
  description = "Critical threshold for server_errors detector"
  type        = number
  default     = 50
}

variable "server_errors_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "5m"
}

variable "server_errors_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "server_errors_threshold_major" {
  description = "Major threshold for server_errors detector"
  type        = number
  default     = 25
}

variable "server_errors_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "5m"
}

variable "server_errors_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# total_requests detector

variable "total_requests_notifications" {
  description = "Notification recipients list per severity overridden for total_requests detector"
  type        = map(list(string))
  default     = {}
}

variable "total_requests_transformation_function" {
  description = "Transformation function for total_requests detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "total_requests_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "total_requests_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "total_requests_disabled" {
  description = "Disable all alerting rules for total_requests detector"
  type        = bool
  default     = null
}

variable "total_requests_threshold_critical" {
  description = "Critical threshold for total_requests detector"
  type        = number
  default     = 1
}

variable "total_requests_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "5m"
}

variable "total_requests_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
