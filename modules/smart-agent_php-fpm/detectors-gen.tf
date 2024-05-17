resource "signalfx_detector" "heartbeat" {
  name = format("%s %s", local.detector_name_prefix, "PHP-FPM heartbeat")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    from signalfx.detectors.not_reporting import not_reporting
    signal = data('phpfpm_requests.accepted', filter=%{ if var.heartbeat_exclude_not_running_vm }${local.not_running_vm_filters} and %{ endif }${module.filtering.signalflow})${var.heartbeat_aggregation_function}${var.heartbeat_transformation_function}.publish('signal')
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

resource "signalfx_detector" "php_fpm_connect_idle" {
  name = format("%s %s", local.detector_name_prefix, "PHP-FPM busy workers")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    A = data('phpfpm_processes.active', filter=${module.filtering.signalflow})${var.php_fpm_connect_idle_aggregation_function}${var.php_fpm_connect_idle_transformation_function}
    B = data('phpfpm_processes.idle', filter=${module.filtering.signalflow})${var.php_fpm_connect_idle_aggregation_function}${var.php_fpm_connect_idle_transformation_function}
    signal = ((A / (A+B)).scale(100)).publish('signal')
    detect(when(signal > ${var.php_fpm_connect_idle_threshold_critical}%{if var.php_fpm_connect_idle_lasting_duration_critical != null}, lasting='${var.php_fpm_connect_idle_lasting_duration_critical}', at_least=${var.php_fpm_connect_idle_at_least_percentage_critical}%{endif})).publish('CRIT')
    detect(when(signal > ${var.php_fpm_connect_idle_threshold_major}%{if var.php_fpm_connect_idle_lasting_duration_major != null}, lasting='${var.php_fpm_connect_idle_lasting_duration_major}', at_least=${var.php_fpm_connect_idle_at_least_percentage_major}%{endif}) and (not when(signal > ${var.php_fpm_connect_idle_threshold_critical}%{if var.php_fpm_connect_idle_lasting_duration_critical != null}, lasting='${var.php_fpm_connect_idle_lasting_duration_critical}', at_least=${var.php_fpm_connect_idle_at_least_percentage_critical}%{endif}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.php_fpm_connect_idle_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.php_fpm_connect_idle_disabled_critical, var.php_fpm_connect_idle_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.php_fpm_connect_idle_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.php_fpm_connect_idle_runbook_url, var.runbook_url), "")
    tip                   = var.php_fpm_connect_idle_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.php_fpm_connect_idle_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.php_fpm_connect_idle_disabled_major, var.php_fpm_connect_idle_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.php_fpm_connect_idle_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.php_fpm_connect_idle_runbook_url, var.runbook_url), "")
    tip                   = var.php_fpm_connect_idle_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.php_fpm_connect_idle_max_delay
}

