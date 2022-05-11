# Module specific

variable "use_otel_receiver" {
  description = "Set to true when metrics are collected by redisreceiver from otel collector instead of collectd/redis monitor of smart agent."
  type        = bool
  default     = false
}
