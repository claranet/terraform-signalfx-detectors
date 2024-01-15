# server-health detector

variable "server-health_notifications" {
  description = "Notification recipients list per severity overridden for server-health detector"
  type        = map(list(string))
  default     = {}
}

variable "server-health_transformation_function" {
  description = "Transformation function for server-health detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "server-health_max_delay" {
  description = "Enforce max delay for server-health detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "server-health_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "server-health_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "server-health_disabled" {
  description = "Disable all alerting rules for server-health detector"
  type        = bool
  default     = null
}

variable "server-health_threshold_major" {
  description = "Major threshold for server-health detector"
  type        = number
  default     = 1
}

variable "server-health_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "5m"
}

variable "server-health_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# cluster-health detector

variable "cluster-health_notifications" {
  description = "Notification recipients list per severity overridden for cluster-health detector"
  type        = map(list(string))
  default     = {}
}

variable "cluster-health_aggregation_function" {
  description = "Aggregation function and group by for cluster-health detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['kubernetes_cluster'])"
}

variable "cluster-health_transformation_function" {
  description = "Transformation function for cluster-health detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "cluster-health_max_delay" {
  description = "Enforce max delay for cluster-health detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "cluster-health_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "cluster-health_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "cluster-health_disabled" {
  description = "Disable all alerting rules for cluster-health detector"
  type        = bool
  default     = null
}

variable "cluster-health_threshold_critical" {
  description = "Critical threshold for cluster-health detector"
  type        = number
  default     = 1
}

variable "cluster-health_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "5m"
}

variable "cluster-health_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# server-latency detector

variable "server-latency_notifications" {
  description = "Notification recipients list per severity overridden for server-latency detector"
  type        = map(list(string))
  default     = {}
}

variable "server-latency_transformation_function" {
  description = "Transformation function for server-latency detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "server-latency_max_delay" {
  description = "Enforce max delay for server-latency detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "server-latency_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "server-latency_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "server-latency_disabled" {
  description = "Disable all alerting rules for server-latency detector"
  type        = bool
  default     = null
}

variable "server-latency_threshold_major" {
  description = "Major threshold for server-latency detector"
  type        = number
  default     = 250000
}

variable "server-latency_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "5m"
}

variable "server-latency_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# cluster-latency detector

variable "cluster-latency_notifications" {
  description = "Notification recipients list per severity overridden for cluster-latency detector"
  type        = map(list(string))
  default     = {}
}

variable "cluster-latency_aggregation_function" {
  description = "Aggregation function and group by for cluster-latency detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['kubernetes_cluster'])"
}

variable "cluster-latency_transformation_function" {
  description = "Transformation function for cluster-latency detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "cluster-latency_max_delay" {
  description = "Enforce max delay for cluster-latency detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "cluster-latency_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "cluster-latency_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "cluster-latency_disabled" {
  description = "Disable all alerting rules for cluster-latency detector"
  type        = bool
  default     = null
}

variable "cluster-latency_threshold_critical" {
  description = "Critical threshold for cluster-latency detector"
  type        = number
  default     = 300000
}

variable "cluster-latency_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "5m"
}

variable "cluster-latency_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
