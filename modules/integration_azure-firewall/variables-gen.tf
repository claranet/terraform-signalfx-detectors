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

variable "heartbeat_timeframe" {
  description = "Timeframe for heartbeat detector (i.e. \"10m\")"
  type        = string
  default     = "20m"
}

# snat_port_utilization detector

variable "snat_port_utilization_notifications" {
  description = "Notification recipients list per severity overridden for snat_port_utilization detector"
  type        = map(list(string))
  default     = {}
}

variable "snat_port_utilization_aggregation_function" {
  description = "Aggregation function and group by for snat_port_utilization detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['protocol'])"
}

variable "snat_port_utilization_transformation_function" {
  description = "Transformation function for snat_port_utilization detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "snat_port_utilization_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = ""
}

variable "snat_port_utilization_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "snat_port_utilization_disabled" {
  description = "Disable all alerting rules for snat_port_utilization detector"
  type        = bool
  default     = null
}

variable "snat_port_utilization_disabled_critical" {
  description = "Disable critical alerting rule for snat_port_utilization detector"
  type        = bool
  default     = null
}

variable "snat_port_utilization_disabled_major" {
  description = "Disable major alerting rule for snat_port_utilization detector"
  type        = bool
  default     = null
}

variable "snat_port_utilization_threshold_critical" {
  description = "Critical threshold for snat_port_utilization detector"
  type        = number
  default     = 85
}

variable "snat_port_utilization_threshold_major" {
  description = "Major threshold for snat_port_utilization detector"
  type        = number
  default     = 95
}

# throughput detector

variable "throughput_notifications" {
  description = "Notification recipients list per severity overridden for throughput detector"
  type        = map(list(string))
  default     = {}
}

variable "throughput_aggregation_function" {
  description = "Aggregation function and group by for throughput detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "throughput_transformation_function" {
  description = "Transformation function for throughput detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "throughput_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = <<-EOF
    Firewall will autoscale at 2.5Gbps but the maximum throughput is 30Gbps
EOF
}

variable "throughput_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "throughput_disabled" {
  description = "Disable all alerting rules for throughput detector"
  type        = bool
  default     = null
}

variable "throughput_disabled_critical" {
  description = "Disable critical alerting rule for throughput detector"
  type        = bool
  default     = null
}

variable "throughput_disabled_major" {
  description = "Disable major alerting rule for throughput detector"
  type        = bool
  default     = null
}

variable "throughput_disabled_minor" {
  description = "Disable minor alerting rule for throughput detector"
  type        = bool
  default     = null
}

variable "throughput_disabled_warning" {
  description = "Disable warning alerting rule for throughput detector"
  type        = bool
  default     = null
}

variable "throughput_threshold_critical" {
  description = "Critical threshold for throughput detector"
  type        = number
  default     = 29696
}

variable "throughput_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "300s"
}

variable "throughput_threshold_major" {
  description = "Major threshold for throughput detector"
  type        = number
  default     = 27648
}

variable "throughput_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "300s"
}

variable "throughput_threshold_minor" {
  description = "Minor threshold for throughput detector"
  type        = number
  default     = 25600
}

variable "throughput_lasting_duration_minor" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "300s"
}

variable "throughput_threshold_warning" {
  description = "Warning threshold for throughput detector"
  type        = number
  default     = 3072
}

variable "throughput_lasting_duration_warning" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "300s"
}

# health_state detector

variable "health_state_notifications" {
  description = "Notification recipients list per severity overridden for health_state detector"
  type        = map(list(string))
  default     = {}
}

variable "health_state_aggregation_function" {
  description = "Aggregation function and group by for health_state detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "health_state_transformation_function" {
  description = "Transformation function for health_state detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "health_state_tip" {
  description = "Suggested first course of action or any note useful for incident handling"
  type        = string
  default     = <<-EOF
    Firewall Health state is explained here: https://docs.microsoft.com/en-us/azure/firewall/logs-and-metrics#metrics
EOF
}

variable "health_state_runbook_url" {
  description = "URL like SignalFx dashboard or wiki page which can help to troubleshoot the incident cause"
  type        = string
  default     = ""
}

variable "health_state_disabled" {
  description = "Disable all alerting rules for health_state detector"
  type        = bool
  default     = null
}

variable "health_state_disabled_critical" {
  description = "Disable critical alerting rule for health_state detector"
  type        = bool
  default     = null
}

variable "health_state_disabled_major" {
  description = "Disable major alerting rule for health_state detector"
  type        = bool
  default     = null
}

variable "health_state_threshold_critical" {
  description = "Critical threshold for health_state detector"
  type        = number
  default     = 50
}

variable "health_state_lasting_duration_critical" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "5m"
}

variable "health_state_threshold_major" {
  description = "Major threshold for health_state detector"
  type        = number
  default     = 100
}

variable "health_state_lasting_duration_major" {
  description = "Minimum duration that conditions must be true before raising alert"
  type        = string
  default     = "5m"
}

