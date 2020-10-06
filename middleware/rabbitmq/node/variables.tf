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

# RabbitMQ detectors specific

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

variable "file_descriptors_disabled" {
  description = "Disable all alerting rules for file descriptors detector"
  type        = bool
  default     = null
}

variable "file_descriptors_disabled_critical" {
  description = "Disable critical alerting rule for file descriptors detector"
  type        = bool
  default     = null
}

variable "file_descriptors_disabled_warning" {
  description = "Disable warning alerting rule for file descriptors detector"
  type        = bool
  default     = null
}

variable "file_descriptors_notifications" {
  description = "Notification recipients list per severity overridden for file descriptors detector"
  type        = map(list(string))
  default     = {}
}

variable "file_descriptors_aggregation_function" {
  description = "Aggregation function and group by for file descriptors detector (i.e. \".mean(by=['host']).\")"
  type        = string
  default     = ""
}

variable "file_descriptors_transformation_function" {
  description = "Transformation function for file descriptors detector (i.e. \".mean(over='5m')\"))"
  type        = string
  default     = ".min(over='10m')"
}

variable "file_descriptors_threshold_critical" {
  description = "Critical threshold for file descriptors detector"
  type        = number
  default     = 90
}

variable "file_descriptors_threshold_warning" {
  description = "Warning threshold for file descriptors detector"
  type        = number
  default     = 80
}

variable "processes_disabled" {
  description = "Disable all alerting rules for processes detector"
  type        = bool
  default     = null
}

variable "processes_disabled_critical" {
  description = "Disable critical alerting rule for processes detector"
  type        = bool
  default     = null
}

variable "processes_disabled_warning" {
  description = "Disable warning alerting rule for processes detector"
  type        = bool
  default     = null
}

variable "processes_notifications" {
  description = "Notification recipients list per severity overridden for processes detector"
  type        = map(list(string))
  default     = {}
}

variable "processes_aggregation_function" {
  description = "Aggregation function and group by for processes detector (i.e. \".mean(by=['host']).\")"
  type        = string
  default     = ""
}

variable "processes_transformation_function" {
  description = "Transformation function for processes detector (i.e. \".mean(over='5m')\"))"
  type        = string
  default     = ".min(over='10m')"
}

variable "processes_threshold_critical" {
  description = "Critical threshold for processes detector"
  type        = number
  default     = 90
}

variable "processes_threshold_warning" {
  description = "Warning threshold for processes detector"
  type        = number
  default     = 80
}

variable "sockets_disabled" {
  description = "Disable all alerting rules for sockets detector"
  type        = bool
  default     = null
}

variable "sockets_disabled_critical" {
  description = "Disable critical alerting rule for sockets detector"
  type        = bool
  default     = null
}

variable "sockets_disabled_warning" {
  description = "Disable warning alerting rule for sockets detector"
  type        = bool
  default     = null
}

variable "sockets_notifications" {
  description = "Notification recipients list per severity overridden for sockets detector"
  type        = map(list(string))
  default     = {}
}

variable "sockets_aggregation_function" {
  description = "Aggregation function and group by for sockets detector (i.e. \".mean(by=['host']).\")"
  type        = string
  default     = ""
}

variable "sockets_transformation_function" {
  description = "Transformation function for sockets detector (i.e. \".mean(over='5m')\"))"
  type        = string
  default     = ".min(over='10m')"
}

variable "sockets_threshold_critical" {
  description = "Critical threshold for sockets detector"
  type        = number
  default     = 90
}

variable "sockets_threshold_warning" {
  description = "Warning threshold for sockets detector"
  type        = number
  default     = 80
}

variable "vm_memory_disabled" {
  description = "Disable all alerting rules for vm_memory detector"
  type        = bool
  default     = null
}

variable "vm_memory_disabled_critical" {
  description = "Disable critical alerting rule for vm_memory detector"
  type        = bool
  default     = null
}

variable "vm_memory_disabled_warning" {
  description = "Disable warning alerting rule for vm_memory detector"
  type        = bool
  default     = null
}

variable "vm_memory_notifications" {
  description = "Notification recipients list per severity overridden for vm_memory detector"
  type        = map(list(string))
  default     = {}
}

variable "vm_memory_aggregation_function" {
  description = "Aggregation function and group by for vm_memory detector (i.e. \".mean(by=['host']).\")"
  type        = string
  default     = ""
}

variable "vm_memory_transformation_function" {
  description = "Transformation function for vm_memory detector (i.e. \".mean(over='5m')\"))"
  type        = string
  default     = ".min(over='10m')"
}

variable "vm_memory_threshold_critical" {
  description = "Critical threshold for vm_memory detector"
  type        = number
  default     = 90
}

variable "vm_memory_threshold_warning" {
  description = "Warning threshold for vm_memory detector"
  type        = number
  default     = 80
}

