resource "signalfx_detector" "capacity" {
  name = format("%s %s", local.detector_name_prefix, "Azure Storage Account File share capacity")

  authorized_writer_teams = var.authorized_writer_teams

  viz_options {
    label        = "signal"
    value_suffix = "%"
  }

  program_text = <<-EOF
    base_filtering = filter('resource_type', 'Microsoft.Storage/storageAccounts/fileServices') and filter('primary_aggregation_type', 'true')
    capacity = data('FileCapacity', filter=base_filtering and ${module.filter-tags.filter_custom})${var.capacity_aggregation_function}${var.capacity_transformation_function}
    limit = data('FileShareCapacityQuota', filter=base_filtering and ${module.filter-tags.filter_custom})${var.capacity_aggregation_function}${var.capacity_transformation_function}
    signal = (capacity / limit).scale(100).publish('signal')
    detect(when(signal > ${var.capacity_threshold_critical})).publish('CRIT')
    detect(when(signal > ${var.capacity_threshold_major}) and when(signal <= ${var.capacity_threshold_critical})).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.capacity_threshold_critical}%"
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
    description           = "is too high > ${var.capacity_threshold_major}%"
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

resource "signalfx_detector" "iops" {
  name = format("%s %s", local.detector_name_prefix, "Azure Storage Account File share iops")

  authorized_writer_teams = var.authorized_writer_teams

  viz_options {
    label        = "signal"
    value_suffix = "%"
  }

  program_text = <<-EOF
    base_filtering = filter('resource_type', 'Microsoft.Storage/storageAccounts/fileServices') and filter('primary_aggregation_type', 'true')
    transactions = data('Transactions', filter=base_filtering and ${module.filter-tags.filter_custom}, rollup='rate')${var.iops_aggregation_function}${var.iops_transformation_function}
    limit = data('FileShareProvisionedIOPS', filter=base_filtering and ${module.filter-tags.filter_custom}, extrapolation='last_value')${var.iops_aggregation_function}${var.iops_transformation_function}
    signal = (transactions / limit).scale(100).publish('signal')
    detect(when(signal > ${var.iops_threshold_critical})).publish('CRIT')
    detect(when(signal > ${var.iops_threshold_major}) and when(signal <= ${var.iops_threshold_critical})).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.iops_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.iops_disabled_critical, var.iops_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.iops_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.iops_runbook_url, var.runbook_url), "")
    tip                   = var.iops_tip
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "is too high > ${var.iops_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.iops_disabled_major, var.iops_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.iops_notifications, "major", []), var.notifications.major)
    runbook_url           = try(coalesce(var.iops_runbook_url, var.runbook_url), "")
    tip                   = var.iops_tip
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "egress" {
  name = format("%s %s", local.detector_name_prefix, "Azure Storage Account File share egress")

  authorized_writer_teams = var.authorized_writer_teams

  viz_options {
    label        = "signal"
    value_suffix = "%"
  }

  program_text = <<-EOF
    base_filtering = filter('resource_type', 'Microsoft.Storage/storageAccounts/fileServices') and filter('primary_aggregation_type', 'true')
    ingress = data('Egress', filter=base_filtering and ${module.filter-tags.filter_custom}, rollup='rate')${var.egress_aggregation_function}${var.egress_transformation_function}
    size_quota = data('FileShareCapacityQuota', filter=base_filtering and ${module.filter-tags.filter_custom}, extrapolation='last_value')${var.egress_aggregation_function}${var.egress_transformation_function}
    signal = (ingress.scale(0.00000095367431640625) / (60 + 0.06 * size_quota.scale(0.0000000009313225746154785)) ).publish('signal')
    detect(when(signal > ${var.egress_threshold_critical})).publish('CRIT')
    detect(when(signal > ${var.egress_threshold_major}) and when(signal <= ${var.egress_threshold_critical})).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.egress_threshold_critical}%"
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
    description           = "is too high > ${var.egress_threshold_major}%"
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

