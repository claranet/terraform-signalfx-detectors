variable "heartbeat_detector_enabled" {
  description = "Enable heartbeat detector"
  type        = bool
  default     = true
}

variable "cpu_usage_detector_enabled" {
  description = "Enable cpu usage detector"
  type        = bool
  default     = true
}

variable "free_space_detector_enabled" {
  description = "Enable free space detector"
  type        = bool
  default     = true
}

variable "replica_lag_detector_enabled" {
  description = "Enable replica lag detector"
  type        = bool
  default     = true
}

variable "dbload_detector_enabled" {
  description = "Enable dbload detector"
  type        = bool
  default     = true
}
