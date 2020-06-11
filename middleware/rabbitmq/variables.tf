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

variable "heartbeat_disabled" {
  description = "Disable all alerting rules for heartbeat detector"
  type        = bool
  default     = null
}

variable "heartbeat_notifications" {
  description = "Notification recipients list for every alerting rules of heartbeat detector"
  type        = list
  default     = []
}

variable "heartbeat_timeframe" {
  description = "Timeframe for system not reporting detector (i.e. \"10m\")"
  type        = string
  default     = "20m"
}

variable "file_descriptors_disabled" {
  description = "Disable all alerting rules for file descriptors detector"
  type        = bool
  default     = null
}

variable "file_descriptors_disabled_critical" {
  description = "Disable critical alerting rule for file descriptors detector"
  type        = bool
  default     = null
}

variable "file_descriptors_disabled_warning" {
  description = "Disable warning alerting rule for file descriptors detector"
  type        = bool
  default     = null
}

variable "file_descriptors_notifications" {
  description = "Notification recipients list for every alerting rules of file descriptors detector"
  type        = list
  default     = []
}

variable "file_descriptors_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of file descriptors detector"
  type        = list
  default     = []
}

variable "file_descriptors_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of file descriptors detector"
  type        = list
  default     = []
}

variable "file_descriptors_aggregation_function" {
  description = "Aggregation function and group by for file descriptors detector (i.e. \".mean(by=['host']).\")"
  type        = string
  default     = ""
}

variable "file_descriptors_transformation_function" {
  description = "Transformation function for file descriptors detector (mean, min, max)"
  type        = string
  default     = "min"
}

variable "file_descriptors_transformation_window" {
  description = "Transformation window for file descriptors detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "10m"
}

variable "file_descriptors_threshold_critical" {
  description = "Critical threshold for file descriptors detector"
  type        = number
  default     = 90
}

variable "file_descriptors_threshold_warning" {
  description = "Warning threshold for file descriptors detector"
  type        = number
  default     = 80
}

variable "processes_disabled" {
  description = "Disable all alerting rules for processes detector"
  type        = bool
  default     = null
}

variable "processes_disabled_critical" {
  description = "Disable critical alerting rule for processes detector"
  type        = bool
  default     = null
}

variable "processes_disabled_warning" {
  description = "Disable warning alerting rule for processes detector"
  type        = bool
  default     = null
}

variable "processes_notifications" {
  description = "Notification recipients list for every alerting rules of processes detector"
  type        = list
  default     = []
}

variable "processes_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of processes detector"
  type        = list
  default     = []
}

variable "processes_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of processes detector"
  type        = list
  default     = []
}

variable "processes_aggregation_function" {
  description = "Aggregation function and group by for processes detector (i.e. \".mean(by=['host']).\")"
  type        = string
  default     = ""
}

variable "processes_transformation_function" {
  description = "Transformation function for processes detector (mean, min, max)"
  type        = string
  default     = "min"
}

variable "processes_transformation_window" {
  description = "Transformation window for processes detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "10m"
}

variable "processes_threshold_critical" {
  description = "Critical threshold for processes detector"
  type        = number
  default     = 90
}

variable "processes_threshold_warning" {
  description = "Warning threshold for processes detector"
  type        = number
  default     = 80
}

variable "sockets_disabled" {
  description = "Disable all alerting rules for sockets detector"
  type        = bool
  default     = null
}

variable "sockets_disabled_critical" {
  description = "Disable critical alerting rule for sockets detector"
  type        = bool
  default     = null
}

variable "sockets_disabled_warning" {
  description = "Disable warning alerting rule for sockets detector"
  type        = bool
  default     = null
}

variable "sockets_notifications" {
  description = "Notification recipients list for every alerting rules of sockets detector"
  type        = list
  default     = []
}

variable "sockets_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of sockets detector"
  type        = list
  default     = []
}

variable "sockets_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of sockets detector"
  type        = list
  default     = []
}

variable "sockets_aggregation_function" {
  description = "Aggregation function and group by for sockets detector (i.e. \".mean(by=['host']).\")"
  type        = string
  default     = ""
}

variable "sockets_transformation_function" {
  description = "Transformation function for sockets detector (mean, min, max)"
  type        = string
  default     = "min"
}

variable "sockets_transformation_window" {
  description = "Transformation window for sockets detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "10m"
}

variable "sockets_threshold_critical" {
  description = "Critical threshold for sockets detector"
  type        = number
  default     = 90
}

variable "sockets_threshold_warning" {
  description = "Warning threshold for sockets detector"
  type        = number
  default     = 80
}

variable "vm_memory_disabled" {
  description = "Disable all alerting rules for vm_memory detector"
  type        = bool
  default     = null
}

variable "vm_memory_disabled_critical" {
  description = "Disable critical alerting rule for vm_memory detector"
  type        = bool
  default     = null
}

