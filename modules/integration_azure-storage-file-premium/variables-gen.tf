# capacity detector

variable "capacity_notifications" {
  description = "Notification recipients list per severity overridden for capacity detector"
  type        = map(list(string))
  default     = {}
}

variable "capacity_aggregation_function" {
  description = "Aggregation function and group by for capacity detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".fill(None, duration='1d').mean(by=['fileshare', 'azure_resource_id'])"
}

variable "capacity_transformation_function" {
  description = "Transformation function for capacity detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='1d')"
}

variable "capacity_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "capacity_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "capacity_disabled" {
  description = "Disable all alerting rules for capacity detector"
  type        = bool
  default     = null
}

variable "capacity_disabled_critical" {
  description = "Disable critical alerting rule for capacity detector"
  type        = bool
  default     = null
}

variable "capacity_disabled_major" {
  description = "Disable major alerting rule for capacity detector"
  type        = bool
  default     = null
}

variable "capacity_threshold_critical" {
  description = "Critical threshold for capacity detector in %"
  type        = number
  default     = 95
}

variable "capacity_threshold_major" {
  description = "Major threshold for capacity detector in %"
  type        = number
  default     = 90
}

# iops detector

variable "iops_notifications" {
  description = "Notification recipients list per severity overridden for iops detector"
  type        = map(list(string))
  default     = {}
}

variable "iops_aggregation_function" {
  description = "Aggregation function and group by for iops detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".sum(by=['FileShare', 'azure_resource_id'])"
}

variable "iops_transformation_function" {
  description = "Transformation function for iops detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='15m')"
}

variable "iops_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "iops_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "iops_disabled" {
  description = "Disable all alerting rules for iops detector"
  type        = bool
  default     = null
}

variable "iops_disabled_critical" {
  description = "Disable critical alerting rule for iops detector"
  type        = bool
  default     = null
}

variable "iops_disabled_major" {
  description = "Disable major alerting rule for iops detector"
  type        = bool
  default     = null
}

variable "iops_threshold_critical" {
  description = "Critical threshold for iops detector in %"
  type        = number
  default     = 95
}

variable "iops_threshold_major" {
  description = "Major threshold for iops detector in %"
  type        = number
  default     = 90
}

# egress detector

variable "egress_notifications" {
  description = "Notification recipients list per severity overridden for egress detector"
  type        = map(list(string))
  default     = {}
}

variable "egress_aggregation_function" {
  description = "Aggregation function and group by for egress detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".sum(by=['FileShare', 'azure_resource_id'])"
}

variable "egress_transformation_function" {
  description = "Transformation function for egress detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='15m')"
}

variable "egress_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "egress_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "egress_disabled" {
  description = "Disable all alerting rules for egress detector"
  type        = bool
  default     = null
}

variable "egress_disabled_critical" {
  description = "Disable critical alerting rule for egress detector"
  type        = bool
  default     = null
}

variable "egress_disabled_major" {
  description = "Disable major alerting rule for egress detector"
  type        = bool
  default     = null
}

variable "egress_threshold_critical" {
  description = "Critical threshold for egress detector in %"
  type        = number
  default     = 95
}

variable "egress_threshold_major" {
  description = "Major threshold for egress detector in %"
  type        = number
  default     = 90
}

# ingress detector

variable "ingress_notifications" {
  description = "Notification recipients list per severity overridden for ingress detector"
  type        = map(list(string))
  default     = {}
}

variable "ingress_aggregation_function" {
  description = "Aggregation function and group by for ingress detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".sum(by=['FileShare', 'azure_resource_id'])"
}

variable "ingress_transformation_function" {
  description = "Transformation function for ingress detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='15m')"
}

variable "ingress_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "ingress_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "ingress_disabled" {
  description = "Disable all alerting rules for ingress detector"
  type        = bool
  default     = null
}

variable "ingress_disabled_critical" {
  description = "Disable critical alerting rule for ingress detector"
  type        = bool
  default     = null
}

variable "ingress_disabled_major" {
  description = "Disable major alerting rule for ingress detector"
  type        = bool
  default     = null
}

variable "ingress_threshold_critical" {
  description = "Critical threshold for ingress detector in %"
  type        = number
  default     = 95
}

variable "ingress_threshold_major" {
  description = "Major threshold for ingress detector in %"
  type        = number
  default     = 90
}

# throttling detector

variable "throttling_notifications" {
  description = "Notification recipients list per severity overridden for throttling detector"
  type        = map(list(string))
  default     = {}
}

variable "throttling_aggregation_function" {
  description = "Aggregation function and group by for throttling detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".sum(by=['FileShare', 'azure_resource_id'])"
}

variable "throttling_transformation_function" {
  description = "Transformation function for throttling detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='15m')"
}

variable "throttling_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "throttling_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "throttling_disabled" {
  description = "Disable all alerting rules for throttling detector"
  type        = bool
  default     = null
}

variable "throttling_disabled_critical" {
  description = "Disable critical alerting rule for throttling detector"
  type        = bool
  default     = null
}

variable "throttling_disabled_major" {
  description = "Disable major alerting rule for throttling detector"
  type        = bool
  default     = null
}

variable "throttling_threshold_critical" {
  description = "Critical threshold for throttling detector in %"
  type        = number
  default     = 15
}

variable "throttling_threshold_major" {
  description = "Major threshold for throttling detector in %"
  type        = number
  default     = 0
}

# no_snapshots detector

variable "no_snapshots_notifications" {
  description = "Notification recipients list per severity overridden for no_snapshots detector"
  type        = map(list(string))
  default     = {}
}

variable "no_snapshots_aggregation_function" {
  description = "Aggregation function and group by for no_snapshots detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".fill(None, duration='1d').sum(by=['fileshare', 'azure_resource_id'])"
}

variable "no_snapshots_transformation_function" {
  description = "Transformation function for no_snapshots detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".max(over='1d')"
}

variable "no_snapshots_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "no_snapshots_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "no_snapshots_disabled" {
  description = "Disable all alerting rules for no_snapshots detector"
  type        = bool
  default     = null
}

variable "no_snapshots_threshold_major" {
  description = "Major threshold for no_snapshots detector"
  type        = number
  default     = 1
}

# snapshots_limit detector

variable "snapshots_limit_notifications" {
  description = "Notification recipients list per severity overridden for snapshots_limit detector"
  type        = map(list(string))
  default     = {}
}

variable "snapshots_limit_aggregation_function" {
  description = "Aggregation function and group by for snapshots_limit detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".fill(None, duration='1d').sum(by=['fileshare', 'azure_resource_id'])"
}

variable "snapshots_limit_transformation_function" {
  description = "Transformation function for snapshots_limit detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='1d')"
}

variable "snapshots_limit_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "snapshots_limit_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "snapshots_limit_disabled" {
  description = "Disable all alerting rules for snapshots_limit detector"
  type        = bool
  default     = null
}

variable "snapshots_limit_threshold_major" {
  description = "Major threshold for snapshots_limit detector"
  type        = number
  default     = 190
}

