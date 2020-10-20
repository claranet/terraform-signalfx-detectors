resource "signalfx_detector" "storage_capacity" {
  name = format("%s %s", local.detector_name_prefix, "Azure Storage Account used capacity")

  program_text = <<-EOF
        base_filter = filter('resource_type', 'Microsoft.Storage/storageAccounts') and filter('primary_aggregation_type', 'true')
        signal = data('UsedCapacity', filter=base_filter and ${module.filter-tags.filter_custom})${var.storage_capacity_aggregation_function}.publish('signal')
        detect(when(signal > threshold(${var.storage_capacity_threshold_critical}), lasting="${var.storage_capacity_timer}")).publish('CRIT')
        detect(when(signal > threshold(${var.storage_capacity_threshold_major}), lasting="${var.storage_capacity_timer}") and when(signal <= ${var.storage_capacity_threshold_critical})).publish('MAJOR')
      EOF

  rule {
    description           = "is too high > ${var.storage_capacity_threshold_critical} octets"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.storage_capacity_disabled_critical, var.storage_capacity_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.storage_capacity_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = local.rule_subject_novalue
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "is too high > ${var.storage_capacity_threshold_major} octets"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.storage_capacity_disabled_major, var.storage_capacity_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.storage_capacity_notifications, "major", []), var.notifications.major)
    parameterized_subject = local.rule_subject_novalue
    parameterized_body    = local.rule_body
  }
}
