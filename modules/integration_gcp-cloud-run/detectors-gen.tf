resource "signalfx_detector" "cpu_utilizations" {
  name = format("%s %s", local.detector_name_prefix, "GCP Cloud Run cpu utilizations")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  viz_options {
    label        = "signal"
    value_suffix = "%"
  }

  program_text = <<-EOF
    A = data('container/cpu/utilizations', filter=${module.filtering.signalflow}, extrapolation='zero')${var.cpu_utilizations_aggregation_function}${var.cpu_utilizations_transformation_function}
    signal = A.scale(100).publish('signal')
    detect(when(signal > ${var.cpu_utilizations_threshold_critical}%{if var.cpu_utilizations_lasting_duration_critical != null}, lasting='${var.cpu_utilizations_lasting_duration_critical}', at_least=${var.cpu_utilizations_at_least_percentage_critical}%{endif})).publish('CRIT')
    detect(when(signal > ${var.cpu_utilizations_threshold_major}%{if var.cpu_utilizations_lasting_duration_major != null}, lasting='${var.cpu_utilizations_lasting_duration_major}', at_least=${var.cpu_utilizations_at_least_percentage_major}%{endif}) and (not when(signal > ${var.cpu_utilizations_threshold_critical}%{if var.cpu_utilizations_lasting_duration_critical != null}, lasting='${var.cpu_utilizations_lasting_duration_critical}', at_least=${var.cpu_utilizations_at_least_percentage_critical}%{endif}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.cpu_utilizations_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.cpu_utilizations_disabled_critical, var.cpu_utilizations_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.cpu_utilizations_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.cpu_utilizations_runbook_url, var.runbook_url), "")
    tip                   = var.cpu_utilizations_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.cpu_utilizations_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.cpu_utilizations_disabled_major, var.cpu_utilizations_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.cpu_utilizations_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.cpu_utilizations_runbook_url, var.runbook_url), "")
    tip                   = var.cpu_utilizations_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.cpu_utilizations_max_delay
}

resource "signalfx_detector" "memory_utilizations" {
  name = format("%s %s", local.detector_name_prefix, "GCP Cloud Run memory utilizations")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  viz_options {
    label        = "signal"
    value_suffix = "%"
  }

  program_text = <<-EOF
    A = data('container/cpu/utilizations', filter=${module.filtering.signalflow}, extrapolation='zero')${var.memory_utilizations_aggregation_function}${var.memory_utilizations_transformation_function}
    signal = A.scale(100).publish('signal')
    detect(when(signal > ${var.memory_utilizations_threshold_critical}%{if var.memory_utilizations_lasting_duration_critical != null}, lasting='${var.memory_utilizations_lasting_duration_critical}', at_least=${var.memory_utilizations_at_least_percentage_critical}%{endif})).publish('CRIT')
    detect(when(signal > ${var.memory_utilizations_threshold_major}%{if var.memory_utilizations_lasting_duration_major != null}, lasting='${var.memory_utilizations_lasting_duration_major}', at_least=${var.memory_utilizations_at_least_percentage_major}%{endif}) and (not when(signal > ${var.memory_utilizations_threshold_critical}%{if var.memory_utilizations_lasting_duration_critical != null}, lasting='${var.memory_utilizations_lasting_duration_critical}', at_least=${var.memory_utilizations_at_least_percentage_critical}%{endif}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.memory_utilizations_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.memory_utilizations_disabled_critical, var.memory_utilizations_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.memory_utilizations_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.memory_utilizations_runbook_url, var.runbook_url), "")
    tip                   = var.memory_utilizations_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.memory_utilizations_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.memory_utilizations_disabled_major, var.memory_utilizations_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.memory_utilizations_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.memory_utilizations_runbook_url, var.runbook_url), "")
    tip                   = var.memory_utilizations_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.memory_utilizations_max_delay
}

resource "signalfx_detector" "cloudsql_connections_refused_to_requests_ratio" {
  name = format("%s %s", local.detector_name_prefix, "GCP Cloud Run cloudsql connections refused to requests ratio")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  viz_options {
    label        = "signal"
    value_suffix = "%"
  }

  program_text = <<-EOF
    A = data('infrastructure/cloudsql/connection_refused_count', filter=filter('response_code_class', '5xx') and ${module.filtering.signalflow})${var.cloudsql_connections_refused_to_requests_ratio_aggregation_function}${var.cloudsql_connections_refused_to_requests_ratio_transformation_function}
    B = data('infrastructure/cloudsql/connection_request_count', filter=${module.filtering.signalflow})${var.cloudsql_connections_refused_to_requests_ratio_aggregation_function}${var.cloudsql_connections_refused_to_requests_ratio_transformation_function}
    signal = (A/B).scale(100).publish('signal')
    detect(when(signal > ${var.cloudsql_connections_refused_to_requests_ratio_threshold_critical}%{if var.cloudsql_connections_refused_to_requests_ratio_lasting_duration_critical != null}, lasting='${var.cloudsql_connections_refused_to_requests_ratio_lasting_duration_critical}', at_least=${var.cloudsql_connections_refused_to_requests_ratio_at_least_percentage_critical}%{endif})).publish('CRIT')
    detect(when(signal > ${var.cloudsql_connections_refused_to_requests_ratio_threshold_major}%{if var.cloudsql_connections_refused_to_requests_ratio_lasting_duration_major != null}, lasting='${var.cloudsql_connections_refused_to_requests_ratio_lasting_duration_major}', at_least=${var.cloudsql_connections_refused_to_requests_ratio_at_least_percentage_major}%{endif}) and (not when(signal > ${var.cloudsql_connections_refused_to_requests_ratio_threshold_critical}%{if var.cloudsql_connections_refused_to_requests_ratio_lasting_duration_critical != null}, lasting='${var.cloudsql_connections_refused_to_requests_ratio_lasting_duration_critical}', at_least=${var.cloudsql_connections_refused_to_requests_ratio_at_least_percentage_critical}%{endif}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.cloudsql_connections_refused_to_requests_ratio_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.cloudsql_connections_refused_to_requests_ratio_disabled_critical, var.cloudsql_connections_refused_to_requests_ratio_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.cloudsql_connections_refused_to_requests_ratio_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.cloudsql_connections_refused_to_requests_ratio_runbook_url, var.runbook_url), "")
    tip                   = var.cloudsql_connections_refused_to_requests_ratio_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.cloudsql_connections_refused_to_requests_ratio_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.cloudsql_connections_refused_to_requests_ratio_disabled_major, var.cloudsql_connections_refused_to_requests_ratio_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.cloudsql_connections_refused_to_requests_ratio_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.cloudsql_connections_refused_to_requests_ratio_runbook_url, var.runbook_url), "")
    tip                   = var.cloudsql_connections_refused_to_requests_ratio_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.cloudsql_connections_refused_to_requests_ratio_max_delay
}

