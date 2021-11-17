# activity_error_rate detector

variable "activity_error_rate_notifications" {
  description = "Notification recipients list per severity overridden for activity_error_rate detector"
  type        = map(list(string))
  default     = {}
}

variable "activity_error_rate_aggregation_function" {
  description = "Aggregation function and group by for activity_error_rate detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".sum(by=['name', 'azure_resource_group_name', 'azure_region'])"
}

variable "activity_error_rate_transformation_function" {
  description = "Transformation function for activity_error_rate detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='5m')"
}

variable "activity_error_rate_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "activity_error_rate_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "activity_error_rate_disabled" {
  description = "Disable all alerting rules for activity_error_rate detector"
  type        = bool
  default     = null
}

variable "activity_error_rate_disabled_critical" {
  description = "Disable critical alerting rule for activity_error_rate detector"
  type        = bool
  default     = null
}

variable "activity_error_rate_disabled_major" {
  description = "Disable major alerting rule for activity_error_rate detector"
  type        = bool
  default     = null
}

variable "activity_error_rate_threshold_critical" {
  description = "Critical threshold for activity_error_rate detector in %"
  type        = number
  default     = 20
}

variable "activity_error_rate_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "activity_error_rate_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "activity_error_rate_threshold_major" {
  description = "Major threshold for activity_error_rate detector in %"
  type        = number
  default     = 10
}

variable "activity_error_rate_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "activity_error_rate_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# pipeline_error_rate detector

variable "pipeline_error_rate_notifications" {
  description = "Notification recipients list per severity overridden for pipeline_error_rate detector"
  type        = map(list(string))
  default     = {}
}

variable "pipeline_error_rate_aggregation_function" {
  description = "Aggregation function and group by for pipeline_error_rate detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".sum(by=['name', 'azure_resource_group_name', 'azure_region'])"
}

variable "pipeline_error_rate_transformation_function" {
  description = "Transformation function for pipeline_error_rate detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='5m')"
}

variable "pipeline_error_rate_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "pipeline_error_rate_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "pipeline_error_rate_disabled" {
  description = "Disable all alerting rules for pipeline_error_rate detector"
  type        = bool
  default     = null
}

variable "pipeline_error_rate_disabled_critical" {
  description = "Disable critical alerting rule for pipeline_error_rate detector"
  type        = bool
  default     = null
}

variable "pipeline_error_rate_disabled_major" {
  description = "Disable major alerting rule for pipeline_error_rate detector"
  type        = bool
  default     = null
}

variable "pipeline_error_rate_threshold_critical" {
  description = "Critical threshold for pipeline_error_rate detector in %"
  type        = number
  default     = 20
}

variable "pipeline_error_rate_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "pipeline_error_rate_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "pipeline_error_rate_threshold_major" {
  description = "Major threshold for pipeline_error_rate detector in %"
  type        = number
  default     = 10
}

variable "pipeline_error_rate_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "pipeline_error_rate_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# trigger_error_rate detector

variable "trigger_error_rate_notifications" {
  description = "Notification recipients list per severity overridden for trigger_error_rate detector"
  type        = map(list(string))
  default     = {}
}

variable "trigger_error_rate_aggregation_function" {
  description = "Aggregation function and group by for trigger_error_rate detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".sum(by=['name', 'azure_resource_group_name', 'azure_region'])"
}

variable "trigger_error_rate_transformation_function" {
  description = "Transformation function for trigger_error_rate detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='5m')"
}

variable "trigger_error_rate_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "trigger_error_rate_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "trigger_error_rate_disabled" {
  description = "Disable all alerting rules for trigger_error_rate detector"
  type        = bool
  default     = null
}

variable "trigger_error_rate_disabled_critical" {
  description = "Disable critical alerting rule for trigger_error_rate detector"
  type        = bool
  default     = null
}

variable "trigger_error_rate_disabled_major" {
  description = "Disable major alerting rule for trigger_error_rate detector"
  type        = bool
  default     = null
}

variable "trigger_error_rate_threshold_critical" {
  description = "Critical threshold for trigger_error_rate detector"
  type        = number
  default     = 20
}

variable "trigger_error_rate_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "trigger_error_rate_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "trigger_error_rate_threshold_major" {
  description = "Major threshold for trigger_error_rate detector"
  type        = number
  default     = 10
}

variable "trigger_error_rate_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "trigger_error_rate_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# available_memory detector

variable "available_memory_notifications" {
  description = "Notification recipients list per severity overridden for available_memory detector"
  type        = map(list(string))
  default     = {}
}

variable "available_memory_aggregation_function" {
  description = "Aggregation function and group by for available_memory detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".sum(by=['azure_resource_name', 'azure_resource_group_name', 'azure_region'])"
}

variable "available_memory_transformation_function" {
  description = "Transformation function for available_memory detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='15m')"
}

variable "available_memory_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "available_memory_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "available_memory_disabled" {
  description = "Disable all alerting rules for available_memory detector"
  type        = bool
  default     = null
}

variable "available_memory_disabled_critical" {
  description = "Disable critical alerting rule for available_memory detector"
  type        = bool
  default     = null
}

variable "available_memory_disabled_major" {
  description = "Disable major alerting rule for available_memory detector"
  type        = bool
  default     = null
}

variable "available_memory_threshold_critical" {
  description = "Critical threshold for available_memory detector in Mebibyte"
  type        = number
  default     = 256
}

variable "available_memory_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "available_memory_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "available_memory_threshold_major" {
  description = "Major threshold for available_memory detector in Mebibyte"
  type        = number
  default     = 512
}

variable "available_memory_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "available_memory_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# cpu_percentage detector

variable "cpu_percentage_notifications" {
  description = "Notification recipients list per severity overridden for cpu_percentage detector"
  type        = map(list(string))
  default     = {}
}

variable "cpu_percentage_aggregation_function" {
  description = "Aggregation function and group by for cpu_percentage detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".sum(by=['azure_resource_name', 'azure_resource_group_name', 'azure_region'])"
}

variable "cpu_percentage_transformation_function" {
  description = "Transformation function for cpu_percentage detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='15m')"
}

variable "cpu_percentage_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "cpu_percentage_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "cpu_percentage_disabled" {
  description = "Disable all alerting rules for cpu_percentage detector"
  type        = bool
  default     = null
}

variable "cpu_percentage_disabled_critical" {
  description = "Disable critical alerting rule for cpu_percentage detector"
  type        = bool
  default     = null
}

variable "cpu_percentage_disabled_major" {
  description = "Disable major alerting rule for cpu_percentage detector"
  type        = bool
  default     = null
}

variable "cpu_percentage_threshold_critical" {
  description = "Critical threshold for cpu_percentage detector in %"
  type        = number
  default     = 90
}

variable "cpu_percentage_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "cpu_percentage_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "cpu_percentage_threshold_major" {
  description = "Major threshold for cpu_percentage detector in %"
  type        = number
  default     = 80
}

variable "cpu_percentage_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "cpu_percentage_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
