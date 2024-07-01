resource "signalfx_detector" "cpu_usage" {
  name = format("%s %s", local.detector_name_prefix, "GCP Cloud Run cpu usage")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  viz_options {
    label        = "signal"
    value_suffix = "%"
  }

  program_text = <<-EOF
    A = data('container/cpu/utilizations', filter=${module.filtering.signalflow}, extrapolation='zero')${var.cpu_usage_aggregation_function}${var.cpu_usage_transformation_function}
    signal = A.scale(100).publish('signal')
    detect(when(signal > ${var.cpu_usage_threshold_critical}%{if var.cpu_usage_lasting_duration_critical != null}, lasting='${var.cpu_usage_lasting_duration_critical}', at_least=${var.cpu_usage_at_least_percentage_critical}%{endif})).publish('CRIT')
    detect(when(signal > ${var.cpu_usage_threshold_major}%{if var.cpu_usage_lasting_duration_major != null}, lasting='${var.cpu_usage_lasting_duration_major}', at_least=${var.cpu_usage_at_least_percentage_major}%{endif}) and (not when(signal > ${var.cpu_usage_threshold_critical}%{if var.cpu_usage_lasting_duration_critical != null}, lasting='${var.cpu_usage_lasting_duration_critical}', at_least=${var.cpu_usage_at_least_percentage_critical}%{endif}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.cpu_usage_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.cpu_usage_disabled_critical, var.cpu_usage_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.cpu_usage_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.cpu_usage_runbook_url, var.runbook_url), "")
    tip                   = var.cpu_usage_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.cpu_usage_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.cpu_usage_disabled_major, var.cpu_usage_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.cpu_usage_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.cpu_usage_runbook_url, var.runbook_url), "")
    tip                   = var.cpu_usage_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.cpu_usage_max_delay
}

resource "signalfx_detector" "memory_usage" {
  name = format("%s %s", local.detector_name_prefix, "GCP Cloud Run memory usage")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  viz_options {
    label        = "signal"
    value_suffix = "%"
  }

  program_text = <<-EOF
    A = data('container/cpu/utilizations', filter=${module.filtering.signalflow}, extrapolation='zero')${var.memory_usage_aggregation_function}${var.memory_usage_transformation_function}
    signal = A.scale(100).publish('signal')
    detect(when(signal > ${var.memory_usage_threshold_critical}%{if var.memory_usage_lasting_duration_critical != null}, lasting='${var.memory_usage_lasting_duration_critical}', at_least=${var.memory_usage_at_least_percentage_critical}%{endif})).publish('CRIT')
    detect(when(signal > ${var.memory_usage_threshold_major}%{if var.memory_usage_lasting_duration_major != null}, lasting='${var.memory_usage_lasting_duration_major}', at_least=${var.memory_usage_at_least_percentage_major}%{endif}) and (not when(signal > ${var.memory_usage_threshold_critical}%{if var.memory_usage_lasting_duration_critical != null}, lasting='${var.memory_usage_lasting_duration_critical}', at_least=${var.memory_usage_at_least_percentage_critical}%{endif}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.memory_usage_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.memory_usage_disabled_critical, var.memory_usage_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.memory_usage_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.memory_usage_runbook_url, var.runbook_url), "")
    tip                   = var.memory_usage_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.memory_usage_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.memory_usage_disabled_major, var.memory_usage_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.memory_usage_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.memory_usage_runbook_url, var.runbook_url), "")
    tip                   = var.memory_usage_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.memory_usage_max_delay
}

