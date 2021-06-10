output "signalflow" {
  description = "The full signalflow filtering string to use in detectors"
  value       = var.filtering_custom == "" ? var.filtering_default : (var.append_mode ? format("(%s) and (%s)", var.filtering_default, var.filtering_custom) : var.filtering_custom)
}

