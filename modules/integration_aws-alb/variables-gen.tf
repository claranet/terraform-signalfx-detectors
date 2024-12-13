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

# latency detector

variable "latency_notifications" {
  description = "Notification recipients list per severity overridden for latency detector"
  type        = map(list(string))
  default     = {}
}

variable "latency_aggregation_function" {
  description = "Aggregation function and group by for latency detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "latency_transformation_function" {
  description = "Transformation function for latency detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "latency_max_delay" {
  description = "Enforce max delay for latency detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "latency_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "latency_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "latency_disabled" {
  description = "Disable all alerting rules for latency detector"
  type        = bool
  default     = null
}

variable "latency_disabled_critical" {
  description = "Disable critical alerting rule for latency detector"
  type        = bool
  default     = null
}

variable "latency_disabled_major" {
  description = "Disable major alerting rule for latency detector"
  type        = bool
  default     = null
}

variable "latency_threshold_critical" {
  description = "Critical threshold for latency detector in Second"
  type        = number
  default     = 3
}

variable "latency_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "10m"
}

variable "latency_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 0.9
}
variable "latency_threshold_major" {
  description = "Major threshold for latency detector in Second"
  type        = number
  default     = 1
}

variable "latency_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "10m"
}

variable "latency_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 0.9
}
# alb_5xx detector

variable "alb_5xx_notifications" {
  description = "Notification recipients list per severity overridden for alb_5xx detector"
  type        = map(list(string))
  default     = {}
}

variable "alb_5xx_aggregation_function" {
  description = "Aggregation function and group by for alb_5xx detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "alb_5xx_transformation_function" {
  description = "Transformation function for alb_5xx detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "alb_5xx_max_delay" {
  description = "Enforce max delay for alb_5xx detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "alb_5xx_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "alb_5xx_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "alb_5xx_disabled" {
  description = "Disable all alerting rules for alb_5xx detector"
  type        = bool
  default     = null
}

variable "alb_5xx_disabled_critical" {
  description = "Disable critical alerting rule for alb_5xx detector"
  type        = bool
  default     = null
}

variable "alb_5xx_disabled_major" {
  description = "Disable major alerting rule for alb_5xx detector"
  type        = bool
  default     = null
}

variable "alb_5xx_threshold_critical" {
  description = "Critical threshold for alb_5xx detector in %"
  type        = number
  default     = 10
}

variable "alb_5xx_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "5m"
}

variable "alb_5xx_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 0.9
}
variable "alb_5xx_threshold_major" {
  description = "Major threshold for alb_5xx detector in %"
  type        = number
  default     = 5
}

variable "alb_5xx_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "5m"
}

variable "alb_5xx_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 0.9
}
# alb_4xx detector

variable "alb_4xx_notifications" {
  description = "Notification recipients list per severity overridden for alb_4xx detector"
  type        = map(list(string))
  default     = {}
}

variable "alb_4xx_aggregation_function" {
  description = "Aggregation function and group by for alb_4xx detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "alb_4xx_transformation_function" {
  description = "Transformation function for alb_4xx detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "alb_4xx_max_delay" {
  description = "Enforce max delay for alb_4xx detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "alb_4xx_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "alb_4xx_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "alb_4xx_disabled" {
  description = "Disable all alerting rules for alb_4xx detector"
  type        = bool
  default     = null
}

variable "alb_4xx_disabled_critical" {
  description = "Disable critical alerting rule for alb_4xx detector"
  type        = bool
  default     = true
}

variable "alb_4xx_disabled_major" {
  description = "Disable major alerting rule for alb_4xx detector"
  type        = bool
  default     = null
}

variable "alb_4xx_disabled_minor" {
  description = "Disable minor alerting rule for alb_4xx detector"
  type        = bool
  default     = null
}

variable "alb_4xx_threshold_critical" {
  description = "Critical threshold for alb_4xx detector in %"
  type        = number
  default     = 99
}

variable "alb_4xx_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "15m"
}

variable "alb_4xx_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 0.9
}
variable "alb_4xx_threshold_major" {
  description = "Major threshold for alb_4xx detector in %"
  type        = number
  default     = 95
}

variable "alb_4xx_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "15m"
}

variable "alb_4xx_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 0.9
}
variable "alb_4xx_threshold_minor" {
  description = "Minor threshold for alb_4xx detector in %"
  type        = number
  default     = 90
}

