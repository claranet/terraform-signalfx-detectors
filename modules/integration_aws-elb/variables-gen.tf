# unhealthy_instances_absolute detector

variable "unhealthy_instances_absolute_notifications" {
  description = "Notification recipients list per severity overridden for unhealthy_instances_absolute detector"
  type        = map(list(string))
  default     = {}
}

variable "unhealthy_instances_absolute_aggregation_function" {
  description = "Aggregation function and group by for unhealthy_instances_absolute detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "unhealthy_instances_absolute_transformation_function" {
  description = "Transformation function for unhealthy_instances_absolute detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='10m')"
}

variable "unhealthy_instances_absolute_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "unhealthy_instances_absolute_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "unhealthy_instances_absolute_disabled" {
  description = "Disable all alerting rules for unhealthy_instances_absolute detector"
  type        = bool
  default     = null
}

variable "unhealthy_instances_absolute_threshold_critical" {
  description = "Critical threshold for unhealthy_instances_absolute detector"
  type        = number
  default     = 1
}

