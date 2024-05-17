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
  description = "Timeframe for heartbeat detector (i.e. \"25m\"). Must be at least \"25m\" if exclude_not_running_vm is true"
  type        = string
  default     = "25m"
}

# server_status detector

variable "server_status_notifications" {
  description = "Notification recipients list per severity overridden for server_status detector"
  type        = map(list(string))
  default     = {}
}

variable "server_status_aggregation_function" {
  description = "Aggregation function and group by for server_status detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "server_status_transformation_function" {
  description = "Transformation function for server_status detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".max(over='5m')"
}

variable "server_status_max_delay" {
  description = "Enforce max delay for server_status detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "server_status_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "server_status_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "server_status_disabled" {
  description = "Disable all alerting rules for server_status detector"
  type        = bool
  default     = null
}

variable "server_status_threshold_critical" {
  description = "Critical threshold for server_status detector"
  type        = number
  default     = 1
}

variable "server_status_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "server_status_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# backend_status detector

variable "backend_status_notifications" {
  description = "Notification recipients list per severity overridden for backend_status detector"
  type        = map(list(string))
  default     = {}
}

variable "backend_status_aggregation_function" {
  description = "Aggregation function and group by for backend_status detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "backend_status_transformation_function" {
  description = "Transformation function for backend_status detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".max(over='5m')"
}

variable "backend_status_max_delay" {
  description = "Enforce max delay for backend_status detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "backend_status_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "backend_status_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "backend_status_disabled" {
  description = "Disable all alerting rules for backend_status detector"
  type        = bool
  default     = null
}

variable "backend_status_threshold_critical" {
  description = "Critical threshold for backend_status detector"
  type        = number
  default     = 1
}

variable "backend_status_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "backend_status_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# session_limit detector

variable "session_limit_notifications" {
  description = "Notification recipients list per severity overridden for session_limit detector"
  type        = map(list(string))
  default     = {}
}

variable "session_limit_aggregation_function" {
  description = "Aggregation function and group by for session_limit detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "session_limit_transformation_function" {
  description = "Transformation function for session_limit detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='10m')"
}

variable "session_limit_max_delay" {
  description = "Enforce max delay for session_limit detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "session_limit_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "session_limit_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "session_limit_disabled" {
  description = "Disable all alerting rules for session_limit detector"
  type        = bool
  default     = null
}

variable "session_limit_disabled_critical" {
  description = "Disable critical alerting rule for session_limit detector"
  type        = bool
  default     = null
}

variable "session_limit_disabled_major" {
  description = "Disable major alerting rule for session_limit detector"
  type        = bool
  default     = null
}

variable "session_limit_threshold_critical" {
  description = "Critical threshold for session_limit detector"
  type        = number
  default     = 90
}

variable "session_limit_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "session_limit_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "session_limit_threshold_major" {
  description = "Major threshold for session_limit detector"
  type        = number
  default     = 80
}

variable "session_limit_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "session_limit_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# http_5xx_response detector

variable "http_5xx_response_notifications" {
  description = "Notification recipients list per severity overridden for http_5xx_response detector"
  type        = map(list(string))
  default     = {}
}

variable "http_5xx_response_aggregation_function" {
  description = "Aggregation function and group by for http_5xx_response detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "http_5xx_response_transformation_function" {
  description = "Transformation function for http_5xx_response detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='10m')"
}

variable "http_5xx_response_max_delay" {
  description = "Enforce max delay for http_5xx_response detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "http_5xx_response_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "http_5xx_response_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "http_5xx_response_disabled" {
  description = "Disable all alerting rules for http_5xx_response detector"
  type        = bool
  default     = null
}

variable "http_5xx_response_disabled_critical" {
  description = "Disable critical alerting rule for http_5xx_response detector"
  type        = bool
  default     = null
}

variable "http_5xx_response_disabled_major" {
  description = "Disable major alerting rule for http_5xx_response detector"
  type        = bool
  default     = null
}

variable "http_5xx_response_threshold_critical" {
  description = "Critical threshold for http_5xx_response detector"
  type        = number
  default     = 80
}

variable "http_5xx_response_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "http_5xx_response_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "http_5xx_response_threshold_major" {
  description = "Major threshold for http_5xx_response detector"
  type        = number
  default     = 50
}

variable "http_5xx_response_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "http_5xx_response_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
# http_4xx_response detector

variable "http_4xx_response_notifications" {
  description = "Notification recipients list per severity overridden for http_4xx_response detector"
  type        = map(list(string))
  default     = {}
}

variable "http_4xx_response_aggregation_function" {
  description = "Aggregation function and group by for http_4xx_response detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "http_4xx_response_transformation_function" {
  description = "Transformation function for http_4xx_response detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ".min(over='15m')"
}

variable "http_4xx_response_max_delay" {
  description = "Enforce max delay for http_4xx_response detector (use \"0\" or \"null\" for \"Auto\")"
  type        = number
  default     = null
}

variable "http_4xx_response_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "http_4xx_response_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "http_4xx_response_disabled" {
  description = "Disable all alerting rules for http_4xx_response detector"
  type        = bool
  default     = null
}

variable "http_4xx_response_disabled_critical" {
  description = "Disable critical alerting rule for http_4xx_response detector"
  type        = bool
  default     = null
}

variable "http_4xx_response_disabled_major" {
  description = "Disable major alerting rule for http_4xx_response detector"
  type        = bool
  default     = null
}

variable "http_4xx_response_disabled_minor" {
  description = "Disable minor alerting rule for http_4xx_response detector"
  type        = bool
  default     = null
}

variable "http_4xx_response_threshold_critical" {
  description = "Critical threshold for http_4xx_response detector"
  type        = number
  default     = 99
}

variable "http_4xx_response_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "http_4xx_response_at_least_percentage_critical" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "http_4xx_response_threshold_major" {
  description = "Major threshold for http_4xx_response detector"
  type        = number
  default     = 95
}

variable "http_4xx_response_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "http_4xx_response_at_least_percentage_major" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
variable "http_4xx_response_threshold_minor" {
  description = "Minor threshold for http_4xx_response detector"
  type        = number
  default     = 90
}

variable "http_4xx_response_lasting_duration_minor" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = null
}

variable "http_4xx_response_at_least_percentage_minor" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 1
}
