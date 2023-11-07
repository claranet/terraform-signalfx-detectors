# Module specific

variable "agent_per_cpu_enabled" {
  description = "Is `perCPU` option is enabled for the load monitor in the agent configuration"
  type        = bool
  default     = true
}
