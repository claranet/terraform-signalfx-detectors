# Global

variable "environment" {
  description = "Infrastructure environment"
  type        = string
}

# SignalFx Module specific

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

# System ntp specific

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
  default     = "12h"
}

#####

variable "ntp_disabled" {
  description = "Disable all alerting rules for ntp detector"
  type        = bool
  default     = null
}

variable "ntp_notifications" {
  description = "Notification recipients list per severity overridden for ntp detector"
  type        = map(list(string))
  default     = {}
}

variable "ntp_aggregation_function" {
  description = "Aggregation function and group by for ntp detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "ntp_transformation_function" {
  description = "Transformation function for ntp detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='5m')"
}

variable "ntp_threshold_major" {
  description = "Major threshold for ntp detector"
  type        = number
  default     = 1500
}

