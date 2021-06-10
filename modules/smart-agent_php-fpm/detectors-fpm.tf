resource "signalfx_detector" "heartbeat" {
  name = format("%s %s", local.detector_name_prefix, "PHP-FPM heartbeat")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)

  max_delay = 900

  program_text = <<-EOF
    from signalfx.detectors.not_reporting import not_reporting
    signal = data('phpfpm_requests.accepted', filter=${local.not_running_vm_filters} and ${module.filtering.signalflow})${var.heartbeat_aggregation_function}.publish('signal')
    not_reporting.detector(stream=signal, resource_identifier=None, duration='${var.heartbeat_timeframe}').publish('CRIT')
EOF

  rule {
    description           = "has not reported in ${var.heartbeat_timeframe}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.heartbeat_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.heartbeat_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.heartbeat_runbook_url, var.runbook_url), "")
    tip                   = var.heartbeat_tip
    parameterized_subject = local.rule_subject_novalue
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "php_fpm_connect_idle" {
  name = format("%s %s", local.detector_name_prefix, "PHP-FPM busy workers")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)

  program_text = <<-EOF
    A = data('phpfpm_processes.active', filter=${module.filtering.signalflow})${var.php_fpm_connect_idle_aggregation_function}${var.php_fpm_connect_idle_transformation_function}
    B = data('phpfpm_processes.idle', filter=${module.filtering.signalflow})${var.php_fpm_connect_idle_aggregation_function}${var.php_fpm_connect_idle_transformation_function}
    signal = ((A / (A+B)).scale(100)).publish('signal')
    detect(when(signal > ${var.php_fpm_connect_idle_threshold_critical})).publish('CRIT')
    detect(when(signal > ${var.php_fpm_connect_idle_threshold_major}) and when(signal <= ${var.php_fpm_connect_idle_threshold_critical})).publish('MAJOR')
EOF

  rule {
    description           = "are too high > ${var.php_fpm_connect_idle_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.php_fpm_connect_idle_disabled_critical, var.php_fpm_connect_idle_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.php_fpm_connect_idle_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.php_fpm_connect_idle_runbook_url, var.runbook_url), "")
    tip                   = var.php_fpm_connect_idle_tip
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "are too high > ${var.php_fpm_connect_idle_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.php_fpm_connect_idle_disabled_major, var.php_fpm_connect_idle_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.php_fpm_connect_idle_notifications, "major", []), var.notifications.major)
    runbook_url           = try(coalesce(var.php_fpm_connect_idle_runbook_url, var.runbook_url), "")
    tip                   = var.php_fpm_connect_idle_tip
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

