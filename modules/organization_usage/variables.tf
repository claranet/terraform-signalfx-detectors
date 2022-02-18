# Module specific

variable "is_parent" {
  description = "Use \"child version\" of org metrics if true. Disable for child org."
  type        = bool
  default     = true
}

variable "multiplier" {
  description = "Multiplier should be 2 for \"enterprise\" or 1 for \"pro\" plan (i.e. 2 = 200 custom metrics and 20 containers per host)."
  type        = number
  default     = 2
}

# hosts_limit detector

variable "hosts_limit_max_delay" {
  description = "Enforce max delay for hosts_limit detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "hosts_limit_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = <<-EOF
    To avoid overbilling, limits are set per organization and per resources type.
EOF
}

variable "hosts_limit_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "hosts_limit_disabled" {
  description = "Disable all alerting rules for hosts_limit detector"
  type        = bool
  default     = null
}

variable "hosts_limit_notifications" {
  description = "Notification recipients list per severity overridden for hosts_limit detector"
  type        = map(list(string))
  default     = {}
}

variable "hosts_limit_transformation_function" {
  description = "Transformation function for hosts_limit detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".mean(over='4w')"
}

# containers_limit detector

variable "containers_limit_max_delay" {
  description = "Enforce max delay for containers_limit detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "containers_limit_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = <<-EOF
    To avoid overbilling, limits are set per organization and per resources type.
EOF
}

variable "containers_limit_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "containers_limit_disabled" {
  description = "Disable all alerting rules for containers_limit detector"
  type        = bool
  default     = null
}

variable "containers_limit_notifications" {
  description = "Notification recipients list per severity overridden for containers_limit detector"
  type        = map(list(string))
  default     = {}
}

variable "containers_limit_transformation_function" {
  description = "Transformation function for containers_limit detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".mean(over='4w')"
}

# custom_metrics_limit detector

variable "custom_metrics_limit_max_delay" {
  description = "Enforce max delay for custom_metrics_limit detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "custom_metrics_limit_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = <<-EOF
    To avoid overbilling, limits are set per organization and per resources type.
EOF
}

variable "custom_metrics_limit_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "custom_metrics_limit_disabled" {
  description = "Disable all alerting rules for custom_metrics_limit detector"
  type        = bool
  default     = null
}

variable "custom_metrics_limit_notifications" {
  description = "Notification recipients list per severity overridden for custom_metrics_limit detector"
  type        = map(list(string))
  default     = {}
}

variable "custom_metrics_limit_transformation_function" {
  description = "Transformation function for custom_metrics_limit detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".mean(over='4w')"
}

# containers_ratio detector

variable "containers_ratio_max_delay" {
  description = "Enforce max delay for containers_ratio detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "containers_ratio_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = <<-EOF
    Enterprise plan includes 20 containers per host.
    Standard plan includes 10 containers per host.
    Exceeding this will be paid as extra.
    Current billing will be increased by this ratio.
EOF
}

variable "containers_ratio_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "containers_ratio_disabled" {
  description = "Disable all alerting rules for containers_ratio detector"
  type        = bool
  default     = null
}

variable "containers_ratio_notifications" {
  description = "Notification recipients list per severity overridden for containers_ratio detector"
  type        = map(list(string))
  default     = {}
}

variable "containers_ratio_transformation_function" {
  description = "Transformation function for containers_ratio detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".mean(over='4w')"
}

variable "containers_ratio_threshold_major" {
  description = "Major threshold for containers_ratio detector"
  type        = number
  default     = 100
}

# custom_metrics_ratio detector

variable "custom_metrics_ratio_max_delay" {
  description = "Enforce max delay for custom_metrics_ratio detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "custom_metrics_ratio_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = <<-EOF
    Enterprise plan includes 200 custom metrics per host.
    Standard plan includes 100 custom metrics per host.
    Exceeding this will be paid as extra.
    Current billing will be increased by this ratio.
EOF
}

variable "custom_metrics_ratio_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "custom_metrics_ratio_disabled" {
  description = "Disable all alerting rules for custom_metrics_ratio detector"
  type        = bool
  default     = null
}

variable "custom_metrics_ratio_notifications" {
  description = "Notification recipients list per severity overridden for custom_metrics_ratio detector"
  type        = map(list(string))
  default     = {}
}

variable "custom_metrics_ratio_transformation_function" {
  description = "Transformation function for custom_metrics_ratio detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".mean(over='4w')"
}

variable "custom_metrics_ratio_threshold_major" {
  description = "Major threshold for custom_metrics_ratio detector"
  type        = number
  default     = 100
}

