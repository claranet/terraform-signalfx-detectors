# Global

variable "environment" {
  description = "Infrastructure environment"
  type        = string
}

# SignalFx module specific

variable "notifications" {
  description = "Notification recipients list for every detectors"
  type        = list
}

variable "prefixes" {
  description = "Prefixes list to prepend between brackets on every monitors names before environment"
  type        = list
  default     = []
}

variable "filter_custom_includes" {
  description = "List of tags to include when custom filtering is used"
  type        = list
  default     = []
}

variable "filter_custom_excludes" {
  description = "List of tags to exclude when custom filtering is used"
  type        = list
  default     = []
}

variable "detectors_disabled" {
  description = "Disable all detectors in this module"
  type        = bool
  default     = false
}

# Supervisor detectors specific

variable "heartbeat_disabled" {
  description = "Disable all alerting rules for heartbeat detector"
  type        = bool
  default     = null
}

variable "heartbeat_notifications" {
  description = "Notification recipients list for every alerting rules of heartbeat detector"
  type        = list
  default     = []
}

variable "heartbeat_timeframe" {
  description = "Timeframe for system not reporting detector (i.e. \"10m\")"
  type        = string
  default     = "20m"
}

variable "process_state_disabled" {
  description = "Disable all alerting rules for process state detector"
  type        = bool
  default     = null
}

variable "process_state_disabled_critical" {
  description = "Disable critical alerting rule for process state detector"
  type        = bool
  default     = null
}

variable "process_state_disabled_warning" {
  description = "Disable warning alerting rule for process state detector"
  type        = bool
  default     = null
}

variable "process_state_notifications" {
  description = "Notification recipients list for every alerting rules of process state detector"
  type        = list
  default     = []
}

variable "process_state_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of process state detector"
  type        = list
  default     = []
}

variable "process_state_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of process state detector"
  type        = list
  default     = []
}

variable "process_state_aggregation_function" {
  description = "Aggregation function and group by for process state detector (i.e. \".mean(by=['host']).\")"
  type        = string
  default     = ""
}

variable "process_state_transformation_function" {
  description = "Transformation function for process state detector (mean, min, max)"
  type        = string
  default     = "min"
}

variable "process_state_transformation_window" {
  description = "Transformation window for process state detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "10m"
}

variable "process_state_threshold_critical" {
  description = "Critical threshold for process state detector, see http://supervisord.org/subprocess.html#process-states)"
  type        = number
  default     = 20
}

variable "process_state_threshold_warning" {
  description = "Warning threshold for process state detector (default to be less then 20 (process has been stopped manually or is starting), see http://supervisord.org/subprocess.html#process-states "
  type        = number
  default     = 20
}

