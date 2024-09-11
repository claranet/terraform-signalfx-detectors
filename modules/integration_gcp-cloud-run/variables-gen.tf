# cpu_utilizations detector

variable "cpu_utilizations_notifications" {
  description = "Notification recipients list per severity overridden for cpu_utilizations detector"
  type        = map(list(string))
  default     = {}
}

variable "cpu_utilizations_aggregation_function" {
  description = "Aggregation function and group by for cpu_utilizations detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "cpu_utilizations_transformation_function" {
  description = "Transformation function for cpu_utilizations detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='30m')"
}

variable "cpu_utilizations_max_delay" {
  description = "Enforce max delay for cpu_utilizations detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "cpu_utilizations_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "cpu_utilizations_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "cpu_utilizations_disabled" {
  description = "Disable all alerting rules for cpu_utilizations detector"
  type        = bool
  default     = null
}

variable "cpu_utilizations_disabled_critical" {
  description = "Disable critical alerting rule for cpu_utilizations detector"
  type        = bool
  default     = null
}

variable "cpu_utilizations_disabled_major" {
  description = "Disable major alerting rule for cpu_utilizations detector"
  type        = bool
  default     = null
}

variable "cpu_utilizations_threshold_critical" {
  description = "Critical threshold for cpu_utilizations detector in %"
  type        = number
  default     = 90
}

variable "cpu_utilizations_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "cpu_utilizations_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "cpu_utilizations_threshold_major" {
  description = "Major threshold for cpu_utilizations detector in %"
  type        = number
  default     = 85
}

variable "cpu_utilizations_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "cpu_utilizations_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# memory_utilizations detector

variable "memory_utilizations_notifications" {
  description = "Notification recipients list per severity overridden for memory_utilizations detector"
  type        = map(list(string))
  default     = {}
}

variable "memory_utilizations_aggregation_function" {
  description = "Aggregation function and group by for memory_utilizations detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "memory_utilizations_transformation_function" {
  description = "Transformation function for memory_utilizations detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='30m')"
}

variable "memory_utilizations_max_delay" {
  description = "Enforce max delay for memory_utilizations detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "memory_utilizations_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "memory_utilizations_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "memory_utilizations_disabled" {
  description = "Disable all alerting rules for memory_utilizations detector"
  type        = bool
  default     = null
}

variable "memory_utilizations_disabled_critical" {
  description = "Disable critical alerting rule for memory_utilizations detector"
  type        = bool
  default     = null
}

variable "memory_utilizations_disabled_major" {
  description = "Disable major alerting rule for memory_utilizations detector"
  type        = bool
  default     = null
}

variable "memory_utilizations_threshold_critical" {
  description = "Critical threshold for memory_utilizations detector in %"
  type        = number
  default     = 95
}

variable "memory_utilizations_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "memory_utilizations_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "memory_utilizations_threshold_major" {
  description = "Major threshold for memory_utilizations detector in %"
  type        = number
  default     = 90
}

variable "memory_utilizations_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "memory_utilizations_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# cloudsql_connections_refused_to_requests_ratio detector

variable "cloudsql_connections_refused_to_requests_ratio_notifications" {
  description = "Notification recipients list per severity overridden for cloudsql_connections_refused_to_requests_ratio detector"
  type        = map(list(string))
  default     = {}
}

variable "cloudsql_connections_refused_to_requests_ratio_aggregation_function" {
  description = "Aggregation function and group by for cloudsql_connections_refused_to_requests_ratio detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".count(by=['response_code_class'])"
}

variable "cloudsql_connections_refused_to_requests_ratio_transformation_function" {
  description = "Transformation function for cloudsql_connections_refused_to_requests_ratio detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "cloudsql_connections_refused_to_requests_ratio_max_delay" {
  description = "Enforce max delay for cloudsql_connections_refused_to_requests_ratio detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "cloudsql_connections_refused_to_requests_ratio_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "cloudsql_connections_refused_to_requests_ratio_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "cloudsql_connections_refused_to_requests_ratio_disabled" {
  description = "Disable all alerting rules for cloudsql_connections_refused_to_requests_ratio detector"
  type        = bool
  default     = null
}

variable "cloudsql_connections_refused_to_requests_ratio_disabled_critical" {
  description = "Disable critical alerting rule for cloudsql_connections_refused_to_requests_ratio detector"
  type        = bool
  default     = null
}

variable "cloudsql_connections_refused_to_requests_ratio_disabled_major" {
  description = "Disable major alerting rule for cloudsql_connections_refused_to_requests_ratio detector"
  type        = bool
  default     = null
}

variable "cloudsql_connections_refused_to_requests_ratio_threshold_critical" {
  description = "Critical threshold for cloudsql_connections_refused_to_requests_ratio detector in %"
  type        = number
  default     = 5
}

variable "cloudsql_connections_refused_to_requests_ratio_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "1h"
}

variable "cloudsql_connections_refused_to_requests_ratio_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 0.5
}
variable "cloudsql_connections_refused_to_requests_ratio_threshold_major" {
  description = "Major threshold for cloudsql_connections_refused_to_requests_ratio detector in %"
  type        = number
  default     = 0
}

variable "cloudsql_connections_refused_to_requests_ratio_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "1h"
}

variable "cloudsql_connections_refused_to_requests_ratio_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 0.5
}
