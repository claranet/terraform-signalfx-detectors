resource "signalfx_detector" "requests_error_rate" {
  name = format("%s %s", local.detector_name_prefix, "Azure Storage Account on Blob requests error rate")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  viz_options {
    label        = "signal"
    value_suffix = "%"
  }

  program_text = <<-EOF
    rate_success = data('Transactions', filter=filter('resource_type', 'Microsoft.Storage/storageAccounts') and filter('primary_aggregation_type', 'true') and filter('apiname', '*Blob') and filter('responsetype', 'Success') and ${module.filtering.signalflow}, rollup='rate')${var.requests_error_rate_aggregation_function}${var.requests_error_rate_transformation_function}
    rate_failed = data('Transactions', filter=filter('resource_type', 'Microsoft.Storage/storageAccounts') and filter('primary_aggregation_type', 'true') and filter('apiname', '*Blob') and filter('responsetype', 'ClientOtherError') and ${module.filtering.signalflow}, rollup='rate')${var.requests_error_rate_aggregation_function}${var.requests_error_rate_transformation_function}
    signal = (rate_failed/(rate_success+rate_failed)).scale(100).fill(0).publish('signal')
    detect(when(signal > ${var.requests_error_rate_threshold_critical}, lasting=%{if var.requests_error_rate_lasting_duration_critical == null}None%{else}'${var.requests_error_rate_lasting_duration_critical}'%{endif}, at_least=${var.requests_error_rate_at_least_percentage_critical})).publish('CRIT')
    detect(when(signal > ${var.requests_error_rate_threshold_major}, lasting=%{if var.requests_error_rate_lasting_duration_major == null}None%{else}'${var.requests_error_rate_lasting_duration_major}'%{endif}, at_least=${var.requests_error_rate_at_least_percentage_major}) and (not when(signal > ${var.requests_error_rate_threshold_critical}, lasting=%{if var.requests_error_rate_lasting_duration_critical == null}None%{else}'${var.requests_error_rate_lasting_duration_critical}'%{endif}, at_least=${var.requests_error_rate_at_least_percentage_critical}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.requests_error_rate_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.requests_error_rate_disabled_critical, var.requests_error_rate_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.requests_error_rate_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.requests_error_rate_runbook_url, var.runbook_url), "")
    tip                   = var.requests_error_rate_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.requests_error_rate_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.requests_error_rate_disabled_major, var.requests_error_rate_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.requests_error_rate_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.requests_error_rate_runbook_url, var.runbook_url), "")
    tip                   = var.requests_error_rate_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.requests_error_rate_max_delay
}

resource "signalfx_detector" "latency_e2e" {
  name = format("%s %s", local.detector_name_prefix, "Azure Storage Account on Blob latency e2e")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  viz_options {
    label      = "signal"
    value_unit = "Second"
  }

  program_text = <<-EOF
    latency = data('SuccessE2ELatency', filter=filter('resource_type', 'Microsoft.Storage/storageAccounts') and filter('primary_aggregation_type', 'true') and filter('apiname', '*Blob') and ${module.filtering.signalflow}, rollup='average')${var.latency_e2e_aggregation_function}${var.latency_e2e_transformation_function}
    signal = latency.scale(0.001).publish('signal')
    detect(when(signal > ${var.latency_e2e_threshold_critical}, lasting=%{if var.latency_e2e_lasting_duration_critical == null}None%{else}'${var.latency_e2e_lasting_duration_critical}'%{endif}, at_least=${var.latency_e2e_at_least_percentage_critical})).publish('CRIT')
    detect(when(signal > ${var.latency_e2e_threshold_major}, lasting=%{if var.latency_e2e_lasting_duration_major == null}None%{else}'${var.latency_e2e_lasting_duration_major}'%{endif}, at_least=${var.latency_e2e_at_least_percentage_major}) and (not when(signal > ${var.latency_e2e_threshold_critical}, lasting=%{if var.latency_e2e_lasting_duration_critical == null}None%{else}'${var.latency_e2e_lasting_duration_critical}'%{endif}, at_least=${var.latency_e2e_at_least_percentage_critical}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.latency_e2e_threshold_critical}Second"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.latency_e2e_disabled_critical, var.latency_e2e_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.latency_e2e_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.latency_e2e_runbook_url, var.runbook_url), "")
    tip                   = var.latency_e2e_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.latency_e2e_threshold_major}Second"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.latency_e2e_disabled_major, var.latency_e2e_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.latency_e2e_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.latency_e2e_runbook_url, var.runbook_url), "")
    tip                   = var.latency_e2e_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.latency_e2e_max_delay
}

