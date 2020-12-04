# Module specific

# Heartbeat detector

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
  description = "Timeframe for heartbeat detector (i.e. \"10m\")"
  type        = string
  default     = "20m"
}

variable "heartbeat_aggregation_function" {
  description = "Aggregation function and group by for heartbeat detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ".mean(by=['VpnId'])"
}

# VPN_status detector

variable "vpn_status_disabled" {
  description = "Disable all alerting rules for vpn_status detector"
  type        = bool
  default     = null
}

variable "vpn_status_disabled_critical" {
  description = "Disable critical alerting rule for vpn_status detector"
  type        = bool
  default     = null
}

variable "vpn_status_notifications" {
  description = "Notification recipients list per severity overridden for vpn_status detector"
  type        = map(list(string))
  default     = {}
}

variable "vpn_status_aggregation_function" {
  description = "Aggregation function and group by for vpn_status detector (i.e. \".mean(by=['host'])\")"
  type        = string
  default     = ""
}

variable "vpn_status_transformation_function" {
  description = "Transformation function for vpn_status detector (mean, min, max)"
  type        = string
  default     = ".max(over='5m')"
}

variable "vpn_status_threshold_critical" {
  description = "Critical threshold for vpn_status detector"
  type        = number
  default     = 1
}