resource "signalfx_detector" "connection_refused_to_sql_ratio" {
  name = format("%s %s", local.detector_name_prefix, "GCP Cloud Run connection refused to sql ratio")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  viz_options {
    label        = "signal"
    value_suffix = "%"
  }

  program_text = <<-EOF
    A = data('infrastructure/cloudsql/connection_refused_count', filter=${module.filtering.signalflow})${var.connection_refused_to_sql_ratio_aggregation_function}${var.connection_refused_to_sql_ratio_transformation_function}
    B = data('infrastructure/cloudsql/connection_request_count', filter=${module.filtering.signalflow})${var.connection_refused_to_sql_ratio_aggregation_function}${var.connection_refused_to_sql_ratio_transformation_function}
    signal = (A/B).scale(100).publish('signal')
    detect(when(signal > ${var.connection_refused_to_sql_ratio_threshold_critical}%{if var.connection_refused_to_sql_ratio_lasting_duration_critical != null}, lasting='${var.connection_refused_to_sql_ratio_lasting_duration_critical}', at_least=${var.connection_refused_to_sql_ratio_at_least_percentage_critical}%{endif})).publish('CRIT')
    detect(when(signal > ${var.connection_refused_to_sql_ratio_threshold_major}%{if var.connection_refused_to_sql_ratio_lasting_duration_major != null}, lasting='${var.connection_refused_to_sql_ratio_lasting_duration_major}', at_least=${var.connection_refused_to_sql_ratio_at_least_percentage_major}%{endif}) and (not when(signal > ${var.connection_refused_to_sql_ratio_threshold_critical}%{if var.connection_refused_to_sql_ratio_lasting_duration_critical != null}, lasting='${var.connection_refused_to_sql_ratio_lasting_duration_critical}', at_least=${var.connection_refused_to_sql_ratio_at_least_percentage_critical}%{endif}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.connection_refused_to_sql_ratio_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.connection_refused_to_sql_ratio_disabled_critical, var.connection_refused_to_sql_ratio_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.connection_refused_to_sql_ratio_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.connection_refused_to_sql_ratio_runbook_url, var.runbook_url), "")
    tip                   = var.connection_refused_to_sql_ratio_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.connection_refused_to_sql_ratio_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.connection_refused_to_sql_ratio_disabled_major, var.connection_refused_to_sql_ratio_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.connection_refused_to_sql_ratio_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.connection_refused_to_sql_ratio_runbook_url, var.runbook_url), "")
    tip                   = var.connection_refused_to_sql_ratio_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.connection_refused_to_sql_ratio_max_delay
}

resource "signalfx_detector" "error_rate_5xx" {
  name = format("%s %s", local.detector_name_prefix, "GCP Cloud Run 5xx error rate on container")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  viz_options {
    label        = "signal"
    value_suffix = "%"
  }

  program_text = <<-EOF
    base_filtering = filter('service_name', 'response_code_class')
    errors = data('request_count', filter=base_filtering and filter('response_code_class', '4xx') and ${module.filtering.signalflow}, rollup='sum', extrapolation='zero')${var.error_rate_5xx_aggregation_function}${var.error_rate_5xx_transformation_function}
    requests = data('request_count', filter=base_filtering and ${module.filtering.signalflow}, rollup='sum', extrapolation='zero')${var.error_rate_5xx_aggregation_function}${var.error_rate_5xx_transformation_function}
    signal = (errors/requests).scale(100).fill(value=0).publish('signal')
    detect(when(signal > ${var.error_rate_5xx_threshold_critical}%{if var.error_rate_5xx_lasting_duration_critical != null}, lasting='${var.error_rate_5xx_lasting_duration_critical}', at_least=${var.error_rate_5xx_at_least_percentage_critical}%{endif}) and when(requests > ${var.minimum_traffic})).publish('CRIT')
    detect(when(signal > ${var.error_rate_5xx_threshold_major}%{if var.error_rate_5xx_lasting_duration_major != null}, lasting='${var.error_rate_5xx_lasting_duration_major}', at_least=${var.error_rate_5xx_at_least_percentage_major}%{endif}) and when(requests > ${var.minimum_traffic}) and (not when(signal > ${var.error_rate_5xx_threshold_critical}%{if var.error_rate_5xx_lasting_duration_critical != null}, lasting='${var.error_rate_5xx_lasting_duration_critical}', at_least=${var.error_rate_5xx_at_least_percentage_critical}%{endif}) and when(requests > ${var.minimum_traffic}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.error_rate_5xx_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.error_rate_5xx_disabled_critical, var.error_rate_5xx_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.error_rate_5xx_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.error_rate_5xx_runbook_url, var.runbook_url), "")
    tip                   = var.error_rate_5xx_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.error_rate_5xx_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.error_rate_5xx_disabled_major, var.error_rate_5xx_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.error_rate_5xx_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.error_rate_5xx_runbook_url, var.runbook_url), "")
    tip                   = var.error_rate_5xx_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.error_rate_5xx_max_delay
}

