# Module specific

# Volume_space detector

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

variable "volume_space_disabled_major" {
  description = "Disable major alerting rule for volume_space detector"
  type        = bool
  default     = null
}

variable "volume_space_notifications" {
  description = "Notification recipients list per severity overridden for volume_space detector"
  type        = map(list(string))
  default     = {}
}

variable "volume_space_aggregation_function" {
  description = "Aggregation function and group by for volume_space detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "volume_space_transformation_function" {
  description = "Transformation function for volume_space detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='5m')"
}

variable "volume_space_threshold_critical" {
  description = "Critical threshold for volume_space detector"
  type        = number
  default     = 95
}

variable "volume_space_threshold_major" {
  description = "Major threshold for volume_space detector"
  type        = number
  default     = 90
}

# Volume_inodes detector

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

variable "volume_inodes_disabled_major" {
  description = "Disable major alerting rule for volume_inodes detector"
  type        = bool
  default     = null
}

variable "volume_inodes_notifications" {
  description = "Notification recipients list per severity overridden for volume_inodes detector"
  type        = map(list(string))
  default     = {}
}

variable "volume_inodes_aggregation_function" {
  description = "Aggregation function and group by for volume_inodes detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "volume_inodes_transformation_function" {
  description = "Transformation function for volume_inodes detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='5m')"
}

variable "volume_inodes_threshold_critical" {
  description = "Critical threshold for volume_inodes detector"
  type        = number
  default     = 95
}

variable "volume_inodes_threshold_major" {
  description = "Major threshold for volume_inodes detector"
  type        = number
  default     = 90
}