resource "signalfx_detector" "ingress" {
  name = format("%s %s", local.detector_name_prefix, "Azure Storage Account File share ingress")

  authorized_writer_teams = var.authorized_writer_teams

  viz_options {
    label        = "signal"
    value_suffix = "%"
  }

  program_text = <<-EOF
    base_filtering = filter('resource_type', 'Microsoft.Storage/storageAccounts/fileServices') and filter('primary_aggregation_type', 'true')
    ingress = data('Ingress', filter=base_filtering and ${module.filter-tags.filter_custom}, rollup='rate')${var.ingress_aggregation_function}${var.ingress_transformation_function}
    size_quota = data('FileShareCapacityQuota', filter=base_filtering and ${module.filter-tags.filter_custom}, extrapolation='last_value')${var.ingress_aggregation_function}${var.ingress_transformation_function}
    signal = (ingress.scale(0.00000095367431640625) / (40 + 0.04 * size_quota.scale(0.0000000009313225746154785)) ).publish('signal')
    detect(when(signal > ${var.ingress_threshold_critical})).publish('CRIT')
    detect(when(signal > ${var.ingress_threshold_major}) and when(signal <= ${var.ingress_threshold_critical})).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.ingress_threshold_critical}%"
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
    description           = "is too high > ${var.ingress_threshold_major}%"
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

resource "signalfx_detector" "throttling" {
  name = format("%s %s", local.detector_name_prefix, "Azure Storage Account File share throttling")

  authorized_writer_teams = var.authorized_writer_teams

  viz_options {
    label        = "signal"
    value_suffix = "%"
  }

  program_text = <<-EOF
    base_filtering = filter('resource_type', 'Microsoft.Storage/storageAccounts/fileServices') and filter('primary_aggregation_type', 'true')
    throttling = data('Transactions', filter=base_filtering and filter('ResponseType', 'SuccessWithThrottling', 'ClientThrottlingError') and ${module.filter-tags.filter_custom}, extrapolation='zero')${var.throttling_aggregation_function}${var.throttling_transformation_function}
    transactions = data('Transactions', filter=base_filtering and ${module.filter-tags.filter_custom})${var.throttling_aggregation_function}${var.throttling_transformation_function}
    signal = (throttling / transactions).fill(0).scale(100).publish('signal')
    detect(when(signal > ${var.throttling_threshold_critical})).publish('CRIT')
    detect(when(signal > ${var.throttling_threshold_major}) and when(signal <= ${var.throttling_threshold_critical})).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.throttling_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.throttling_disabled_critical, var.throttling_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.throttling_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.throttling_runbook_url, var.runbook_url), "")
    tip                   = var.throttling_tip
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "is too high > ${var.throttling_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.throttling_disabled_major, var.throttling_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.throttling_notifications, "major", []), var.notifications.major)
    runbook_url           = try(coalesce(var.throttling_runbook_url, var.runbook_url), "")
    tip                   = var.throttling_tip
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "no_snapshots" {
  name = format("%s %s", local.detector_name_prefix, "Azure Storage Account File share no snapshots")

  authorized_writer_teams = var.authorized_writer_teams

  program_text = <<-EOF
    base_filtering = filter('resource_type', 'Microsoft.Storage/storageAccounts/fileServices') and filter('primary_aggregation_type', 'true')
    signal = data('FileShareSnapshotCount', filter=base_filtering and ${module.filter-tags.filter_custom})${var.no_snapshots_aggregation_function}${var.no_snapshots_transformation_function}.publish('signal')
    detect(when(signal < ${var.no_snapshots_threshold_major})).publish('MAJOR')
EOF

  rule {
    description           = "is too low < ${var.no_snapshots_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.no_snapshots_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.no_snapshots_notifications, "major", []), var.notifications.major)
    runbook_url           = try(coalesce(var.no_snapshots_runbook_url, var.runbook_url), "")
    tip                   = var.no_snapshots_tip
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "snapshots_limit" {
  name = format("%s %s", local.detector_name_prefix, "Azure Storage Account File share snapshots limit")

  authorized_writer_teams = var.authorized_writer_teams

  program_text = <<-EOF
    base_filtering = filter('resource_type', 'Microsoft.Storage/storageAccounts/fileServices') and filter('primary_aggregation_type', 'true')
    signal = data('FileShareSnapshotCount', filter=base_filtering and ${module.filter-tags.filter_custom})${var.snapshots_limit_aggregation_function}${var.snapshots_limit_transformation_function}.publish('signal')
    detect(when(signal > ${var.snapshots_limit_threshold_major})).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.snapshots_limit_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.snapshots_limit_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.snapshots_limit_notifications, "major", []), var.notifications.major)
    runbook_url           = try(coalesce(var.snapshots_limit_runbook_url, var.runbook_url), "")
    tip                   = var.snapshots_limit_tip
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

