# Module specific

variable "agent_per_cpu_enabled" {
  description = "Is `perCPU` option is enabled for the load monitor in the agent configuration"
  type        = bool
  default     = true
}

# disk_running_out detector

variable "disk_running_out_max_delay" {
  description = "Enforce max delay for disk_running_out detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "disk_running_out_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "disk_running_out_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "disk_running_out_disabled" {
  description = "Disable all alerting rules for disk running out detector"
  type        = bool
  default     = true
}

variable "disk_running_out_maximum_capacity" {
  description = "When to consider disk full, defined as a percentage"
  type        = number
  default     = 95
}

variable "disk_running_out_hours_till_full" {
  description = "How manuy hours before disk is projected to be full do you want to be alerted"
  type        = number
  default     = 72
}

variable "disk_running_out_fire_lasting_time" {
  description = "Time condition must be true to fire"
  type        = string
  default     = "30m"
}

variable "disk_running_out_fire_lasting_time_percent" {
  description = "Percent of fire lasting time the conditon must be true.  Expressed as decimal"
  type        = number
  default     = 0.9
}

variable "disk_running_out_clear_hours_remaining" {
  description = "With how many hours left till disk is full can the alert clear"
  type        = number
  default     = 96
}

variable "disk_running_out_clear_lasting_time" {
  description = "Time clear condition must be true to clear"
  type        = string
  default     = "30m"
}

variable "disk_running_out_clear_lasting_time_percent" {
  description = "Percent of clear lasting time the conditon must be true.  Expressed as decimal"
  type        = number
  default     = 0.9
}

variable "disk_running_out_use_ewma" {
  description = "Use Double EWMA"
  type        = string
  default     = "False"
}

variable "disk_running_out_notifications" {
  description = "Notification recipients list per severity overridden for disk running out detector"
  type        = map(list(string))
  default     = {}
}

