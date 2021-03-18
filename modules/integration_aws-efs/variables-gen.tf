# used_space detector

variable "used_space_notifications" {
  description = "Notification recipients list per severity overridden for used_space detector"
  type        = map(list(string))
  default     = {}
}

variable "used_space_aggregation_function" {
  description = "Aggregation function and group by for used_space detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "used_space_transformation_function" {
  description = "Transformation function for used_space detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".max(over='15m')"
}

variable "used_space_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "used_space_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "used_space_disabled" {
  description = "Disable all alerting rules for used_space detector"
  type        = bool
  default     = null
}

variable "used_space_disabled_critical" {
  description = "Disable critical alerting rule for used_space detector"
  type        = bool
  default     = null
}

variable "used_space_disabled_major" {
  description = "Disable major alerting rule for used_space detector"
  type        = bool
  default     = null
}

variable "used_space_threshold_critical" {
  description = "Critical threshold for used_space detector in GB"
  type        = number
}

variable "used_space_threshold_major" {
  description = "Major threshold for used_space detector in GB"
  type        = number
}

# percent_io_limit detector

variable "percent_io_limit_notifications" {
  description = "Notification recipients list per severity overridden for percent_io_limit detector"
  type        = map(list(string))
  default     = {}
}

variable "percent_io_limit_aggregation_function" {
  description = "Aggregation function and group by for percent_io_limit detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "percent_io_limit_transformation_function" {
  description = "Transformation function for percent_io_limit detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".max(over='15m')"
}

variable "percent_io_limit_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "percent_io_limit_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "percent_io_limit_disabled" {
  description = "Disable all alerting rules for percent_io_limit detector"
  type        = bool
  default     = null
}

variable "percent_io_limit_disabled_critical" {
  description = "Disable critical alerting rule for percent_io_limit detector"
  type        = bool
  default     = null
}

variable "percent_io_limit_disabled_major" {
  description = "Disable major alerting rule for percent_io_limit detector"
  type        = bool
  default     = null
}

variable "percent_io_limit_threshold_critical" {
  description = "Critical threshold for percent_io_limit detector in %"
  type        = number
  default     = 90
}

variable "percent_io_limit_threshold_major" {
  description = "Major threshold for percent_io_limit detector in %"
  type        = number
  default     = 80
}

# iops_read_stats detector

variable "iops_read_stats_notifications" {
  description = "Notification recipients list per severity overridden for iops_read_stats detector"
  type        = map(list(string))
  default     = {}
}

variable "iops_read_stats_aggregation_function" {
  description = "Aggregation function and group by for iops_read_stats detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "iops_read_stats_transformation_function" {
  description = "Transformation function for iops_read_stats detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".max(over='15m')"
}

variable "iops_read_stats_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "iops_read_stats_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "iops_read_stats_disabled" {
  description = "Disable all alerting rules for iops_read_stats detector"
  type        = bool
  default     = null
}

variable "iops_read_stats_disabled_critical" {
  description = "Disable critical alerting rule for iops_read_stats detector"
  type        = bool
  default     = null
}

variable "iops_read_stats_disabled_major" {
  description = "Disable major alerting rule for iops_read_stats detector"
  type        = bool
  default     = null
}

variable "iops_read_stats_threshold_critical" {
  description = "Critical threshold for iops_read_stats detector in IOPs"
  type        = number
}

variable "iops_read_stats_threshold_major" {
  description = "Major threshold for iops_read_stats detector in IOPs"
  type        = number
}

# iops_write_stats detector

variable "iops_write_stats_notifications" {
  description = "Notification recipients list per severity overridden for iops_write_stats detector"
  type        = map(list(string))
  default     = {}
}

variable "iops_write_stats_aggregation_function" {
  description = "Aggregation function and group by for iops_write_stats detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "iops_write_stats_transformation_function" {
  description = "Transformation function for iops_write_stats detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".max(over='15m')"
}

variable "iops_write_stats_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "iops_write_stats_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "iops_write_stats_disabled" {
  description = "Disable all alerting rules for iops_write_stats detector"
  type        = bool
  default     = null
}

variable "iops_write_stats_disabled_critical" {
  description = "Disable critical alerting rule for iops_write_stats detector"
  type        = bool
  default     = null
}

variable "iops_write_stats_disabled_major" {
  description = "Disable major alerting rule for iops_write_stats detector"
  type        = bool
  default     = null
}

variable "iops_write_stats_threshold_critical" {
  description = "Critical threshold for iops_write_stats detector in IOPs"
  type        = number
}

variable "iops_write_stats_threshold_major" {
  description = "Major threshold for iops_write_stats detector in IOPs"
  type        = number
}

