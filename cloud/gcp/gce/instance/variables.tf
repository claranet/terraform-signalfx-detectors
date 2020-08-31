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

# GCP GCE Instance detectors specific

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

variable "cpu_utilization_disabled_warning" {
  description = "Disable warning alerting rule for cpu_utilization detector"
  type        = bool
  default     = null
}

variable "cpu_utilization_notifications" {
  description = "Notification recipients list for every alerting rules of cpu_utilization detector"
  type        = list
  default     = []
}

variable "cpu_utilization_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of cpu_utilization detector"
  type        = list
  default     = []
}

variable "cpu_utilization_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of cpu_utilization detector"
  type        = list
  default     = []
}

variable "cpu_utilization_aggregation_function" {
  description = "Aggregation function and group by for cpu_utilization detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "cpu_utilization_transformation_function" {
  description = "Transformation function for cpu_utilization detector (i.e. \".mean(over='5m')\"))"
  type        = string
  default     = ".min(over='1h')"
}

variable "cpu_utilization_threshold_critical" {
  description = "Critical threshold for cpu_utilization detector"
  type        = number
  default     = 90
}

variable "cpu_utilization_threshold_warning" {
  description = "Warning threshold for cpu_utilization detector"
  type        = number
  default     = 85
}

# Disk_throttled_bps detectors

variable "disk_throttled_bps_disabled" {
  description = "Disable all alerting rules for disk_throttled_bps detector"
  type        = bool
  default     = null
}

variable "disk_throttled_bps_disabled_critical" {
  description = "Disable critical alerting rule for disk_throttled_bps detector"
  type        = bool
  default     = null
}

variable "disk_throttled_bps_disabled_warning" {
  description = "Disable warning alerting rule for disk_throttled_bps detector"
  type        = bool
  default     = null
}

variable "disk_throttled_bps_notifications" {
  description = "Notification recipients list for every alerting rules of disk_throttled_bps detector"
  type        = list
  default     = []
}

variable "disk_throttled_bps_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of disk_throttled_bps detector"
  type        = list
  default     = []
}

variable "disk_throttled_bps_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of disk_throttled_bps detector"
  type        = list
  default     = []
}

variable "disk_throttled_bps_aggregation_function" {
  description = "Aggregation function and group by for disk_throttled_bps detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "disk_throttled_bps_transformation_function" {
  description = "Transformation function for disk_throttled_bps detector (i.e. \".mean(over='5m')\"))"
  type        = string
  default     = ".min(over='15m')"
}

variable "disk_throttled_bps_threshold_critical" {
  description = "Critical threshold for disk_throttled_bps detector"
  type        = number
  default     = 50
}

variable "disk_throttled_bps_threshold_warning" {
  description = "Warning threshold for disk_throttled_bps detector"
  type        = number
  default     = 30
}

# Disk_throttled_ops detectors

variable "disk_throttled_ops_disabled" {
  description = "Disable all alerting rules for disk_throttled_ops detector"
  type        = bool
  default     = null
}

variable "disk_throttled_ops_disabled_critical" {
  description = "Disable critical alerting rule for disk_throttled_ops detector"
  type        = bool
  default     = null
}

variable "disk_throttled_ops_disabled_warning" {
  description = "Disable warning alerting rule for disk_throttled_ops detector"
  type        = bool
  default     = null
}

variable "disk_throttled_ops_notifications" {
  description = "Notification recipients list for every alerting rules of disk_throttled_ops detector"
  type        = list
  default     = []
}

variable "disk_throttled_ops_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of disk_throttled_ops detector"
  type        = list
  default     = []
}

variable "disk_throttled_ops_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of disk_throttled_ops detector"
  type        = list
  default     = []
}

variable "disk_throttled_ops_aggregation_function" {
  description = "Aggregation function and group by for disk_throttled_ops detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "disk_throttled_ops_transformation_function" {
  description = "Transformation function for disk_throttled_ops detector (i.e. \".mean(over='5m')\"))"
  type        = string
  default     = ".min(over='15m')"
}

variable "disk_throttled_ops_threshold_critical" {
  description = "Critical threshold for disk_throttled_ops detector"
  type        = number
  default     = 50
}

variable "disk_throttled_ops_threshold_warning" {
  description = "Warning threshold for disk_throttled_ops detector"
  type        = number
  default     = 30
}
