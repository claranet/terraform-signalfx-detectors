resource "signalfx_detector" "capacity" {
  name = format("%s %s", local.detector_name_prefix, "Azure Storage Account File share capacity")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  viz_options {
    label        = "signal"
    value_suffix = "%"
  }

  program_text = <<-EOF
    base_filtering = filter('resource_type', 'Microsoft.Storage/storageAccounts/fileServices') and filter('primary_aggregation_type', 'true') and filter('azure_sa_sku', ' Premium_*')
    capacity = data('FileCapacity', filter=base_filtering and ${module.filtering.signalflow})${var.capacity_aggregation_function}${var.capacity_transformation_function}
    limit = data('FileShareCapacityQuota', filter=base_filtering and ${module.filtering.signalflow})${var.capacity_aggregation_function}${var.capacity_transformation_function}
    signal = (capacity / limit).scale(100).publish('signal')
    detect(when(signal > ${var.capacity_threshold_critical}, lasting=%{if var.capacity_lasting_duration_critical == null}None%{else}'${var.capacity_lasting_duration_critical}'%{endif}, at_least=${var.capacity_at_least_percentage_critical})).publish('CRIT')
    detect(when(signal > ${var.capacity_threshold_major}, lasting=%{if var.capacity_lasting_duration_major == null}None%{else}'${var.capacity_lasting_duration_major}'%{endif}, at_least=${var.capacity_at_least_percentage_major}) and (not when(signal > ${var.capacity_threshold_critical}, lasting=%{if var.capacity_lasting_duration_critical == null}None%{else}'${var.capacity_lasting_duration_critical}'%{endif}, at_least=${var.capacity_at_least_percentage_critical}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.capacity_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.capacity_disabled_critical, var.capacity_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.capacity_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.capacity_runbook_url, var.runbook_url), "")
    tip                   = var.capacity_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.capacity_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.capacity_disabled_major, var.capacity_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.capacity_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.capacity_runbook_url, var.runbook_url), "")
    tip                   = var.capacity_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.capacity_max_delay
}

resource "signalfx_detector" "iops" {
  name = format("%s %s", local.detector_name_prefix, "Azure Storage Account File share iops")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  viz_options {
    label        = "signal"
    value_suffix = "%"
  }

  program_text = <<-EOF
    base_filtering = filter('resource_type', 'Microsoft.Storage/storageAccounts/fileServices') and filter('primary_aggregation_type', 'true') and filter('azure_sa_sku', ' Premium_*')
    transactions = data('Transactions', filter=base_filtering and ${module.filtering.signalflow}, rollup='rate')${var.iops_aggregation_function}${var.iops_transformation_function}
    limit = data('FileShareProvisionedIOPS', filter=base_filtering, extrapolation='last_value').dimensions(renames={'FileShare':'fileshare'}).sum(by=['FileShare', 'azure_resource_id']).min(over='15m')
    signal = (transactions / limit).scale(100).publish('signal')
    detect(when(signal > ${var.iops_threshold_critical}, lasting=%{if var.iops_lasting_duration_critical == null}None%{else}'${var.iops_lasting_duration_critical}'%{endif}, at_least=${var.iops_at_least_percentage_critical})).publish('CRIT')
    detect(when(signal > ${var.iops_threshold_major}, lasting=%{if var.iops_lasting_duration_major == null}None%{else}'${var.iops_lasting_duration_major}'%{endif}, at_least=${var.iops_at_least_percentage_major}) and (not when(signal > ${var.iops_threshold_critical}, lasting=%{if var.iops_lasting_duration_critical == null}None%{else}'${var.iops_lasting_duration_critical}'%{endif}, at_least=${var.iops_at_least_percentage_critical}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.iops_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.iops_disabled_critical, var.iops_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.iops_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.iops_runbook_url, var.runbook_url), "")
    tip                   = var.iops_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.iops_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.iops_disabled_major, var.iops_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.iops_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.iops_runbook_url, var.runbook_url), "")
    tip                   = var.iops_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.iops_max_delay
}