variable "vm_memory_disabled_warning" {
  description = "Disable warning alerting rule for vm_memory detector"
  type        = bool
  default     = null
}

variable "vm_memory_notifications" {
  description = "Notification recipients list for every alerting rules of vm_memory detector"
  type        = list
  default     = []
}

variable "vm_memory_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of vm_memory detector"
  type        = list
  default     = []
}

variable "vm_memory_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of vm_memory detector"
  type        = list
  default     = []
}

variable "vm_memory_aggregation_function" {
  description = "Aggregation function and group by for vm_memory detector (i.e. \".mean(by=['host']).\")"
  type        = string
  default     = ""
}

variable "vm_memory_transformation_function" {
  description = "Transformation function for vm_memory detector (mean, min, max)"
  type        = string
  default     = "min"
}

variable "vm_memory_transformation_window" {
  description = "Transformation window for vm_memory detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "10m"
}

variable "vm_memory_threshold_critical" {
  description = "Critical threshold for vm_memory detector"
  type        = number
  default     = 90
}

variable "vm_memory_threshold_warning" {
  description = "Warning threshold for vm_memory detector"
  type        = number
  default     = 80
}

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
  description = "Transformation function for messages_ready detector (mean, min, max)"
  type        = string
  default     = "min"
}

variable "messages_ready_transformation_window" {
  description = "Transformation window for messages_ready detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "20m"
}

#
# Trigger an alert when the number of ready message is becoming too high in a queue
# Specifying multiple threshold and filter will create several detector 
#
variable "messages_ready_thresholds" {
  description = "Thresholds value for messages ready detector. Several filters can be associated to different thresholds. The filter field must be in the SignalFx filter format."
  type = map
  default = {
    default = {
        filter             = "filter('name', '*')"
        threshold_critical = "10000"
        threshold_warning  = "15000"
    }
  }
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
  description = "Transformation function for messages_unacknowledged detector (mean, min, max)"
  type        = string
  default     = "min"
}

variable "messages_unacknowledged_transformation_window" {
  description = "Transformation window for messages_unacknowledged detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "20m"
}

#
# Trigger an alert when the number of unack message is becoming too high in a queue
# Specifying multiple threshold and filter will create several detector 
#
variable "messages_unacknowledged_thresholds" {
  description = "Thresholds value for messages unacknowledged detector. Several filters can be associated to different thresholds. The filter field must be in the SignalFx filter format."
  type = map
  default = {
    default = {
        filter             = "filter('name', '*')"
        threshold_critical = "10000"
        threshold_warning  = "15000"
    }
  }
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

variable "messages_ack_rate_duration" {
  description = "Duration for messages_ack_rate detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "10m"
}

#
# Trigger an alert when the rate of acknownledged message is too low and
# there are messages ready in the queue
# Specifying multiple threshold and filter will create several detector 
#
variable "messages_ack_rate_thresholds" {
  description = "Thresholds value for messages ack rate detector. Several filters can be associated to different thresholds. The filter field must be in the SignalFx filter format."
  type = map
  default = {}
}

variable "consumer_utilisation_disabled" {
  description = "Disable all alerting rules for consumer_utilisation detector"
  type        = bool
  default     = true
}

variable "consumer_utilisation_disabled_critical" {
  description = "Disable critical alerting rule for consumer_utilisation detector"
  type        = bool
  default     = null
}

variable "consumer_utilisation_disabled_warning" {
  description = "Disable warning alerting rule for consumer_utilisation detector"
  type        = bool
  default     = null
}

variable "consumer_utilisation_notifications" {
  description = "Notification recipients list for every alerting rules of consumer_utilisation detector"
  type        = list
  default     = []
}

variable "consumer_utilisation_notifications_warning" {
  description = "Notification recipients list for warning alerting rule of consumer_utilisation detector"
  type        = list
  default     = []
}

variable "consumer_utilisation_notifications_critical" {
  description = "Notification recipients list for critical alerting rule of consumer_utilisation detector"
  type        = list
  default     = []
}

variable "consumer_utilisation_aggregation_function" {
  description = "Aggregation function and group by for consumer_utilisation detector (i.e. \".mean(by=['host']).\")"
  type        = string
  default     = ""
}

variable "consumer_utilisation_duration" {
  description = "Duration for consumer_utilisation detector (i.e. 5m, 20m, 1h, 1d)"
  type        = string
  default     = "10m"
}

#
# Trigger an alert when the consumer utilisation is too low and
# there are messages ready in the queue, often means that the consumers
# are too slow
# Specifying multiple threshold and filter will create several detector 
#
variable "consumer_utilisation_thresholds" {
  description = "Thresholds value for consumer_utilisation detector. Several filters can be associated to different thresholds. The filter field must be in the SignalFx filter format."
  type = map
  default = {
    "default" = {
        filter = "filter('name', '*')"
        threshold_critical = 0.8
        threshold_warning  = 1.0
    }
  }
}

