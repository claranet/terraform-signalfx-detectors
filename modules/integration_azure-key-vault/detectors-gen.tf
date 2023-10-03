resource "signalfx_detector" "api_result_rate" {
  name = format("%s %s", local.detector_name_prefix, "Azure Key Vault api result rate")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  viz_options {
    label        = "signal"
    value_suffix = "%"
  }

  program_text = <<-EOF
    base_filtering = filter('resource_type', 'Microsoft.KeyVault/vaults') and filter('primary_aggregation_type', 'true')
    api_success = data('ServiceApiResult', filter=base_filtering and filter('statuscode', '200') and ${module.filtering.signalflow}, extrapolation='zero')${var.api_result_rate_aggregation_function}${var.api_result_rate_transformation_function}
    api_all = data('ServiceApiResult', filter=base_filtering and ${module.filtering.signalflow}, extrapolation='zero')${var.api_result_rate_aggregation_function}${var.api_result_rate_transformation_function}
    signal = (api_success/api_all).scale(100).fill(100).publish('signal')
    detect(when(signal < ${var.api_result_rate_threshold_critical}, lasting=%{if var.api_result_rate_lasting_duration_critical == null}None%{else}'${var.api_result_rate_lasting_duration_critical}'%{endif}, at_least=${var.api_result_rate_at_least_percentage_critical})).publish('CRIT')
    detect(when(signal < ${var.api_result_rate_threshold_major}, lasting=%{if var.api_result_rate_lasting_duration_major == null}None%{else}'${var.api_result_rate_lasting_duration_major}'%{endif}, at_least=${var.api_result_rate_at_least_percentage_major}) and (not when(signal < ${var.api_result_rate_threshold_critical}, lasting=%{if var.api_result_rate_lasting_duration_critical == null}None%{else}'${var.api_result_rate_lasting_duration_critical}'%{endif}, at_least=${var.api_result_rate_at_least_percentage_critical}))).publish('MAJOR')
EOF

  rule {
    description           = "is too low < ${var.api_result_rate_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.api_result_rate_disabled_critical, var.api_result_rate_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.api_result_rate_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.api_result_rate_runbook_url, var.runbook_url), "")
    tip                   = var.api_result_rate_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too low < ${var.api_result_rate_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.api_result_rate_disabled_major, var.api_result_rate_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.api_result_rate_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.api_result_rate_runbook_url, var.runbook_url), "")
    tip                   = var.api_result_rate_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.api_result_rate_max_delay
}

resource "signalfx_detector" "api_latency" {
  name = format("%s %s", local.detector_name_prefix, "Azure Key Vault api latency")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  viz_options {
    label        = "signal"
    value_suffix = "ms"
  }

  program_text = <<-EOF
    base_filtering = filter('resource_type', 'Microsoft.KeyVault/vaults') and filter('primary_aggregation_type', 'true')
    signal = data('ServiceApiLatency', filter=base_filtering and not filter('activityname', 'secretlist') and ${module.filtering.signalflow}, extrapolation='zero')${var.api_latency_aggregation_function}${var.api_latency_transformation_function}.publish('signal')
    detect(when(signal > ${var.api_latency_threshold_major}, lasting=%{if var.api_latency_lasting_duration_major == null}None%{else}'${var.api_latency_lasting_duration_major}'%{endif}, at_least=${var.api_latency_at_least_percentage_major})).publish('MAJOR')
    detect(when(signal > ${var.api_latency_threshold_minor}, lasting=%{if var.api_latency_lasting_duration_minor == null}None%{else}'${var.api_latency_lasting_duration_minor}'%{endif}, at_least=${var.api_latency_at_least_percentage_minor}) and (not when(signal > ${var.api_latency_threshold_major}, lasting=%{if var.api_latency_lasting_duration_major == null}None%{else}'${var.api_latency_lasting_duration_major}'%{endif}, at_least=${var.api_latency_at_least_percentage_major}))).publish('MINOR')
EOF

  rule {
    description           = "is too high > ${var.api_latency_threshold_major}ms"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.api_latency_disabled_major, var.api_latency_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.api_latency_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.api_latency_runbook_url, var.runbook_url), "")
    tip                   = var.api_latency_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.api_latency_threshold_minor}ms"
    severity              = "Minor"
    detect_label          = "MINOR"
    disabled              = coalesce(var.api_latency_disabled_minor, var.api_latency_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.api_latency_notifications, "minor", []), var.notifications.minor), null)
    runbook_url           = try(coalesce(var.api_latency_runbook_url, var.runbook_url), "")
    tip                   = var.api_latency_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.api_latency_max_delay
}