resource "signalfx_detector" "egress" {
  name = format("%s %s", local.detector_name_prefix, "Azure Storage Account File share egress")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  viz_options {
    label        = "signal"
    value_suffix = "%"
  }

  program_text = <<-EOF
    base_filtering = filter('resource_type', 'Microsoft.Storage/storageAccounts/fileServices') and filter('primary_aggregation_type', 'true') and filter('azure_sa_sku', ' Premium_*')
    ingress = data('Egress', filter=base_filtering and ${module.filtering.signalflow}, rollup='rate')${var.egress_aggregation_function}${var.egress_transformation_function}
    size_quota = data('FileShareCapacityQuota', filter=base_filtering, extrapolation='last_value').dimensions(renames={'FileShare':'fileshare'}).sum(by=['FileShare', 'azure_resource_id']).min(over='15m')
    signal = (ingress.scale(0.00000095367431640625) / (60 + 0.06 * size_quota.scale(0.0000000009313225746154785)) ).publish('signal')
    detect(when(signal > ${var.egress_threshold_critical}, lasting=%{if var.egress_lasting_duration_critical == null}None%{else}'${var.egress_lasting_duration_critical}'%{endif}, at_least=${var.egress_at_least_percentage_critical})).publish('CRIT')
    detect(when(signal > ${var.egress_threshold_major}, lasting=%{if var.egress_lasting_duration_major == null}None%{else}'${var.egress_lasting_duration_major}'%{endif}, at_least=${var.egress_at_least_percentage_major}) and (not when(signal > ${var.egress_threshold_critical}, lasting=%{if var.egress_lasting_duration_critical == null}None%{else}'${var.egress_lasting_duration_critical}'%{endif}, at_least=${var.egress_at_least_percentage_critical}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.egress_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.egress_disabled_critical, var.egress_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.egress_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.egress_runbook_url, var.runbook_url), "")
    tip                   = var.egress_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.egress_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.egress_disabled_major, var.egress_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.egress_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.egress_runbook_url, var.runbook_url), "")
    tip                   = var.egress_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.egress_max_delay
}

resource "signalfx_detector" "ingress" {
  name = format("%s %s", local.detector_name_prefix, "Azure Storage Account File share ingress")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  viz_options {
    label        = "signal"
    value_suffix = "%"
  }

  program_text = <<-EOF
    base_filtering = filter('resource_type', 'Microsoft.Storage/storageAccounts/fileServices') and filter('primary_aggregation_type', 'true') and filter('azure_sa_sku', ' Premium_*')
    ingress = data('Ingress', filter=base_filtering and ${module.filtering.signalflow}, rollup='rate')${var.ingress_aggregation_function}${var.ingress_transformation_function}
    size_quota = data('FileShareCapacityQuota', filter=base_filtering, extrapolation='last_value').dimensions(renames={'FileShare':'fileshare'}).sum(by=['FileShare', 'azure_resource_id']).min(over='15m')
    signal = (ingress.scale(0.00000095367431640625) / (40 + 0.04 * size_quota.scale(0.0000000009313225746154785)) ).publish('signal')
    detect(when(signal > ${var.ingress_threshold_critical}, lasting=%{if var.ingress_lasting_duration_critical == null}None%{else}'${var.ingress_lasting_duration_critical}'%{endif}, at_least=${var.ingress_at_least_percentage_critical})).publish('CRIT')
    detect(when(signal > ${var.ingress_threshold_major}, lasting=%{if var.ingress_lasting_duration_major == null}None%{else}'${var.ingress_lasting_duration_major}'%{endif}, at_least=${var.ingress_at_least_percentage_major}) and (not when(signal > ${var.ingress_threshold_critical}, lasting=%{if var.ingress_lasting_duration_critical == null}None%{else}'${var.ingress_lasting_duration_critical}'%{endif}, at_least=${var.ingress_at_least_percentage_critical}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.ingress_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.ingress_disabled_critical, var.ingress_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.ingress_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.ingress_runbook_url, var.runbook_url), "")
    tip                   = var.ingress_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.ingress_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.ingress_disabled_major, var.ingress_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.ingress_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.ingress_runbook_url, var.runbook_url), "")
    tip                   = var.ingress_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.ingress_max_delay
}

