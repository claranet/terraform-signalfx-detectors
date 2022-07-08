# Module specific

# Heartbeat detector

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

variable "heartbeat_notifications" {
  description = "Notification recipients list per severity overridden for heartbeat detector"
  type        = map(list(string))
  default     = {}
}

variable "heartbeat_timeframe" {
  description = "Timeframe for heartbeat detector (i.e. \"10m\")"
  type        = string
  default     = "10m"
}

variable "heartbeat_aggregation_function" {
  description = "Aggregation function and group by for heartbeat detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['DomainName'])"
}

# Cluster_status detector

variable "cluster_status_max_delay" {
  description = "Enforce max delay for cluster_status detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "cluster_status_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "cluster_status_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "cluster_status_disabled" {
  description = "Disable all alerting rules for cluster_status detector"
  type        = bool
  default     = null
}

variable "cluster_status_disabled_critical" {
  description = "Disable critical alerting rule for cluster_status detector"
  type        = bool
  default     = null
}

variable "cluster_status_disabled_major" {
  description = "Disable major alerting rule for cluster_status detector"
  type        = bool
  default     = null
}

variable "cluster_status_notifications" {
  description = "Notification recipients list per severity overridden for cluster_status detector"
  type        = map(list(string))
  default     = {}
}

variable "cluster_status_aggregation_function" {
  description = "Aggregation function and group by for cluster_status detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "cluster_status_transformation_function" {
  description = "Transformation function for cluster_status detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='15m')"
}

# Free_space detector

variable "free_space_max_delay" {
  description = "Enforce max delay for free_space detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "free_space_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "free_space_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "free_space_disabled" {
  description = "Disable all alerting rules for free_space detector"
  type        = bool
  default     = null
}

variable "free_space_disabled_critical" {
  description = "Disable critical alerting rule for free_space detector"
  type        = bool
  default     = null
}

variable "free_space_disabled_major" {
  description = "Disable major alerting rule for free_space detector"
  type        = bool
  default     = null
}

variable "free_space_notifications" {
  description = "Notification recipients list per severity overridden for free_space detector"
  type        = map(list(string))
  default     = {}
}

variable "free_space_aggregation_function" {
  description = "Aggregation function and group by for free_space detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "free_space_transformation_function" {
  description = "Transformation function for free_space detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "free_space_threshold_critical" {
  description = "Critical threshold for free_space detector"
  type        = number
  default     = 20
}

variable "free_space_threshold_major" {
  description = "Major threshold for free_space detector"
  type        = number
  default     = 40
}

# ultrawarm_free_space detector

variable "ultrawarm_free_space_max_delay" {
  description = "Enforce max delay for ultrawarm_free_space detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "ultrawarm_free_space_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "ultrawarm_free_space_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "ultrawarm_free_space_disabled" {
  description = "Disable all alerting rules for ultrawarm_free_space detector"
  type        = bool
  default     = null
}

variable "ultrawarm_free_space_disabled_critical" {
  description = "Disable critical alerting rule for ultrawarm_free_space detector"
  type        = bool
  default     = null
}

variable "ultrawarm_free_space_disabled_major" {
  description = "Disable major alerting rule for ultrawarm_free_space detector"
  type        = bool
  default     = null
}

variable "ultrawarm_free_space_notifications" {
  description = "Notification recipients list per severity overridden for ultrawarm_free_space detector"
  type        = map(list(string))
  default     = {}
}

variable "ultrawarm_free_space_aggregation_function" {
  description = "Aggregation function and group by for ultrawarm_free_space detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "ultrawarm_free_space_transformation_function" {
  description = "Transformation function for ultrawarm_free_space detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "ultrawarm_free_space_threshold_critical" {
  description = "Critical threshold for ultrawarm_free_space detector"
  type        = number
  default     = 10
}

variable "ultrawarm_free_space_threshold_major" {
  description = "Major threshold for ultrawarm_free_space detector"
  type        = number
  default     = 15
}

# CPU_90_15min detector

variable "cpu_90_15min_max_delay" {
  description = "Enforce max delay for cpu_90_15min detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "cpu_90_15min_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "cpu_90_15min_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "cpu_90_15min_disabled" {
  description = "Disable all alerting rules for cpu_90_15min detector"
  type        = bool
  default     = null
}

variable "cpu_90_15min_disabled_critical" {
  description = "Disable critical alerting rule for cpu_90_15min detector"
  type        = bool
  default     = null
}

variable "cpu_90_15min_disabled_major" {
  description = "Disable major alerting rule for cpu_90_15min detector"
  type        = bool
  default     = null
}

variable "cpu_90_15min_notifications" {
  description = "Notification recipients list per severity overridden for cpu_90_15min detector"
  type        = map(list(string))
  default     = {}
}

variable "cpu_90_15min_aggregation_function" {
  description = "Aggregation function and group by for cpu_90_15min detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "cpu_90_15min_transformation_function" {
  description = "Transformation function for cpu_90_15min detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='45m')"
}

variable "cpu_90_15min_threshold_critical" {
  description = "Critical threshold for cpu_90_15min detector"
  type        = number
  default     = 90
}

variable "cpu_90_15min_threshold_major" {
  description = "Major threshold for cpu_90_15min detector"
  type        = number
  default     = 80
}

# master_cpu_90_15min detector

variable "master_cpu_90_15min_max_delay" {
  description = "Enforce max delay for master_cpu_90_15min detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "master_cpu_90_15min_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "master_cpu_90_15min_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "master_cpu_90_15min_disabled" {
  description = "Disable all alerting rules for master_cpu_90_15min detector"
  type        = bool
  default     = null
}

variable "master_cpu_90_15min_disabled_critical" {
  description = "Disable critical alerting rule for master_cpu_90_15min detector"
  type        = bool
  default     = null
}

variable "master_cpu_90_15min_disabled_major" {
  description = "Disable major alerting rule for master_cpu_90_15min detector"
  type        = bool
  default     = null
}

variable "master_cpu_90_15min_notifications" {
  description = "Notification recipients list per severity overridden for master_cpu_90_15min detector"
  type        = map(list(string))
  default     = {}
}

variable "master_cpu_90_15min_aggregation_function" {
  description = "Aggregation function and group by for master_cpu_90_15min detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "master_cpu_90_15min_transformation_function" {
  description = "Transformation function for master_cpu_90_15min detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='20m')"
}

variable "master_cpu_90_15min_threshold_critical" {
  description = "Critical threshold for master_cpu_90_15min detector"
  type        = number
  default     = 70
}

variable "master_cpu_90_15min_threshold_major" {
  description = "Major threshold for master_cpu_90_15min detector"
  type        = number
  default     = 50
}
