# Module specific

variable "gcp_project_id" {
  description = "GCP project id used for default filtering while lables are not synced"
  type        = string
}

# Disk_utilization_forecast detector

variable "disk_utilization_forecast_max_delay" {
  description = "Enforce max delay for disk_utilization_forecast detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "disk_utilization_forecast_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "disk_utilization_forecast_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "disk_utilization_forecast_disabled" {
  description = "Disable all alerting rules for disk_utilization_forecast detector"
  type        = bool
  default     = true
}

variable "disk_utilization_forecast_maximum_capacity" {
  description = "When to consider disk full, defined as fractional decimal"
  type        = number
  default     = 0.95
}

variable "disk_utilization_forecast_hours_till_full" {
  description = "How many hours before disk is projected to be full do you want to be alerted"
  type        = number
  default     = 72
}

variable "disk_utilization_forecast_fire_lasting_time" {
  description = "Time condition must be true to fire"
  type        = string
  default     = "30m"
}

variable "disk_utilization_forecast_fire_lasting_time_percent" {
  description = "Percent of fire lasting time the conditon must be true.  Expressed as decimal"
  type        = number
  default     = 0.9
}

variable "disk_utilization_forecast_clear_hours_remaining" {
  description = "With how many hours left till disk is full can the alert clear"
  type        = number
  default     = 96
}

variable "disk_utilization_forecast_clear_lasting_time" {
  description = "Time clear condition must be true to clear"
  type        = string
  default     = "30m"
}

variable "disk_utilization_forecast_clear_lasting_time_percent" {
  description = "Percent of clear lasting time the conditon must be true.  Expressed as decimal"
  type        = number
  default     = 0.9
}

variable "disk_utilization_forecast_use_ewma" {
  description = "Use Double EWMA"
  type        = string
  default     = "True"
}

variable "disk_utilization_forecast_notifications" {
  description = "Notification recipients list per severity overridden for disk_utilization_forecast detector"
  type        = map(list(string))
  default     = {}
}

# Memory_utilization_forecast detector

variable "memory_utilization_forecast_max_delay" {
  description = "Enforce max delay for memory_utilization_forecast detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "memory_utilization_forecast_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "memory_utilization_forecast_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "memory_utilization_forecast_disabled" {
  description = "Disable all alerting rules for memory_utilization_forecast detector"
  type        = bool
  default     = true
}

variable "memory_utilization_forecast_maximum_capacity" {
  description = "When to consider memory full, defined as a fractional decimal"
  type        = number
  default     = 0.95
}

variable "memory_utilization_forecast_hours_till_full" {
  description = "How many hours before memory is projected to be full do you want to be alerted"
  type        = number
  default     = 72
}

variable "memory_utilization_forecast_fire_lasting_time" {
  description = "Time condition must be true to fire"
  type        = string
  default     = "30m"
}

variable "memory_utilization_forecast_fire_lasting_time_percent" {
  description = "Percent of fire lasting time the conditon must be true.  Expressed as decimal"
  type        = number
  default     = 0.9
}

variable "memory_utilization_forecast_clear_hours_remaining" {
  description = "With how many hours left till memory is full can the alert clear"
  type        = number
  default     = 96
}

variable "memory_utilization_forecast_clear_lasting_time" {
  description = "Time clear condition must be true to clear"
  type        = string
  default     = "30m"
}

variable "memory_utilization_forecast_clear_lasting_time_percent" {
  description = "Percent of clear lasting time the conditon must be true.  Expressed as decimal"
  type        = number
  default     = 0.9
}

variable "memory_utilization_forecast_use_ewma" {
  description = "Use Double EWMA"
  type        = string
  default     = "True"
}

variable "memory_utilization_forecast_notifications" {
  description = "Notification recipients list per severity overridden for memory_utilization_forecast detector"
  type        = map(list(string))
  default     = {}
}

