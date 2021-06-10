output "filter_custom" {
  description = "The full filtering pattern to use in detectors"
  value       = var.filter_custom == "" ? var.filter_defaults : (var.append_mode ? format("(%s) and (%s)", var.filter_defaults, var.filter_custom) : var.filter_custom)
}

