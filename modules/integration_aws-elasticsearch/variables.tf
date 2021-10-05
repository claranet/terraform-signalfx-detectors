# Module specific

# Heartbeat detector

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
  default     = "20m"
}

variable "heartbeat_aggregation_function" {
  description = "Aggregation function and group by for heartbeat detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['DomainName'])"
}

# Cluster_status detector

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
  default     = ".max(over='10m')"
}

variable "free_space_threshold_critical" {
  description = "Critical threshold for free_space detector"
  type        = number
  default     = 20480
}

variable "free_space_threshold_major" {
  description = "Major threshold for free_space detector"
  type        = number
  default     = 40960
}

# CPU_90_15min detector

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

# JVMMemoryPressure detector

variable "jvm_memory_pressure_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = "The cluster could encounter out of memory errors if usage increases. Consider scaling vertically."
}

variable "jvm_memory_pressure_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "jvm_memory_pressure_disabled" {
  description = "Disable all alerting rules for jvm_memory_pressure detector"
  type        = bool
  default     = true
}

variable "jvm_memory_pressure_disabled_critical" {
  description = "Disable critical alerting rule for jvm_memory_pressure detector"
  type        = bool
  default     = null
}

variable "jvm_memory_pressure_disabled_major" {
  description = "Disable major alerting rule for jvm_memory_pressure detector"
  type        = bool
  default     = null
}

variable "jvm_memory_pressure_notifications" {
  description = "Notification recipients list per severity overridden for jvm_memory_pressure detector"
  type        = map(list(string))
  default     = {}
}

variable "jvm_memory_pressure_aggregation_function" {
  description = "Aggregation function and group by for jvm_memory_pressure detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "jvm_memory_pressure_transformation_function" {
  description = "Transformation function for jvm_memory_pressure detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='15m')"
}

variable "jvm_memory_pressure_threshold_critical" {
  description = "Critical threshold for jvm_memory_pressure detector"
  type        = number
  default     = 90
}

variable "jvm_memory_pressure_threshold_major" {
  description = "Major threshold for jvm_memory_pressure detector"
  type        = number
  default     = 80
}
