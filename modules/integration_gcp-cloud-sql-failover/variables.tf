# Module specific

variable "gcp_project_id" {
  description = "GCP project id used for default filtering while lables are not synced"
  type        = string
}

# Failover_unavailable detectors

variable "failover_unavailable_max_delay" {
  description = "Enforce max delay for failover_unavailable detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "failover_unavailable_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "failover_unavailable_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "failover_unavailable_disabled" {
  description = "Disable all alerting rules for failover_unavailable detector"
  type        = bool
  default     = null
}

variable "failover_unavailable_notifications" {
  description = "Notification recipients list per severity overridden for failover_unavailable detector"
  type        = map(list(string))
  default     = {}
}

variable "failover_unavailable_aggregation_function" {
  description = "Aggregation function and group by for failover_unavailable detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "failover_unavailable_transformation_function" {
  description = "Transformation function for failover_unavailable detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".max(over='10m')"
}

