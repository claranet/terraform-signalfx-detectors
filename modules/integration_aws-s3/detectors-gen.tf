resource "signalfx_detector" "s3_5xxerrors" {
  name = format("%s %s", local.detector_name_prefix, "AWS S3 s3 errors and requests")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  viz_options {
    label        = "signal"
    value_suffix = "%"
  }

  program_text = <<-EOF
    base_filtering = filter('namespace', 'AWS/S3')
    errors = data('5xxErrors', filter=base_filtering and ${module.filtering.signalflow}, rollup='sum', extrapolation='zero')${var.s3_5xxerrors_aggregation_function}${var.s3_5xxerrors_transformation_function}
    requests = data('AllRequests', filter=base_filtering and ${module.filtering.signalflow}, rollup='sum', extrapolation='zero')${var.s3_5xxerrors_aggregation_function}${var.s3_5xxerrors_transformation_function}
    signal = (errors/requests).scale(100).fill(value=0).publish('signal')
    detect(when(signal > ${var.s3_5xxerrors_threshold_critical}%{if var.s3_5xxerrors_lasting_duration_critical != null}, lasting='${var.s3_5xxerrors_lasting_duration_critical}', at_least=${var.s3_5xxerrors_at_least_percentage_critical}%{endif}) and when(requests > ${var.minimum_traffic})).publish('CRIT')
    detect(when(signal > ${var.s3_5xxerrors_threshold_major}%{if var.s3_5xxerrors_lasting_duration_major != null}, lasting='${var.s3_5xxerrors_lasting_duration_major}', at_least=${var.s3_5xxerrors_at_least_percentage_major}%{endif}) and when(requests > ${var.minimum_traffic}) and (not when(signal > ${var.s3_5xxerrors_threshold_critical}%{if var.s3_5xxerrors_lasting_duration_critical != null}, lasting='${var.s3_5xxerrors_lasting_duration_critical}', at_least=${var.s3_5xxerrors_at_least_percentage_critical}%{endif}) and when(requests > ${var.minimum_traffic}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.s3_5xxerrors_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.s3_5xxerrors_disabled_critical, var.s3_5xxerrors_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.s3_5xxerrors_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.s3_5xxerrors_runbook_url, var.runbook_url), "")
    tip                   = var.s3_5xxerrors_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.s3_5xxerrors_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.s3_5xxerrors_disabled_major, var.s3_5xxerrors_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.s3_5xxerrors_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.s3_5xxerrors_runbook_url, var.runbook_url), "")
    tip                   = var.s3_5xxerrors_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.s3_5xxerrors_max_delay
}

