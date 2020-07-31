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

# Kubernetes Node detectors specific

# Volume_space detectors

variable "volume_space_disabled" {
  description = "Disable all alerting rules for volume_space detector"
  type        = bool
  default     = null
}

variable "volume_space_disabled_critical" {
  description = "Disable critical alerting rule for volume_space detector"
  type        = bool
  default     = null
}

variable "volume_space_disabled_warning" {
  description = "Disable warning alerting rule for volume_space detector"
  type        = bool
  default     = null
}

variable "volume_space_notifications" {
  description = "Notification recipients list for every alerting rules of volume_space detector"
  type        = list
  default     = []
}

variable "volume_space_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of volume_space detector"
  type        = list
  default     = []
}

variable "volume_space_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of volume_space detector"
  type        = list
  default     = []
}

variable "volume_space_aggregation_function" {
  description = "Aggregation function and group by for volume_space detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "volume_space_transformation_function" {
  description = "Transformation function for volume_space detector (i.e. \".mean(over='5m')\"))"
  type        = string
  default     = ".min(over='5m')"
}

variable "volume_space_threshold_critical" {
  description = "Critical threshold for volume_space detector"
  type        = number
  default     = 95
}

variable "volume_space_threshold_warning" {
  description = "Warning threshold for volume_space detector"
  type        = number
  default     = 90
}

# Volume_inodes detectors

variable "volume_inodes_disabled" {
  description = "Disable all alerting rules for volume_inodes detector"
  type        = bool
  default     = null
}

variable "volume_inodes_disabled_critical" {
  description = "Disable critical alerting rule for volume_inodes detector"
  type        = bool
  default     = null
}

variable "volume_inodes_disabled_warning" {
  description = "Disable warning alerting rule for volume_inodes detector"
  type        = bool
  default     = null
}

variable "volume_inodes_notifications" {
  description = "Notification recipients list for every alerting rules of volume_inodes detector"
  type        = list
  default     = []
}

variable "volume_inodes_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of volume_inodes detector"
  type        = list
  default     = []
}

variable "volume_inodes_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of volume_inodes detector"
  type        = list
  default     = []
}

variable "volume_inodes_aggregation_function" {
  description = "Aggregation function and group by for volume_inodes detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "volume_inodes_transformation_function" {
  description = "Transformation function for volume_inodes detector (i.e. \".mean(over='5m')\"))"
  type        = string
  default     = ".min(over='5m')"
}

variable "volume_inodes_threshold_critical" {
  description = "Critical threshold for volume_inodes detector"
  type        = number
  default     = 95
}

variable "volume_inodes_threshold_warning" {
  description = "Warning threshold for volume_inodes detector"
  type        = number
  default     = 90
}

