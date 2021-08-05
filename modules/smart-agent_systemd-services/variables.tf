# Module specific

# systemd_services detector

variable "systemd_services_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "systemd_services_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "systemd_services_disabled" {
  description = "Disable all alerting rules for systemd services detector"
  type        = bool
  default     = null
}

variable "systemd_services_disabled_critical" {
  description = "Disable critical alerting rule for systemd services detector"
  type        = bool
  default     = null
}

variable "systemd_services_notifications" {
  description = "Notification recipients list per severity overridden for systemd services detector"
  type        = map(list(string))
  default     = {}
}

variable "systemd_services_aggregation_function" {
  description = "Aggregation function and group by for systemd services detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "systemd_services_transformation_function" {
  description = "Transformation function for systemd services detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".max(over='15m')"
}
