# Global

variable "environment" {
  description = "Infrastructure environment"
  type        = string
}

# SignalFx module specific

variable "notifications" {
  description = "Default notification recipients list per severity"
  type = object({
    critical = list(string)
    major    = list(string)
    minor    = list(string)
    warning  = list(string)
    info     = list(string)
  })
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

# Apache detectors specific

variable "heartbeat_disabled" {
  description = "Disable all alerting rules for heartbeat detector"
  type        = bool
  default     = null
}

variable "heartbeat_notifications" {
  description = "Notification recipients list per severity overridden for heartbeat detector"
  type        = map(list(string))
  default     = {}
}

variable "heartbeat_timeframe" {
  description = "Timeframe for system not reporting detector (i.e. \"10m\")"
  type        = string
  default     = "20m"
}

# Apache_workers detectors

variable "apache_workers_disabled" {
  description = "Disable all alerting rules for apache_workers detector"
  type        = bool
  default     = null
}

variable "apache_workers_disabled_critical" {
  description = "Disable critical alerting rule for apache_workers detector"
  type        = bool
  default     = null
}

variable "apache_workers_disabled_major" {
  description = "Disable major alerting rule for apache_workers detector"
  type        = bool
  default     = null
}

variable "apache_workers_notifications" {
  description = "Notification recipients list per severity overridden for apache_workers detector"
  type        = map(list(string))
  default     = {}
}

variable "apache_workers_aggregation_function" {
  description = "Aggregation function and group by for apache_workers detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "apache_workers_transformation_function" {
  description = "Transformation function for apache_workers detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".mean(over='10m')"
}

variable "apache_workers_threshold_critical" {
  description = "Critical threshold for apache_workers detector"
  type        = number
  default     = 90
}

variable "apache_workers_threshold_major" {
  description = "Major threshold for apache_workers detector"
  type        = number
  default     = 80
}

