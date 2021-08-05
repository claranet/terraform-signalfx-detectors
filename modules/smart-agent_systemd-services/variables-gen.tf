# systemd_services detector

variable "systemd_services_notifications" {
  description = "Notification recipients list per severity overridden for systemd_services detector"
  type        = map(list(string))
  default     = {}
}

variable "systemd_services_transformation_function" {
  description = "Transformation function for systemd_services detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

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
  description = "Disable all alerting rules for systemd_services detector"
  type        = bool
  default     = null
}

variable "systemd_services_threshold_critical" {
  description = "Critical threshold for systemd_services detector"
  type        = number
  default     = 1
}
