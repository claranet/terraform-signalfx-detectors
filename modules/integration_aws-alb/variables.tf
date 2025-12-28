variable "heartbeat_detector_enabled" {
  description = "Enable heartbeat detector"
  type        = bool
  default     = true
}

variable "latency_detector_enabled" {
  description = "Enable latency detector"
  type        = bool
  default     = true
}

variable "lb_5xx_detector_enabled" {
  description = "Enable lb 5xx detector"
  type        = bool
  default     = true
}

variable "lb_4xx_detector_enabled" {
  description = "Enable lb 4xx detector"
  type        = bool
  default     = true
}

variable "target_5xx_detector_enabled" {
  description = "Enable target 5xx detector"
  type        = bool
  default     = true
}

variable "target_4xx_detector_enabled" {
  description = "Enable target 4xx detector"
  type        = bool
  default     = true
}

variable "healthy_detector_enabled" {
  description = "Enable healthy detector"
  type        = bool
  default     = true
}

# Module specific

variable "minimum_traffic" {
  description = "Minimum required traffic to evaluate rate of errors detectors"
  type        = number
  default     = 4
}
