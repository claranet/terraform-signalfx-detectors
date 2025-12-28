variable "heartbeat_detector_enabled" {
  description = "Enable heartbeat detector"
  type        = bool
  default     = true
}

variable "healthy_instances_detector_enabled" {
  description = "Enable healthy instances detector"
  type        = bool
  default     = true
}
