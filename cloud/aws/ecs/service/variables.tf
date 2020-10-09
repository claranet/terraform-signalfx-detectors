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

# AWS ECS detectors specific

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

# CPU_utilization detectors

variable "cpu_utilization_disabled" {
  description = "Disable all alerting rules for cpu_utilization detector"
  type        = bool
  default     = null
}

variable "cpu_utilization_disabled_critical" {
  description = "Disable critical alerting rule for cpu_utilization detector"
  type        = bool
  default     = null
}

variable "cpu_utilization_disabled_major" {
  description = "Disable major alerting rule for cpu_utilization detector"
  type        = bool
  default     = null
}

variable "cpu_utilization_notifications" {
  description = "Notification recipients list per severity overridden for cpu_utilization detector"
  type        = map(list(string))
  default     = {}
}

variable "cpu_utilization_aggregation_function" {
  description = "Aggregation function and group by for cpu_utilization detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "cpu_utilization_transformation_function" {
  description = "Transformation function for cpu_utilization detector (i.e. \".mean(over='5m')\"))"
  type        = string
  default     = ".min(over='5m')"
}

variable "cpu_utilization_threshold_critical" {
  description = "Critical threshold for cpu_utilization detector"
  type        = number
  default     = 90
}

variable "cpu_utilization_threshold_major" {
  description = "Major threshold for cpu_utilization detector"
  type        = number
  default     = 80
}

# Memory_utilization detectors

variable "memory_utilization_disabled" {
  description = "Disable all alerting rules for memory_utilization detector"
  type        = bool
  default     = null
}

variable "memory_utilization_disabled_critical" {
  description = "Disable critical alerting rule for memory_utilization detector"
  type        = bool
  default     = null
}

variable "memory_utilization_disabled_major" {
  description = "Disable major alerting rule for memory_utilization detector"
  type        = bool
  default     = null
}

variable "memory_utilization_notifications" {
  description = "Notification recipients list per severity overridden for memory_utilization detector"
  type        = map(list(string))
  default     = {}
}

variable "memory_utilization_aggregation_function" {
  description = "Aggregation function and group by for memory_utilization detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "memory_utilization_transformation_function" {
  description = "Transformation function for memory_utilization detector (i.e. \".mean(over='5m')\"))"
  type        = string
  default     = ".min(over='5m')"
}

variable "memory_utilization_threshold_critical" {
  description = "Critical threshold for memory_utilization detector"
  type        = number
  default     = 90
}

variable "memory_utilization_threshold_major" {
  description = "Major threshold for memory_utilization detector"
  type        = number
  default     = 85
}

