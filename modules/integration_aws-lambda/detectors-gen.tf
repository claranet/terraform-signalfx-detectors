resource "signalfx_detector" "pct_errors" {
  name = format("%s %s", local.detector_name_prefix, "AWS Lambda errors percentage")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  viz_options {
    label        = "signal"
    value_suffix = "%"
  }

  program_text = <<-EOF
    errors = data('Errors', filter=filter('namespace', 'AWS/Lambda') and filter('stat', 'sum') and filter('Resource', '*') and ${module.filtering.signalflow}, rollup='sum', extrapolation='last_value')${var.pct_errors_aggregation_function}${var.pct_errors_transformation_function}
    invocations = data('Invocations', filter=filter('namespace', 'AWS/Lambda') and filter('stat', 'sum') and filter('Resource', '*') and ${module.filtering.signalflow}, rollup='sum', extrapolation='last_value')${var.pct_errors_aggregation_function}${var.pct_errors_transformation_function}
    signal = (errors/invocations).scale(100).fill(value=0).publish('signal')
    detect(when(signal > ${var.pct_errors_threshold_critical}, lasting=%{if var.pct_errors_lasting_duration_critical == null}None%{else}'${var.pct_errors_lasting_duration_critical}'%{endif}, at_least=${var.pct_errors_at_least_percentage_critical})).publish('CRIT')
    detect(when(signal > ${var.pct_errors_threshold_major}, lasting=%{if var.pct_errors_lasting_duration_major == null}None%{else}'${var.pct_errors_lasting_duration_major}'%{endif}, at_least=${var.pct_errors_at_least_percentage_major}) and (not when(signal > ${var.pct_errors_threshold_critical}, lasting=%{if var.pct_errors_lasting_duration_critical == null}None%{else}'${var.pct_errors_lasting_duration_critical}'%{endif}, at_least=${var.pct_errors_at_least_percentage_critical}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.pct_errors_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.pct_errors_disabled_critical, var.pct_errors_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.pct_errors_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.pct_errors_runbook_url, var.runbook_url), "")
    tip                   = var.pct_errors_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.pct_errors_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.pct_errors_disabled_major, var.pct_errors_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.pct_errors_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.pct_errors_runbook_url, var.runbook_url), "")
    tip                   = var.pct_errors_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.pct_errors_max_delay
}

resource "signalfx_detector" "throttles" {
  name = format("%s %s", local.detector_name_prefix, "AWS Lambda invocations throttled")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    signal = data('Throttles', filter=filter('namespace', 'AWS/Lambda') and filter('stat', 'sum') and filter('Resource', '*') and ${module.filtering.signalflow}, rollup='sum', extrapolation='last_value')${var.throttles_aggregation_function}${var.throttles_transformation_function}.publish('signal')
    detect(when(signal > ${var.throttles_threshold_critical}, lasting=%{if var.throttles_lasting_duration_critical == null}None%{else}'${var.throttles_lasting_duration_critical}'%{endif}, at_least=${var.throttles_at_least_percentage_critical})).publish('CRIT')
    detect(when(signal > ${var.throttles_threshold_major}, lasting=%{if var.throttles_lasting_duration_major == null}None%{else}'${var.throttles_lasting_duration_major}'%{endif}, at_least=${var.throttles_at_least_percentage_major}) and (not when(signal > ${var.throttles_threshold_critical}, lasting=%{if var.throttles_lasting_duration_critical == null}None%{else}'${var.throttles_lasting_duration_critical}'%{endif}, at_least=${var.throttles_at_least_percentage_critical}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.throttles_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.throttles_disabled_critical, var.throttles_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.throttles_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.throttles_runbook_url, var.runbook_url), "")
    tip                   = var.throttles_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.throttles_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.throttles_disabled_major, var.throttles_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.throttles_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.throttles_runbook_url, var.runbook_url), "")
    tip                   = var.throttles_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.throttles_max_delay
}

resource "signalfx_detector" "invocations" {
  name = format("%s %s", local.detector_name_prefix, "AWS Lambda invocations")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    signal = data('Invocations', filter=filter('namespace', 'AWS/Lambda') and filter('stat', 'sum') and filter('Resource', '*') and ${module.filtering.signalflow}, rollup='sum', extrapolation='zero')${var.invocations_aggregation_function}${var.invocations_transformation_function}.publish('signal')
    detect(when(signal < ${var.invocations_threshold_major}, lasting=%{if var.invocations_lasting_duration_major == null}None%{else}'${var.invocations_lasting_duration_major}'%{endif}, at_least=${var.invocations_at_least_percentage_major})).publish('MAJOR')
EOF

  rule {
    description           = "is too low < ${var.invocations_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.invocations_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.invocations_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.invocations_runbook_url, var.runbook_url), "")
    tip                   = var.invocations_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.invocations_max_delay
}

