# Global

variable "environment" {
  description = "Infrastructure environment"
  type        = string
}

# SignalFx module specific

variable "notifications" {
  description = "Notification recipients list for every detectors"
  type        = list
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

# RabbitMQ detectors specific

variable "messages_ready_disabled" {
  description = "Disable all alerting rules for messages_ready detector"
  type        = bool
  default     = null
}

variable "messages_ready_disabled_critical" {
  description = "Disable critical alerting rule for messages_ready detector"
  type        = bool
  default     = null
}

variable "messages_ready_disabled_warning" {
  description = "Disable warning alerting rule for messages_ready detector"
  type        = bool
  default     = null
}

variable "messages_ready_notifications" {
  description = "Notification recipients list for every alerting rules of messages_ready detector"
  type        = list
  default     = []
}

variable "messages_ready_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of messages_ready detector"
  type        = list
  default     = []
}

variable "messages_ready_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of messages_ready detector"
  type        = list
  default     = []
}

variable "messages_ready_aggregation_function" {
  description = "Aggregation function and group by for messages_ready detector (i.e. \".mean(by=['host']).\")"
  type        = string
  default     = ""
}

variable "messages_ready_transformation_function" {
  description = "Transformation function for messages_ready detector (i.e. \".mean(over='5m')\"))"
  type        = string
  default     = ".min(over='20m')"
}

variable "messages_ready_threshold_warning" {
  description = "Warning threshold for messages ready detector."
  type        = number
  default     = 10000
}

variable "messages_ready_threshold_critical" {
  description = "Critical threshold for messages ready detector."
  type        = number
  default     = 15000
}

variable "messages_unacknowledged_disabled" {
  description = "Disable all alerting rules for messages_unacknowledged detector"
  type        = bool
  default     = true
}

variable "messages_unacknowledged_disabled_critical" {
  description = "Disable critical alerting rule for messages_unacknowledged detector"
  type        = bool
  default     = null
}

variable "messages_unacknowledged_disabled_warning" {
  description = "Disable warning alerting rule for messages_unacknowledged detector"
  type        = bool
  default     = null
}

variable "messages_unacknowledged_notifications" {
  description = "Notification recipients list for every alerting rules of messages_unacknowledged detector"
  type        = list
  default     = []
}

variable "messages_unacknowledged_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of messages_unacknowledged detector"
  type        = list
  default     = []
}

variable "messages_unacknowledged_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of messages_unacknowledged detector"
  type        = list
  default     = []
}

variable "messages_unacknowledged_aggregation_function" {
  description = "Aggregation function and group by for messages_unacknowledged detector (i.e. \".mean(by=['host']).\")"
  type        = string
  default     = ""
}

variable "messages_unacknowledged_transformation_function" {
  description = "Transformation function for messages_unacknowledged detector (i.e. \".mean(over='5m')\"))"
  type        = string
  default     = ".min(over='20m')"
}

variable "messages_unacknowledged_threshold_warning" {
  description = "Warning threshold for messages unacknowledged detector."
  type        = number
  default     = 10000
}

variable "messages_unacknowledged_threshold_critical" {
  description = "Critical threshold for messages unacknowledged detector."
  type        = number
  default     = 15000
}

variable "messages_ack_rate_disabled" {
  description = "Disable all alerting rules for messages_ack_rate detector"
  type        = bool
  default     = true
}

variable "messages_ack_rate_disabled_critical" {
  description = "Disable critical alerting rule for messages_ack_rate detector"
  type        = bool
  default     = null
}

variable "messages_ack_rate_disabled_warning" {
  description = "Disable warning alerting rule for messages_ack_rate detector"
  type        = bool
  default     = null
}

variable "messages_ack_rate_notifications" {
  description = "Notification recipients list for every alerting rules of messages_ack_rate detector"
  type        = list
  default     = []
}

variable "messages_ack_rate_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of messages_ack_rate detector"
  type        = list
  default     = []
}

variable "messages_ack_rate_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of messages_ack_rate detector"
  type        = list
  default     = []
}

variable "messages_ack_rate_aggregation_function" {
  description = "Aggregation function and group by for messages_ack_rate detector (i.e. \".mean(by=['host']).\")"
  type        = string
  default     = ""
}

variable "messages_ack_rate_lasting_duration_seconds" {
  description = "Minimum duration that conditions must be true before raising alert (in seconds)"
  type        = number
  default     = 600
}

variable "messages_ack_rate_at_least_percentage" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 0.9
}

variable "messages_ack_rate_threshold_warning" {
  description = "Warning threshold for messages ack rate detector. Specify it as a string with a rate, 2/60 means 2 ack per minute."
  type        = string
  default     = "2/60"
}

variable "messages_ack_rate_threshold_critical" {
  description = "Critical threshold for messages ack rate detector. Specify it as a string with a rate, 2/60 means 2 ack per minute."
  type        = string
  default     = "1/60"
}

variable "consumer_use_disabled" {
  description = "Disable all alerting rules for consumer_use detector"
  type        = bool
  default     = true
}

variable "consumer_use_disabled_critical" {
  description = "Disable critical alerting rule for consumer_use detector"
  type        = bool
  default     = null
}

variable "consumer_use_disabled_warning" {
  description = "Disable warning alerting rule for consumer_use detector"
  type        = bool
  default     = null
}

variable "consumer_use_notifications" {
  description = "Notification recipients list for every alerting rules of consumer_use detector"
  type        = list
  default     = []
}

variable "consumer_use_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of consumer_use detector"
  type        = list
  default     = []
}

variable "consumer_use_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of consumer_use detector"
  type        = list
  default     = []
}

variable "consumer_use_aggregation_function" {
  description = "Aggregation function and group by for consumer_use detector (i.e. \".mean(by=['host']).\")"
  type        = string
  default     = ""
}

variable "consumer_use_lasting_duration_seconds" {
  description = "Minimum duration that conditions must be true before raising alert (in seconds)"
  type        = number
  default     = 600
}

variable "consumer_use_at_least_percentage" {
  description = "Percentage of lasting that conditions must be true before raising alert (>= 0.0 and <= 1.0)"
  type        = number
  default     = 0.9
}

variable "consumer_use_threshold_warning" {
  description = "Warning threshold for consumer use detector."
  type        = number
  default     = 1.0
}

variable "consumer_use_threshold_critical" {
  description = "Critical threshold for consumer use detector."
  type        = string
  default     = 0.8
}

