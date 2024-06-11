# heartbeat detector

variable "heartbeat_notifications" {
  description = "Notification recipients list per severity overridden for heartbeat detector"
  type        = map(list(string))
  default     = {}
}

variable "heartbeat_aggregation_function" {
  description = "Aggregation function and group by for heartbeat detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['LoadBalancer'])"
}

variable "heartbeat_transformation_function" {
  description = "Transformation function for heartbeat detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "heartbeat_max_delay" {
  description = "Enforce max delay for heartbeat detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "heartbeat_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "heartbeat_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "heartbeat_disabled" {
  description = "Disable all alerting rules for heartbeat detector"
  type        = bool
  default     = null
}

variable "heartbeat_timeframe" {
  description = "Timeframe for heartbeat detector (i.e. \"25m\")."
  type        = string
  default     = "25m"
}

# no_healthy_instances detector

variable "no_healthy_instances_notifications" {
  description = "Notification recipients list per severity overridden for no_healthy_instances detector"
  type        = map(list(string))
  default     = {}
}

variable "no_healthy_instances_aggregation_function" {
  description = "Aggregation function and group by for no_healthy_instances detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "no_healthy_instances_transformation_function" {
  description = "Transformation function for no_healthy_instances detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='5m')"
}

variable "no_healthy_instances_max_delay" {
  description = "Enforce max delay for no_healthy_instances detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "no_healthy_instances_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "no_healthy_instances_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "no_healthy_instances_disabled" {
  description = "Disable all alerting rules for no_healthy_instances detector"
  type        = bool
  default     = null
}

variable "no_healthy_instances_disabled_critical" {
  description = "Disable critical alerting rule for no_healthy_instances detector"
  type        = bool
  default     = null
}

variable "no_healthy_instances_disabled_major" {
  description = "Disable major alerting rule for no_healthy_instances detector"
  type        = bool
  default     = null
}

variable "no_healthy_instances_threshold_critical" {
  description = "Critical threshold for no_healthy_instances detector"
  type        = number
  default     = 1
}

variable "no_healthy_instances_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "no_healthy_instances_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "no_healthy_instances_threshold_major" {
  description = "Major threshold for no_healthy_instances detector"
  type        = number
  default     = 100
}

variable "no_healthy_instances_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "no_healthy_instances_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
