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

variable "heartbeat_exclude_not_running_vm" {
  description = "Don’t send alerts if associated VM is stopped or stopping (metadata provided by cloud provider integration). Can be useful for ephemeral infrastructure (such as auto scaling groups) as VM will be stopped and started regularly. Note that timeframe must be at least 25 minutes for the metadata to be available to the detector."
  type        = bool
  default     = true
}

variable "heartbeat_timeframe" {
  description = "Timeframe for heartbeat detector (i.e. \"25m\"). Must be at least \"25m\" if \"heartbeat_exclude_not_running_vm\" is true"
  type        = string
  default     = "25m"
}

# dnsmasq_hits detector

variable "dnsmasq_hits_notifications" {
  description = "Notification recipients list per severity overridden for dnsmasq_hits detector"
  type        = map(list(string))
  default     = {}
}

variable "dnsmasq_hits_aggregation_function" {
  description = "Aggregation function and group by for dnsmasq_hits detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "dnsmasq_hits_transformation_function" {
  description = "Transformation function for dnsmasq_hits detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "dnsmasq_hits_max_delay" {
  description = "Enforce max delay for dnsmasq_hits detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "dnsmasq_hits_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "dnsmasq_hits_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "dnsmasq_hits_disabled" {
  description = "Disable all alerting rules for dnsmasq_hits detector"
  type        = bool
  default     = null
}

variable "dnsmasq_hits_threshold_critical" {
  description = "Critical threshold for dnsmasq_hits detector"
  type        = number
  default     = 1
}

variable "dnsmasq_hits_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "5m"
}

variable "dnsmasq_hits_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# dnsmasq_hit_rate detector

variable "dnsmasq_hit_rate_notifications" {
  description = "Notification recipients list per severity overridden for dnsmasq_hit_rate detector"
  type        = map(list(string))
  default     = {}
}

variable "dnsmasq_hit_rate_aggregation_function" {
  description = "Aggregation function and group by for dnsmasq_hit_rate detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "dnsmasq_hit_rate_transformation_function" {
  description = "Transformation function for dnsmasq_hit_rate detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='5m')"
}

variable "dnsmasq_hit_rate_max_delay" {
  description = "Enforce max delay for dnsmasq_hit_rate detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "dnsmasq_hit_rate_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "dnsmasq_hit_rate_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "dnsmasq_hit_rate_disabled" {
  description = "Disable all alerting rules for dnsmasq_hit_rate detector"
  type        = bool
  default     = null
}

variable "dnsmasq_hit_rate_disabled_minor" {
  description = "Disable minor alerting rule for dnsmasq_hit_rate detector"
  type        = bool
  default     = null
}

variable "dnsmasq_hit_rate_disabled_major" {
  description = "Disable major alerting rule for dnsmasq_hit_rate detector"
  type        = bool
  default     = null
}

variable "dnsmasq_hit_rate_threshold_minor" {
  description = "Minor threshold for dnsmasq_hit_rate detector"
  type        = number
  default     = 90
}

variable "dnsmasq_hit_rate_lasting_duration_minor" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "5m"
}

variable "dnsmasq_hit_rate_at_least_percentage_minor" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "dnsmasq_hit_rate_threshold_major" {
  description = "Major threshold for dnsmasq_hit_rate detector"
  type        = number
  default     = 80
}

variable "dnsmasq_hit_rate_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "5m"
}

variable "dnsmasq_hit_rate_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
