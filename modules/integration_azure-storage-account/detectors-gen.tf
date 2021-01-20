resource "signalfx_detector" "count" {
  name = format("%s %s", local.detector_name_prefix, "Azure Storage Account count")

  authorized_writer_teams = var.authorized_writer_teams

  program_text = <<-EOF
    base_filtering = filter('resource_type', 'Microsoft.Storage/storageAccounts') and filter('primary_aggregation_type', 'true')
    capacity = data('UsedCapacity', filter=base_filtering and ${module.filter-tags.filter_custom})${var.count_aggregation_function}${var.count_transformation_function}
    signal = capacity.fill(None, duration='1d').publish('signal')
    detect(when(signal > ${var.count_threshold_critical})).publish('CRIT')
    detect(when(signal > ${var.count_threshold_major}) and when(signal <= ${var.count_threshold_critical})).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.count_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.count_disabled_critical, var.count_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.count_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.count_runbook_url, var.runbook_url), "")
    tip                   = var.count_tip
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "is too high > ${var.count_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.count_disabled_major, var.count_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.count_notifications, "major", []), var.notifications.major)
    runbook_url           = try(coalesce(var.count_runbook_url, var.runbook_url), "")
    tip                   = var.count_tip
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "capacity" {
  name = format("%s %s", local.detector_name_prefix, "Azure Storage Account capacity")

  authorized_writer_teams = var.authorized_writer_teams

  viz_options {
    label        = "signal"
    value_suffix = "PiB"
  }

  program_text = <<-EOF
    base_filtering = filter('resource_type', 'Microsoft.Storage/storageAccounts') and filter('primary_aggregation_type', 'true')
    capacity = data('UsedCapacity', filter=base_filtering and ${module.filter-tags.filter_custom})${var.capacity_aggregation_function}${var.capacity_transformation_function}
    signal = capacity.scale(0.0000000000000008881784197001252).publish('signal')
    detect(when(signal > ${var.capacity_threshold_critical})).publish('CRIT')
    detect(when(signal > ${var.capacity_threshold_major}) and when(signal <= ${var.capacity_threshold_critical})).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.capacity_threshold_critical}PiB"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.capacity_disabled_critical, var.capacity_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.capacity_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.capacity_runbook_url, var.runbook_url), "")
    tip                   = var.capacity_tip
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "is too high > ${var.capacity_threshold_major}PiB"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.capacity_disabled_major, var.capacity_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.capacity_notifications, "major", []), var.notifications.major)
    runbook_url           = try(coalesce(var.capacity_runbook_url, var.runbook_url), "")
    tip                   = var.capacity_tip
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "ingress" {
  name = format("%s %s", local.detector_name_prefix, "Azure Storage Account ingress")

  authorized_writer_teams = var.authorized_writer_teams

  viz_options {
    label        = "signal"
    value_suffix = "Gbps"
  }

  program_text = <<-EOF
    base_filtering = filter('resource_type', 'Microsoft.Storage/storageAccounts') and filter('primary_aggregation_type', 'true')
    ingress = data('Ingress', filter=base_filtering and ${module.filter-tags.filter_custom}, rollup='rate')${var.ingress_aggregation_function}${var.ingress_transformation_function}
    signal = ingress.scale(0.000000008).publish('signal')
    detect(when(signal > ${var.ingress_threshold_critical})).publish('CRIT')
    detect(when(signal > ${var.ingress_threshold_major}) and when(signal <= ${var.ingress_threshold_critical})).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.ingress_threshold_critical}Gbps"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.ingress_disabled_critical, var.ingress_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.ingress_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.ingress_runbook_url, var.runbook_url), "")
    tip                   = var.ingress_tip
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "is too high > ${var.ingress_threshold_major}Gbps"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.ingress_disabled_major, var.ingress_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.ingress_notifications, "major", []), var.notifications.major)
    runbook_url           = try(coalesce(var.ingress_runbook_url, var.runbook_url), "")
    tip                   = var.ingress_tip
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "egress" {
  name = format("%s %s", local.detector_name_prefix, "Azure Storage Account egress")

  authorized_writer_teams = var.authorized_writer_teams

  viz_options {
    label        = "signal"
    value_suffix = "Gbps"
  }

  program_text = <<-EOF
    base_filtering = filter('resource_type', 'Microsoft.Storage/storageAccounts') and filter('primary_aggregation_type', 'true')
    egress = data('Egress', filter=base_filtering and ${module.filter-tags.filter_custom}, rollup='rate')${var.egress_aggregation_function}${var.egress_transformation_function}
    signal = egress.scale(0.000000008).publish('signal')
    detect(when(signal > ${var.egress_threshold_critical})).publish('CRIT')
    detect(when(signal > ${var.egress_threshold_major}) and when(signal <= ${var.egress_threshold_critical})).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.egress_threshold_critical}Gbps"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.egress_disabled_critical, var.egress_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.egress_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.egress_runbook_url, var.runbook_url), "")
    tip                   = var.egress_tip
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "is too high > ${var.egress_threshold_major}Gbps"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.egress_disabled_major, var.egress_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.egress_notifications, "major", []), var.notifications.major)
    runbook_url           = try(coalesce(var.egress_runbook_url, var.runbook_url), "")
    tip                   = var.egress_tip
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "requests_rate" {
  name = format("%s %s", local.detector_name_prefix, "Azure Storage Account requests rate")

  authorized_writer_teams = var.authorized_writer_teams

  program_text = <<-EOF
    base_filtering = filter('resource_type', 'Microsoft.Storage/storageAccounts') and filter('primary_aggregation_type', 'true')
    signal = data('Transactions', filter=base_filtering and ${module.filter-tags.filter_custom}, rollup='rate')${var.requests_rate_aggregation_function}${var.requests_rate_transformation_function}.publish('signal')
    detect(when(signal > ${var.requests_rate_threshold_critical})).publish('CRIT')
    detect(when(signal > ${var.requests_rate_threshold_major}) and when(signal <= ${var.requests_rate_threshold_critical})).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.requests_rate_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.requests_rate_disabled_critical, var.requests_rate_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.requests_rate_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.requests_rate_runbook_url, var.runbook_url), "")
    tip                   = var.requests_rate_tip
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "is too high > ${var.requests_rate_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.requests_rate_disabled_major, var.requests_rate_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.requests_rate_notifications, "major", []), var.notifications.major)
    runbook_url           = try(coalesce(var.requests_rate_runbook_url, var.runbook_url), "")
    tip                   = var.requests_rate_tip
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "requests_rate_status" {
  name = format("%s %s", local.detector_name_prefix, "Azure Storage Account requests rate status")

  authorized_writer_teams = var.authorized_writer_teams

  program_text = <<-EOF
    base_filtering = filter('resource_type', 'Microsoft.Storage/storageAccounts') and filter('primary_aggregation_type', 'true')
    rate_success = data('Transactions', filter=base_filtering and filter('responsetype', 'Success') and ${module.filter-tags.filter_custom}, rollup='sum')${var.requests_rate_status_aggregation_function}${var.requests_rate_status_transformation_function}
    rate_failed = data('Transactions', filter=base_filtering and not filter('responsetype', 'Success') and ${module.filter-tags.filter_custom}, rollup='sum')${var.requests_rate_status_aggregation_function}${var.requests_rate_status_transformation_function}
    signal = (rate_failed/(rate_success+rate_failed)).scale(100).fill(0).publish('signal')
    detect(when(signal > ${var.requests_rate_status_threshold_critical})).publish('CRIT')
    detect(when(signal > ${var.requests_rate_status_threshold_major}) and when(signal <= ${var.requests_rate_status_threshold_critical})).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.requests_rate_status_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.requests_rate_status_disabled_critical, var.requests_rate_status_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.requests_rate_status_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.requests_rate_status_runbook_url, var.runbook_url), "")
    tip                   = var.requests_rate_status_tip
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "is too high > ${var.requests_rate_status_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.requests_rate_status_disabled_major, var.requests_rate_status_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.requests_rate_status_notifications, "major", []), var.notifications.major)
    runbook_url           = try(coalesce(var.requests_rate_status_runbook_url, var.runbook_url), "")
    tip                   = var.requests_rate_status_tip
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "latency_e2e" {
  name = format("%s %s", local.detector_name_prefix, "Azure Storage Account latency e2e")

  authorized_writer_teams = var.authorized_writer_teams

  program_text = <<-EOF
    base_filtering = filter('resource_type', 'Microsoft.Storage/storageAccounts') and filter('primary_aggregation_type', 'true')
    signal = data('SuccessE2ELatency', filter=base_filtering and ${module.filter-tags.filter_custom}, rollup='rate')${var.latency_e2e_aggregation_function}${var.latency_e2e_transformation_function}.publish('signal')
    detect(when(signal > ${var.latency_e2e_threshold_critical})).publish('CRIT')
    detect(when(signal > ${var.latency_e2e_threshold_major}) and when(signal <= ${var.latency_e2e_threshold_critical})).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.latency_e2e_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.latency_e2e_disabled_critical, var.latency_e2e_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.latency_e2e_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.latency_e2e_runbook_url, var.runbook_url), "")
    tip                   = var.latency_e2e_tip
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "is too high > ${var.latency_e2e_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.latency_e2e_disabled_major, var.latency_e2e_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.latency_e2e_notifications, "major", []), var.notifications.major)
    runbook_url           = try(coalesce(var.latency_e2e_runbook_url, var.runbook_url), "")
    tip                   = var.latency_e2e_tip
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

