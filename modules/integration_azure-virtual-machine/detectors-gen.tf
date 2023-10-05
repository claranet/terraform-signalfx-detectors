resource "signalfx_detector" "heartbeat" {
  name = format("%s %s", local.detector_name_prefix, "Azure Virtual Machine heartbeat")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    from signalfx.detectors.not_reporting import not_reporting
    base_filtering = filter('resource_type', 'Microsoft.Compute/virtualMachines') and filter('primary_aggregation_type', 'true') and (not filter('azure_power_state', 'PowerState/stopping', 'PowerState/stopped', 'PowerState/deallocating', 'PowerState/deallocated'))
    signal = data('Percentage CPU', filter=base_filtering and ${module.filtering.signalflow})${var.heartbeat_aggregation_function}${var.heartbeat_transformation_function}.publish('signal')
    not_reporting.detector(stream=signal, resource_identifier=None, duration='${var.heartbeat_timeframe}', auto_resolve_after='${local.heartbeat_auto_resolve_after}').publish('CRIT')
EOF

  rule {
    description           = "has not reported in ${var.heartbeat_timeframe}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.heartbeat_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.heartbeat_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.heartbeat_runbook_url, var.runbook_url), "")
    tip                   = var.heartbeat_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject_novalue : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.heartbeat_max_delay
}

resource "signalfx_detector" "cpu" {
  name = format("%s %s", local.detector_name_prefix, "Azure Virtual Machine cpu")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  viz_options {
    label        = "signal"
    value_suffix = "%"
  }

  program_text = <<-EOF
    base_filtering = filter('resource_type', 'Microsoft.Compute/virtualMachines') and filter('primary_aggregation_type', 'true') and (not filter('azure_power_state', 'PowerState/stopping', 'PowerState/stopped', 'PowerState/deallocating', 'PowerState/deallocated'))
    signal = data('Percentage CPU', filter=base_filtering and ${module.filtering.signalflow})${var.cpu_aggregation_function}${var.cpu_transformation_function}.publish('signal')
    detect(when(signal > ${var.cpu_threshold_critical}, lasting=%{if var.cpu_lasting_duration_critical == null}None%{else}'${var.cpu_lasting_duration_critical}'%{endif}, at_least=${var.cpu_at_least_percentage_critical})).publish('CRIT')
    detect(when(signal > ${var.cpu_threshold_major}, lasting=%{if var.cpu_lasting_duration_major == null}None%{else}'${var.cpu_lasting_duration_major}'%{endif}, at_least=${var.cpu_at_least_percentage_major}) and (not when(signal > ${var.cpu_threshold_critical}, lasting=%{if var.cpu_lasting_duration_critical == null}None%{else}'${var.cpu_lasting_duration_critical}'%{endif}, at_least=${var.cpu_at_least_percentage_critical}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.cpu_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.cpu_disabled_critical, var.cpu_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.cpu_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.cpu_runbook_url, var.runbook_url), "")
    tip                   = var.cpu_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.cpu_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.cpu_disabled_major, var.cpu_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.cpu_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.cpu_runbook_url, var.runbook_url), "")
    tip                   = var.cpu_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.cpu_max_delay
}

resource "signalfx_detector" "remaining_cpu_credit" {
  name = format("%s %s", local.detector_name_prefix, "Azure Virtual Machine remaining cpu credit")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  viz_options {
    label        = "signal"
    value_suffix = "%"
  }

  program_text = <<-EOF
    base_filtering = filter('resource_type', 'Microsoft.Compute/virtualMachines') and filter('primary_aggregation_type', 'true') and (not filter('azure_power_state', 'PowerState/stopping', 'PowerState/stopped', 'PowerState/deallocating', 'PowerState/deallocated'))
    remaining = data('CPU Credits Remaining', filter=base_filtering and ${module.filtering.signalflow})${var.remaining_cpu_credit_aggregation_function}${var.remaining_cpu_credit_transformation_function}
    consumed = data('CPU Credits Consumed', filter=base_filtering and ${module.filtering.signalflow})${var.remaining_cpu_credit_aggregation_function}${var.remaining_cpu_credit_transformation_function}
    signal = (remaining/(remaining+consumed)).scale(100).fill(100).publish('signal')
    detect(when(signal < ${var.remaining_cpu_credit_threshold_critical}, lasting=%{if var.remaining_cpu_credit_lasting_duration_critical == null}None%{else}'${var.remaining_cpu_credit_lasting_duration_critical}'%{endif}, at_least=${var.remaining_cpu_credit_at_least_percentage_critical})).publish('CRIT')
    detect(when(signal < ${var.remaining_cpu_credit_threshold_major}, lasting=%{if var.remaining_cpu_credit_lasting_duration_major == null}None%{else}'${var.remaining_cpu_credit_lasting_duration_major}'%{endif}, at_least=${var.remaining_cpu_credit_at_least_percentage_major}) and (not when(signal < ${var.remaining_cpu_credit_threshold_critical}, lasting=%{if var.remaining_cpu_credit_lasting_duration_critical == null}None%{else}'${var.remaining_cpu_credit_lasting_duration_critical}'%{endif}, at_least=${var.remaining_cpu_credit_at_least_percentage_critical}))).publish('MAJOR')
EOF

  rule {
    description           = "is too low < ${var.remaining_cpu_credit_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.remaining_cpu_credit_disabled_critical, var.remaining_cpu_credit_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.remaining_cpu_credit_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.remaining_cpu_credit_runbook_url, var.runbook_url), "")
    tip                   = var.remaining_cpu_credit_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too low < ${var.remaining_cpu_credit_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.remaining_cpu_credit_disabled_major, var.remaining_cpu_credit_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.remaining_cpu_credit_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.remaining_cpu_credit_runbook_url, var.runbook_url), "")
    tip                   = var.remaining_cpu_credit_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.remaining_cpu_credit_max_delay
}