resource "signalfx_detector" "throttling" {
  name = format("%s %s", local.detector_name_prefix, "Azure Storage Account File share throttling")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  viz_options {
    label        = "signal"
    value_suffix = "%"
  }

  program_text = <<-EOF
    base_filtering = filter('resource_type', 'Microsoft.Storage/storageAccounts/fileServices') and filter('primary_aggregation_type', 'true') and filter('azure_sa_sku', ' Premium_*')
    throttling = data('Transactions', filter=base_filtering and filter('ResponseType', 'SuccessWithThrottling', 'ClientThrottlingError') and ${module.filtering.signalflow}, extrapolation='zero')${var.throttling_aggregation_function}${var.throttling_transformation_function}
    transactions = data('Transactions', filter=base_filtering and ${module.filtering.signalflow})${var.throttling_aggregation_function}${var.throttling_transformation_function}
    signal = (throttling / transactions).fill(0).scale(100).publish('signal')
    detect(when(signal > ${var.throttling_threshold_critical}, lasting=%{if var.throttling_lasting_duration_critical == null}None%{else}'${var.throttling_lasting_duration_critical}'%{endif}, at_least=${var.throttling_at_least_percentage_critical})).publish('CRIT')
    detect(when(signal > ${var.throttling_threshold_major}, lasting=%{if var.throttling_lasting_duration_major == null}None%{else}'${var.throttling_lasting_duration_major}'%{endif}, at_least=${var.throttling_at_least_percentage_major}) and (not when(signal > ${var.throttling_threshold_critical}, lasting=%{if var.throttling_lasting_duration_critical == null}None%{else}'${var.throttling_lasting_duration_critical}'%{endif}, at_least=${var.throttling_at_least_percentage_critical}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.throttling_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.throttling_disabled_critical, var.throttling_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.throttling_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.throttling_runbook_url, var.runbook_url), "")
    tip                   = var.throttling_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.throttling_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.throttling_disabled_major, var.throttling_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.throttling_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.throttling_runbook_url, var.runbook_url), "")
    tip                   = var.throttling_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.throttling_max_delay
}

resource "signalfx_detector" "no_snapshots" {
  name = format("%s %s", local.detector_name_prefix, "Azure Storage Account File share no snapshots")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    base_filtering = filter('resource_type', 'Microsoft.Storage/storageAccounts/fileServices') and filter('primary_aggregation_type', 'true') and filter('azure_sa_sku', ' Premium_*')
    signal = data('FileShareSnapshotCount', filter=base_filtering ).fill(None, duration='1d').sum(by=['fileshare', 'azure_resource_id']).max(over='1d').publish('signal')
    detect(when(signal < ${var.no_snapshots_threshold_major}, lasting=%{if var.no_snapshots_lasting_duration_major == null}None%{else}'${var.no_snapshots_lasting_duration_major}'%{endif}, at_least=${var.no_snapshots_at_least_percentage_major})).publish('MAJOR')
EOF

  rule {
    description           = "is too low < ${var.no_snapshots_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.no_snapshots_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.no_snapshots_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.no_snapshots_runbook_url, var.runbook_url), "")
    tip                   = var.no_snapshots_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.no_snapshots_max_delay
}

resource "signalfx_detector" "snapshots_limit" {
  name = format("%s %s", local.detector_name_prefix, "Azure Storage Account File share snapshots limit")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    base_filtering = filter('resource_type', 'Microsoft.Storage/storageAccounts/fileServices') and filter('primary_aggregation_type', 'true') and filter('azure_sa_sku', ' Premium_*')
    signal = data('FileShareSnapshotCount', filter=base_filtering ).fill(None, duration='1d').sum(by=['fileshare', 'azure_resource_id']).max(over='1d').publish('signal')
    detect(when(signal > ${var.snapshots_limit_threshold_major}, lasting=%{if var.snapshots_limit_lasting_duration_major == null}None%{else}'${var.snapshots_limit_lasting_duration_major}'%{endif}, at_least=${var.snapshots_limit_at_least_percentage_major})).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.snapshots_limit_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.snapshots_limit_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.snapshots_limit_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.snapshots_limit_runbook_url, var.runbook_url), "")
    tip                   = var.snapshots_limit_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.snapshots_limit_max_delay
}

