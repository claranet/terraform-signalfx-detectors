# heartbeat detector

variable "heartbeat_notifications" {
  description = "Notification recipients list per severity overridden for heartbeat detector"
  type        = map(list(string))
  default     = {}
}

variable "heartbeat_aggregation_function" {
  description = "Aggregation function and group by for heartbeat detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['LoadBalancerName'])"
}

variable "heartbeat_max_delay" {
  description = "Enforce max delay for heartbeat detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = 900
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
  description = "Timeframe for heartbeat detector (i.e. \"10m\")"
  type        = string
  default     = "10m"
}

# backend_latency detector

variable "backend_latency_notifications" {
  description = "Notification recipients list per severity overridden for backend_latency detector"
  type        = map(list(string))
  default     = {}
}

variable "backend_latency_aggregation_function" {
  description = "Aggregation function and group by for backend_latency detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "backend_latency_transformation_function" {
  description = "Transformation function for backend_latency detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "backend_latency_max_delay" {
  description = "Enforce max delay for backend_latency detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "backend_latency_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "backend_latency_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "backend_latency_disabled" {
  description = "Disable all alerting rules for backend_latency detector"
  type        = bool
  default     = null
}

variable "backend_latency_disabled_critical" {
  description = "Disable critical alerting rule for backend_latency detector"
  type        = bool
  default     = null
}

variable "backend_latency_disabled_major" {
  description = "Disable major alerting rule for backend_latency detector"
  type        = bool
  default     = null
}

variable "backend_latency_threshold_critical" {
  description = "Critical threshold for backend_latency detector in Second"
  type        = number
  default     = 1
}

variable "backend_latency_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "10m"
}

variable "backend_latency_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 0.9
}
variable "backend_latency_threshold_major" {
  description = "Major threshold for backend_latency detector in Second"
  type        = number
  default     = 3
}

variable "backend_latency_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "10m"
}

variable "backend_latency_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 0.9
}
# elb_5xx detector

variable "elb_5xx_notifications" {
  description = "Notification recipients list per severity overridden for elb_5xx detector"
  type        = map(list(string))
  default     = {}
}

variable "elb_5xx_aggregation_function" {
  description = "Aggregation function and group by for elb_5xx detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "elb_5xx_transformation_function" {
  description = "Transformation function for elb_5xx detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "elb_5xx_max_delay" {
  description = "Enforce max delay for elb_5xx detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "elb_5xx_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "elb_5xx_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "elb_5xx_disabled" {
  description = "Disable all alerting rules for elb_5xx detector"
  type        = bool
  default     = null
}

variable "elb_5xx_disabled_critical" {
  description = "Disable critical alerting rule for elb_5xx detector"
  type        = bool
  default     = null
}

variable "elb_5xx_disabled_major" {
  description = "Disable major alerting rule for elb_5xx detector"
  type        = bool
  default     = null
}

variable "elb_5xx_threshold_critical" {
  description = "Critical threshold for elb_5xx detector in %"
  type        = number
  default     = 10
}

variable "elb_5xx_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "5m"
}

variable "elb_5xx_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 0.9
}
variable "elb_5xx_threshold_major" {
  description = "Major threshold for elb_5xx detector in %"
  type        = number
  default     = 5
}

variable "elb_5xx_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "5m"
}

variable "elb_5xx_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 0.9
}
# elb_4xx detector

variable "elb_4xx_notifications" {
  description = "Notification recipients list per severity overridden for elb_4xx detector"
  type        = map(list(string))
  default     = {}
}

variable "elb_4xx_aggregation_function" {
  description = "Aggregation function and group by for elb_4xx detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "elb_4xx_transformation_function" {
  description = "Transformation function for elb_4xx detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "elb_4xx_max_delay" {
  description = "Enforce max delay for elb_4xx detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "elb_4xx_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "elb_4xx_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "elb_4xx_disabled" {
  description = "Disable all alerting rules for elb_4xx detector"
  type        = bool
  default     = null
}

variable "elb_4xx_disabled_critical" {
  description = "Disable critical alerting rule for elb_4xx detector"
  type        = bool
  default     = null
}

variable "elb_4xx_disabled_major" {
  description = "Disable major alerting rule for elb_4xx detector"
  type        = bool
  default     = null
}

variable "elb_4xx_threshold_critical" {
  description = "Critical threshold for elb_4xx detector in %"
  type        = number
  default     = 40
}

variable "elb_4xx_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "5m"
}

variable "elb_4xx_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 0.9
}
variable "elb_4xx_threshold_major" {
  description = "Major threshold for elb_4xx detector in %"
  type        = number
  default     = 20
}

variable "elb_4xx_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "5m"
}

variable "elb_4xx_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 0.9
}
# backend_5xx detector

variable "backend_5xx_notifications" {
  description = "Notification recipients list per severity overridden for backend_5xx detector"
  type        = map(list(string))
  default     = {}
}

variable "backend_5xx_aggregation_function" {
  description = "Aggregation function and group by for backend_5xx detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "backend_5xx_transformation_function" {
  description = "Transformation function for backend_5xx detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "backend_5xx_max_delay" {
  description = "Enforce max delay for backend_5xx detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "backend_5xx_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "backend_5xx_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "backend_5xx_disabled" {
  description = "Disable all alerting rules for backend_5xx detector"
  type        = bool
  default     = null
}

variable "backend_5xx_disabled_critical" {
  description = "Disable critical alerting rule for backend_5xx detector"
  type        = bool
  default     = null
}

variable "backend_5xx_disabled_major" {
  description = "Disable major alerting rule for backend_5xx detector"
  type        = bool
  default     = null
}

variable "backend_5xx_threshold_critical" {
  description = "Critical threshold for backend_5xx detector in %"
  type        = number
  default     = 10
}

variable "backend_5xx_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "5m"
}

variable "backend_5xx_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 0.9
}
variable "backend_5xx_threshold_major" {
  description = "Major threshold for backend_5xx detector in %"
  type        = number
  default     = 5
}

variable "backend_5xx_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "5m"
}

variable "backend_5xx_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 0.9
}
# backend_4xx detector

variable "backend_4xx_notifications" {
  description = "Notification recipients list per severity overridden for backend_4xx detector"
  type        = map(list(string))
  default     = {}
}

variable "backend_4xx_aggregation_function" {
  description = "Aggregation function and group by for backend_4xx detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "backend_4xx_transformation_function" {
  description = "Transformation function for backend_4xx detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "backend_4xx_max_delay" {
  description = "Enforce max delay for backend_4xx detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "backend_4xx_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "backend_4xx_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "backend_4xx_disabled" {
  description = "Disable all alerting rules for backend_4xx detector"
  type        = bool
  default     = null
}

variable "backend_4xx_disabled_critical" {
  description = "Disable critical alerting rule for backend_4xx detector"
  type        = bool
  default     = null
}

variable "backend_4xx_disabled_major" {
  description = "Disable major alerting rule for backend_4xx detector"
  type        = bool
  default     = null
}

variable "backend_4xx_threshold_critical" {
  description = "Critical threshold for backend_4xx detector in %"
  type        = number
  default     = 40
}

variable "backend_4xx_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "5m"
}

variable "backend_4xx_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 0.9
}
variable "backend_4xx_threshold_major" {
  description = "Major threshold for backend_4xx detector in %"
  type        = number
  default     = 20
}

variable "backend_4xx_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "5m"
}

variable "backend_4xx_at_least_percentage_major" {
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
