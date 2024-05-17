# heartbeat detector

variable "heartbeat_notifications" {
  description = "Notification recipients list per severity overridden for heartbeat detector"
  type        = map(list(string))
  default     = {}
}

variable "heartbeat_aggregation_function" {
  description = "Aggregation function and group by for heartbeat detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
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

# bgp_availability detector

variable "bgp_availability_notifications" {
  description = "Notification recipients list per severity overridden for bgp_availability detector"
  type        = map(list(string))
  default     = {}
}

variable "bgp_availability_aggregation_function" {
  description = "Aggregation function and group by for bgp_availability detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "bgp_availability_transformation_function" {
  description = "Transformation function for bgp_availability detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "bgp_availability_max_delay" {
  description = "Enforce max delay for bgp_availability detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "bgp_availability_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "bgp_availability_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "bgp_availability_disabled" {
  description = "Disable all alerting rules for bgp_availability detector"
  type        = bool
  default     = null
}

variable "bgp_availability_disabled_critical" {
  description = "Disable critical alerting rule for bgp_availability detector"
  type        = bool
  default     = null
}

variable "bgp_availability_disabled_major" {
  description = "Disable major alerting rule for bgp_availability detector"
  type        = bool
  default     = null
}

variable "bgp_availability_disabled_warning" {
  description = "Disable warning alerting rule for bgp_availability detector"
  type        = bool
  default     = null
}

variable "bgp_availability_threshold_critical" {
  description = "Critical threshold for bgp_availability detector"
  type        = number
  default     = 95
}

variable "bgp_availability_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "2m"
}

variable "bgp_availability_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "bgp_availability_threshold_major" {
  description = "Major threshold for bgp_availability detector"
  type        = number
  default     = 99
}

variable "bgp_availability_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "2m"
}

variable "bgp_availability_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "bgp_availability_threshold_warning" {
  description = "Warning threshold for bgp_availability detector"
  type        = number
  default     = 100
}

variable "bgp_availability_lasting_duration_warning" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "2m"
}

variable "bgp_availability_at_least_percentage_warning" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# arp_availability detector

variable "arp_availability_notifications" {
  description = "Notification recipients list per severity overridden for arp_availability detector"
  type        = map(list(string))
  default     = {}
}

variable "arp_availability_aggregation_function" {
  description = "Aggregation function and group by for arp_availability detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "arp_availability_transformation_function" {
  description = "Transformation function for arp_availability detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "arp_availability_max_delay" {
  description = "Enforce max delay for arp_availability detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "arp_availability_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "arp_availability_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "arp_availability_disabled" {
  description = "Disable all alerting rules for arp_availability detector"
  type        = bool
  default     = null
}

variable "arp_availability_disabled_critical" {
  description = "Disable critical alerting rule for arp_availability detector"
  type        = bool
  default     = null
}

variable "arp_availability_disabled_major" {
  description = "Disable major alerting rule for arp_availability detector"
  type        = bool
  default     = null
}

variable "arp_availability_disabled_warning" {
  description = "Disable warning alerting rule for arp_availability detector"
  type        = bool
  default     = null
}

variable "arp_availability_threshold_critical" {
  description = "Critical threshold for arp_availability detector"
  type        = number
  default     = 95
}

variable "arp_availability_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "2m"
}

variable "arp_availability_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "arp_availability_threshold_major" {
  description = "Major threshold for arp_availability detector"
  type        = number
  default     = 99
}

variable "arp_availability_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "2m"
}

variable "arp_availability_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "arp_availability_threshold_warning" {
  description = "Warning threshold for arp_availability detector"
  type        = number
  default     = 100
}

variable "arp_availability_lasting_duration_warning" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "2m"
}

variable "arp_availability_at_least_percentage_warning" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
