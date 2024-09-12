resource "signalfx_detector" "heartbeat" {
  name = format("%s %s", local.detector_name_prefix, "Postfix heartbeat")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    from signalfx.detectors.not_reporting import not_reporting
    signal = data('postfix_up', filter=%{if var.heartbeat_exclude_not_running_vm}${local.not_running_vm_filters} and %{endif}${module.filtering.signalflow})${var.heartbeat_aggregation_function}.publish('signal')
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

resource "signalfx_detector" "postfix_showq_message_size_bytes_count_deferred" {
  name = format("%s %s", local.detector_name_prefix, "Postfix size postfix queue deferred")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    base_filtering = filter('queue', 'deferred')
    signal = data('postfix_showq_message_size_bytes_count', filter=base_filtering and ${module.filtering.signalflow})${var.postfix_showq_message_size_bytes_count_deferred_aggregation_function}${var.postfix_showq_message_size_bytes_count_deferred_transformation_function}.publish('signal')
    detect(when(signal > ${var.postfix_showq_message_size_bytes_count_deferred_threshold_critical}%{if var.postfix_showq_message_size_bytes_count_deferred_lasting_duration_critical != null}, lasting='${var.postfix_showq_message_size_bytes_count_deferred_lasting_duration_critical}', at_least=${var.postfix_showq_message_size_bytes_count_deferred_at_least_percentage_critical}%{endif})).publish('CRIT')
    detect(when(signal > ${var.postfix_showq_message_size_bytes_count_deferred_threshold_major}%{if var.postfix_showq_message_size_bytes_count_deferred_lasting_duration_major != null}, lasting='${var.postfix_showq_message_size_bytes_count_deferred_lasting_duration_major}', at_least=${var.postfix_showq_message_size_bytes_count_deferred_at_least_percentage_major}%{endif}) and (not when(signal > ${var.postfix_showq_message_size_bytes_count_deferred_threshold_critical}%{if var.postfix_showq_message_size_bytes_count_deferred_lasting_duration_critical != null}, lasting='${var.postfix_showq_message_size_bytes_count_deferred_lasting_duration_critical}', at_least=${var.postfix_showq_message_size_bytes_count_deferred_at_least_percentage_critical}%{endif}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.postfix_showq_message_size_bytes_count_deferred_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.postfix_showq_message_size_bytes_count_deferred_disabled_critical, var.postfix_showq_message_size_bytes_count_deferred_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.postfix_showq_message_size_bytes_count_deferred_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.postfix_showq_message_size_bytes_count_deferred_runbook_url, var.runbook_url), "")
    tip                   = var.postfix_showq_message_size_bytes_count_deferred_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.postfix_showq_message_size_bytes_count_deferred_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.postfix_showq_message_size_bytes_count_deferred_disabled_major, var.postfix_showq_message_size_bytes_count_deferred_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.postfix_showq_message_size_bytes_count_deferred_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.postfix_showq_message_size_bytes_count_deferred_runbook_url, var.runbook_url), "")
    tip                   = var.postfix_showq_message_size_bytes_count_deferred_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.postfix_showq_message_size_bytes_count_deferred_max_delay
}

resource "signalfx_detector" "postfix_showq_message_size_bytes_count_hold" {
  name = format("%s %s", local.detector_name_prefix, "Postfix size postfix queue hold")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    base_filtering = filter('queue', 'hold')
    signal = data('postfix_showq_message_size_bytes_count', filter=base_filtering and ${module.filtering.signalflow})${var.postfix_showq_message_size_bytes_count_hold_aggregation_function}${var.postfix_showq_message_size_bytes_count_hold_transformation_function}.publish('signal')
    detect(when(signal > ${var.postfix_showq_message_size_bytes_count_hold_threshold_critical}%{if var.postfix_showq_message_size_bytes_count_hold_lasting_duration_critical != null}, lasting='${var.postfix_showq_message_size_bytes_count_hold_lasting_duration_critical}', at_least=${var.postfix_showq_message_size_bytes_count_hold_at_least_percentage_critical}%{endif})).publish('CRIT')
    detect(when(signal > ${var.postfix_showq_message_size_bytes_count_hold_threshold_major}%{if var.postfix_showq_message_size_bytes_count_hold_lasting_duration_major != null}, lasting='${var.postfix_showq_message_size_bytes_count_hold_lasting_duration_major}', at_least=${var.postfix_showq_message_size_bytes_count_hold_at_least_percentage_major}%{endif}) and (not when(signal > ${var.postfix_showq_message_size_bytes_count_hold_threshold_critical}%{if var.postfix_showq_message_size_bytes_count_hold_lasting_duration_critical != null}, lasting='${var.postfix_showq_message_size_bytes_count_hold_lasting_duration_critical}', at_least=${var.postfix_showq_message_size_bytes_count_hold_at_least_percentage_critical}%{endif}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.postfix_showq_message_size_bytes_count_hold_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.postfix_showq_message_size_bytes_count_hold_disabled_critical, var.postfix_showq_message_size_bytes_count_hold_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.postfix_showq_message_size_bytes_count_hold_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.postfix_showq_message_size_bytes_count_hold_runbook_url, var.runbook_url), "")
    tip                   = var.postfix_showq_message_size_bytes_count_hold_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.postfix_showq_message_size_bytes_count_hold_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.postfix_showq_message_size_bytes_count_hold_disabled_major, var.postfix_showq_message_size_bytes_count_hold_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.postfix_showq_message_size_bytes_count_hold_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.postfix_showq_message_size_bytes_count_hold_runbook_url, var.runbook_url), "")
    tip                   = var.postfix_showq_message_size_bytes_count_hold_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.postfix_showq_message_size_bytes_count_hold_max_delay
}