variable "alb_4xx_lasting_duration_minor" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "15m"
}

variable "alb_4xx_at_least_percentage_minor" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 0.9
}
# target_5xx detector

variable "target_5xx_notifications" {
  description = "Notification recipients list per severity overridden for target_5xx detector"
  type        = map(list(string))
  default     = {}
}

variable "target_5xx_aggregation_function" {
  description = "Aggregation function and group by for target_5xx detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "target_5xx_transformation_function" {
  description = "Transformation function for target_5xx detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "target_5xx_max_delay" {
  description = "Enforce max delay for target_5xx detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "target_5xx_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "target_5xx_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "target_5xx_disabled" {
  description = "Disable all alerting rules for target_5xx detector"
  type        = bool
  default     = null
}

variable "target_5xx_disabled_critical" {
  description = "Disable critical alerting rule for target_5xx detector"
  type        = bool
  default     = null
}

variable "target_5xx_disabled_major" {
  description = "Disable major alerting rule for target_5xx detector"
  type        = bool
  default     = null
}

variable "target_5xx_threshold_critical" {
  description = "Critical threshold for target_5xx detector in %"
  type        = number
  default     = 10
}

variable "target_5xx_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "5m"
}

variable "target_5xx_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 0.9
}
variable "target_5xx_threshold_major" {
  description = "Major threshold for target_5xx detector in %"
  type        = number
  default     = 5
}

variable "target_5xx_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "5m"
}

variable "target_5xx_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 0.9
}
# target_4xx detector

variable "target_4xx_notifications" {
  description = "Notification recipients list per severity overridden for target_4xx detector"
  type        = map(list(string))
  default     = {}
}

variable "target_4xx_aggregation_function" {
  description = "Aggregation function and group by for target_4xx detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "target_4xx_transformation_function" {
  description = "Transformation function for target_4xx detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "target_4xx_max_delay" {
  description = "Enforce max delay for target_4xx detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "target_4xx_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "target_4xx_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "target_4xx_disabled" {
  description = "Disable all alerting rules for target_4xx detector"
  type        = bool
  default     = null
}

variable "target_4xx_disabled_critical" {
  description = "Disable critical alerting rule for target_4xx detector"
  type        = bool
  default     = true
}

variable "target_4xx_disabled_major" {
  description = "Disable major alerting rule for target_4xx detector"
  type        = bool
  default     = null
}

variable "target_4xx_disabled_minor" {
  description = "Disable minor alerting rule for target_4xx detector"
  type        = bool
  default     = null
}

variable "target_4xx_threshold_critical" {
  description = "Critical threshold for target_4xx detector in %"
  type        = number
  default     = 99
}

variable "target_4xx_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "15m"
}

variable "target_4xx_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 0.9
}
variable "target_4xx_threshold_major" {
  description = "Major threshold for target_4xx detector in %"
  type        = number
  default     = 95
}

variable "target_4xx_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "15m"
}

variable "target_4xx_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 0.9
}
variable "target_4xx_threshold_minor" {
  description = "Minor threshold for target_4xx detector in %"
  type        = number
  default     = 90
}

variable "target_4xx_lasting_duration_minor" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "15m"
}

variable "target_4xx_at_least_percentage_minor" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 0.9
}
# healthy detector

variable "healthy_notifications" {
  description = "Notification recipients list per severity overridden for healthy detector"
  type        = map(list(string))
  default     = {}
}

variable "healthy_aggregation_function" {
  description = "Aggregation function and group by for healthy detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "healthy_transformation_function" {
  description = "Transformation function for healthy detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "healthy_max_delay" {
  description = "Enforce max delay for healthy detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "healthy_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "healthy_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "healthy_disabled" {
  description = "Disable all alerting rules for healthy detector"
  type        = bool
  default     = null
}

variable "healthy_disabled_critical" {
  description = "Disable critical alerting rule for healthy detector"
  type        = bool
  default     = null
}

variable "healthy_disabled_major" {
  description = "Disable major alerting rule for healthy detector"
  type        = bool
  default     = null
}

variable "healthy_threshold_critical" {
  description = "Critical threshold for healthy detector in %"
  type        = number
  default     = 1
}

variable "healthy_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "5m"
}

variable "healthy_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "healthy_threshold_major" {
  description = "Major threshold for healthy detector in %"
  type        = number
  default     = 100
}

variable "healthy_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "5m"
}

variable "healthy_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
