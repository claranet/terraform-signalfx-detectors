# Global

variable "environment" {
  description = "Infrastructure environment"
  type        = string
}

variable "gcp_project_id" {
  description = "GCP project id used for default filtering while lables are not synced"
  type        = string
}

# SignalFx module specific

variable "notifications" {
  description = "Default notification recipients list per severity"
  type = object({
    critical = list(string)
    major    = list(string)
    minor    = list(string)
    warning  = list(string)
    info     = list(string)
  })
}

variable "prefixes" {
  description = "Prefixes list to prepend between brackets on every monitors names before environment"
  type        = list
  default     = []
}

variable "filter_custom_includes" {
  description = "List of tags to include when custom filtering is used"
  type        = list
  default     = []
}

variable "filter_custom_excludes" {
  description = "List of tags to exclude when custom filtering is used"
  type        = list
  default     = []
}

variable "detectors_disabled" {
  description = "Disable all detectors in this module"
  type        = bool
  default     = false
}

# GCP PubSub subscription detectors specific

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
  description = "Timeframe for system not reporting detector (i.e. \"10m\")"
  type        = string
  default     = "20m"
}

# Oldest_unacked_message detectors

variable "oldest_unacked_message_disabled" {
  description = "Disable all alerting rules for oldest_unacked_message detector"
  type        = bool
  default     = null
}

variable "oldest_unacked_message_disabled_critical" {
  description = "Disable critical alerting rule for oldest_unacked_message detector"
  type        = bool
  default     = null
}

variable "oldest_unacked_message_disabled_major" {
  description = "Disable major alerting rule for oldest_unacked_message detector"
  type        = bool
  default     = null
}

variable "oldest_unacked_message_notifications" {
  description = "Notification recipients list per severity overridden for oldest_unacked_message detector"
  type        = map(list(string))
  default     = {}
}

variable "oldest_unacked_message_aggregation_function" {
  description = "Aggregation function and group by for oldest_unacked_message detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "oldest_unacked_message_transformation_function" {
  description = "Transformation function for oldest_unacked_message detector (i.e. \".mean(over='5m')\"))"
  type        = string
  default     = ".min(over='5m')"
}

variable "oldest_unacked_message_threshold_critical" {
  description = "Critical threshold for oldest_unacked_message detector"
  type        = number
  default     = 120
}

variable "oldest_unacked_message_threshold_major" {
  description = "Major threshold for oldest_unacked_message detector"
  type        = number
  default     = 30
}

# Push_latency detectors

variable "push_latency_disabled" {
  description = "Disable all alerting rules for push_latency detector"
  type        = bool
  default     = null
}

variable "push_latency_disabled_critical" {
  description = "Disable critical alerting rule for push_latency detector"
  type        = bool
  default     = null
}

variable "push_latency_disabled_major" {
  description = "Disable major alerting rule for push_latency detector"
  type        = bool
  default     = null
}

variable "push_latency_notifications" {
  description = "Notification recipients list per severity overridden for push_latency detector"
  type        = map(list(string))
  default     = {}
}

variable "push_latency_aggregation_function" {
  description = "Aggregation function and group by for push_latency detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "push_latency_transformation_function" {
  description = "Transformation function for push_latency detector (i.e. \".mean(over='5m')\"))"
  type        = string
  default     = ".min(over='15m')"
}

variable "push_latency_threshold_critical" {
  description = "Critical threshold for push_latency detector"
  type        = number
  default     = 5000000
}

variable "push_latency_threshold_major" {
  description = "Major threshold for push_latency detector"
  type        = number
  default     = 1000000
}

