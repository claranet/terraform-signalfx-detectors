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

variable "heartbeat_transformation_function" {
  description = "Transformation function for heartbeat detector (i.e. \".mean(over='5m')\")"
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

# php_fpm_connect_idle detector

variable "php_fpm_connect_idle_notifications" {
  description = "Notification recipients list per severity overridden for php_fpm_connect_idle detector"
  type        = map(list(string))
  default     = {}
}

variable "php_fpm_connect_idle_aggregation_function" {
  description = "Aggregation function and group by for php_fpm_connect_idle detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "php_fpm_connect_idle_transformation_function" {
  description = "Transformation function for php_fpm_connect_idle detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".mean(over='10m')"
}

variable "php_fpm_connect_idle_max_delay" {
  description = "Enforce max delay for php_fpm_connect_idle detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "php_fpm_connect_idle_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "php_fpm_connect_idle_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "php_fpm_connect_idle_disabled" {
  description = "Disable all alerting rules for php_fpm_connect_idle detector"
  type        = bool
  default     = null
}

variable "php_fpm_connect_idle_disabled_critical" {
  description = "Disable critical alerting rule for php_fpm_connect_idle detector"
  type        = bool
  default     = null
}

variable "php_fpm_connect_idle_disabled_major" {
  description = "Disable major alerting rule for php_fpm_connect_idle detector"
  type        = bool
  default     = null
}

variable "php_fpm_connect_idle_threshold_critical" {
  description = "Critical threshold for php_fpm_connect_idle detector"
  type        = number
  default     = 90
}

variable "php_fpm_connect_idle_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "php_fpm_connect_idle_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "php_fpm_connect_idle_threshold_major" {
  description = "Major threshold for php_fpm_connect_idle detector"
  type        = number
  default     = 80
}

variable "php_fpm_connect_idle_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "php_fpm_connect_idle_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