resource "signalfx_detector" "postfix_showq_message_size_bytes_count_maildrop" {
  name = format("%s %s", local.detector_name_prefix, "Postfix size postfix queue maildrop")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    base_filtering = filter('queue', 'maildrop')
    signal = data('postfix_showq_message_size_bytes_count', filter=base_filtering and ${module.filtering.signalflow})${var.postfix_showq_message_size_bytes_count_maildrop_aggregation_function}${var.postfix_showq_message_size_bytes_count_maildrop_transformation_function}.publish('signal')
    detect(when(signal > ${var.postfix_showq_message_size_bytes_count_maildrop_threshold_critical}%{if var.postfix_showq_message_size_bytes_count_maildrop_lasting_duration_critical != null}, lasting='${var.postfix_showq_message_size_bytes_count_maildrop_lasting_duration_critical}', at_least=${var.postfix_showq_message_size_bytes_count_maildrop_at_least_percentage_critical}%{endif})).publish('CRIT')
    detect(when(signal > ${var.postfix_showq_message_size_bytes_count_maildrop_threshold_major}%{if var.postfix_showq_message_size_bytes_count_maildrop_lasting_duration_major != null}, lasting='${var.postfix_showq_message_size_bytes_count_maildrop_lasting_duration_major}', at_least=${var.postfix_showq_message_size_bytes_count_maildrop_at_least_percentage_major}%{endif}) and (not when(signal > ${var.postfix_showq_message_size_bytes_count_maildrop_threshold_critical}%{if var.postfix_showq_message_size_bytes_count_maildrop_lasting_duration_critical != null}, lasting='${var.postfix_showq_message_size_bytes_count_maildrop_lasting_duration_critical}', at_least=${var.postfix_showq_message_size_bytes_count_maildrop_at_least_percentage_critical}%{endif}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.postfix_showq_message_size_bytes_count_maildrop_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.postfix_showq_message_size_bytes_count_maildrop_disabled_critical, var.postfix_showq_message_size_bytes_count_maildrop_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.postfix_showq_message_size_bytes_count_maildrop_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.postfix_showq_message_size_bytes_count_maildrop_runbook_url, var.runbook_url), "")
    tip                   = var.postfix_showq_message_size_bytes_count_maildrop_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.postfix_showq_message_size_bytes_count_maildrop_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.postfix_showq_message_size_bytes_count_maildrop_disabled_major, var.postfix_showq_message_size_bytes_count_maildrop_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.postfix_showq_message_size_bytes_count_maildrop_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.postfix_showq_message_size_bytes_count_maildrop_runbook_url, var.runbook_url), "")
    tip                   = var.postfix_showq_message_size_bytes_count_maildrop_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.postfix_showq_message_size_bytes_count_maildrop_max_delay
}

resource "signalfx_detector" "postfix_smtp_delivery_delay_seconds_count" {
  name = format("%s %s", local.detector_name_prefix, "Postfix size postfix delivery delay")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    base_filtering = filter('queue', 'maildrop')
    signal = data('postfix_smtp_delivery_delay_seconds_count', filter=base_filtering and ${module.filtering.signalflow})${var.postfix_smtp_delivery_delay_seconds_count_aggregation_function}${var.postfix_smtp_delivery_delay_seconds_count_transformation_function}.publish('signal')
    detect(when(signal > ${var.postfix_smtp_delivery_delay_seconds_count_threshold_critical}%{if var.postfix_smtp_delivery_delay_seconds_count_lasting_duration_critical != null}, lasting='${var.postfix_smtp_delivery_delay_seconds_count_lasting_duration_critical}', at_least=${var.postfix_smtp_delivery_delay_seconds_count_at_least_percentage_critical}%{endif})).publish('CRIT')
    detect(when(signal > ${var.postfix_smtp_delivery_delay_seconds_count_threshold_major}%{if var.postfix_smtp_delivery_delay_seconds_count_lasting_duration_major != null}, lasting='${var.postfix_smtp_delivery_delay_seconds_count_lasting_duration_major}', at_least=${var.postfix_smtp_delivery_delay_seconds_count_at_least_percentage_major}%{endif}) and (not when(signal > ${var.postfix_smtp_delivery_delay_seconds_count_threshold_critical}%{if var.postfix_smtp_delivery_delay_seconds_count_lasting_duration_critical != null}, lasting='${var.postfix_smtp_delivery_delay_seconds_count_lasting_duration_critical}', at_least=${var.postfix_smtp_delivery_delay_seconds_count_at_least_percentage_critical}%{endif}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.postfix_smtp_delivery_delay_seconds_count_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.postfix_smtp_delivery_delay_seconds_count_disabled_critical, var.postfix_smtp_delivery_delay_seconds_count_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.postfix_smtp_delivery_delay_seconds_count_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.postfix_smtp_delivery_delay_seconds_count_runbook_url, var.runbook_url), "")
    tip                   = var.postfix_smtp_delivery_delay_seconds_count_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.postfix_smtp_delivery_delay_seconds_count_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.postfix_smtp_delivery_delay_seconds_count_disabled_major, var.postfix_smtp_delivery_delay_seconds_count_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.postfix_smtp_delivery_delay_seconds_count_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.postfix_smtp_delivery_delay_seconds_count_runbook_url, var.runbook_url), "")
    tip                   = var.postfix_smtp_delivery_delay_seconds_count_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.postfix_smtp_delivery_delay_seconds_count_max_delay
}

