resource "signalfx_detector" "heartbeat" {
  name = format("%s %s", local.detector_name_prefix, "HTTP heartbeat")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    from signalfx.detectors.not_reporting import not_reporting
    signal = data('http.status_code', filter=${local.not_running_vm_filters} and ${module.filtering.signalflow})${var.heartbeat_aggregation_function}.publish('signal')
    not_reporting.detector(stream=signal, resource_identifier=None, duration='${var.heartbeat_timeframe}', auto_resolve_after='${local.heartbeat_auto_resolve_after}').publish('CRIT')
EOF

  rule {
    description           = "has not reported in ${var.heartbeat_timeframe}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.heartbeat_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.heartbeat_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.heartbeat_runbook_url, var.runbook_url), "")
    tip                   = var.heartbeat_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject_novalue : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.heartbeat_max_delay
}

resource "signalfx_detector" "http_code_matched" {
  name = format("%s %s", local.detector_name_prefix, "HTTP code")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    signal = data('http.code_matched', filter=${module.filtering.signalflow}, rollup='min')${var.http_code_matched_aggregation_function}${var.http_code_matched_transformation_function}.publish('signal')
    detect(when(signal < ${var.http_code_matched_threshold_critical}, lasting=%{if var.http_code_matched_lasting_duration_critical == null}None%{else}'${var.http_code_matched_lasting_duration_critical}'%{endif}, at_least=${var.http_code_matched_at_least_percentage_critical})).publish('CRIT')
EOF

  rule {
    description           = "does not match expected result < ${var.http_code_matched_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.http_code_matched_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.http_code_matched_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.http_code_matched_runbook_url, var.runbook_url), "")
    tip                   = var.http_code_matched_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.http_code_matched_max_delay
}

resource "signalfx_detector" "http_regex_matched" {
  name = format("%s %s", local.detector_name_prefix, "HTTP regex expression")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    signal = data('http.regex_matched', filter=${module.filtering.signalflow}, rollup='min')${var.http_regex_matched_aggregation_function}${var.http_regex_matched_transformation_function}.publish('signal')
    detect(when(signal < ${var.http_regex_matched_threshold_critical}, lasting=%{if var.http_regex_matched_lasting_duration_critical == null}None%{else}'${var.http_regex_matched_lasting_duration_critical}'%{endif}, at_least=${var.http_regex_matched_at_least_percentage_critical})).publish('CRIT')
EOF

  rule {
    description           = "does not match in body response < ${var.http_regex_matched_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.http_regex_matched_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.http_regex_matched_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.http_regex_matched_runbook_url, var.runbook_url), "")
    tip                   = var.http_regex_matched_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.http_regex_matched_max_delay
}

resource "signalfx_detector" "http_response_time" {
  name = format("%s %s", local.detector_name_prefix, "HTTP response time")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    signal = data('http.response_time', filter=${module.filtering.signalflow}, rollup='max')${var.http_response_time_aggregation_function}${var.http_response_time_transformation_function}.publish('signal')
    detect(when(signal > ${var.http_response_time_threshold_critical}, lasting=%{if var.http_response_time_lasting_duration_critical == null}None%{else}'${var.http_response_time_lasting_duration_critical}'%{endif}, at_least=${var.http_response_time_at_least_percentage_critical})).publish('CRIT')
    detect(when(signal > ${var.http_response_time_threshold_major}, lasting=%{if var.http_response_time_lasting_duration_major == null}None%{else}'${var.http_response_time_lasting_duration_major}'%{endif}, at_least=${var.http_response_time_at_least_percentage_major})).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.http_response_time_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.http_response_time_disabled_critical, var.http_response_time_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.http_response_time_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.http_response_time_runbook_url, var.runbook_url), "")
    tip                   = var.http_response_time_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.http_response_time_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.http_response_time_disabled_major, var.http_response_time_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.http_response_time_notifications, "major", []), var.notifications.major)
    runbook_url           = try(coalesce(var.http_response_time_runbook_url, var.runbook_url), "")
    tip                   = var.http_response_time_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.http_response_time_max_delay
}

resource "signalfx_detector" "http_content_length" {
  name = format("%s %s", local.detector_name_prefix, "HTTP content length")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  viz_options {
    label      = "signal"
    value_unit = "Byte"
  }

  program_text = <<-EOF
    signal = data('http.content_length', filter=${module.filtering.signalflow}, rollup='min')${var.http_content_length_aggregation_function}${var.http_content_length_transformation_function}.publish('signal')
    detect(when(signal < ${var.http_content_length_threshold_warning}, lasting=%{if var.http_content_length_lasting_duration_warning == null}None%{else}'${var.http_content_length_lasting_duration_warning}'%{endif}, at_least=${var.http_content_length_at_least_percentage_warning})).publish('WARN')
EOF

  rule {
    description           = "is too low < ${var.http_content_length_threshold_warning}Byte"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.http_content_length_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.http_content_length_notifications, "warning", []), var.notifications.warning)
    runbook_url           = try(coalesce(var.http_content_length_runbook_url, var.runbook_url), "")
    tip                   = var.http_content_length_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.http_content_length_max_delay
}

resource "signalfx_detector" "certificate_expiration_date" {
  name = format("%s %s", local.detector_name_prefix, "TLS certificate expiry date")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  viz_options {
    label        = "signal"
    value_suffix = "days"
  }

  program_text = <<-EOF
    expiry = data('http.cert_expiry', filter=${module.filtering.signalflow}, rollup='min')${var.certificate_expiration_date_aggregation_function}${var.certificate_expiration_date_transformation_function}
    signal = (expiry/86400).publish('signal')
    detect(when(signal < ${var.certificate_expiration_date_threshold_major}, lasting=%{if var.certificate_expiration_date_lasting_duration_major == null}None%{else}'${var.certificate_expiration_date_lasting_duration_major}'%{endif}, at_least=${var.certificate_expiration_date_at_least_percentage_major})).publish('MAJOR')
    detect(when(signal < ${var.certificate_expiration_date_threshold_minor}, lasting=%{if var.certificate_expiration_date_lasting_duration_minor == null}None%{else}'${var.certificate_expiration_date_lasting_duration_minor}'%{endif}, at_least=${var.certificate_expiration_date_at_least_percentage_minor}) and (not when(signal < ${var.certificate_expiration_date_threshold_major}, lasting=%{if var.certificate_expiration_date_lasting_duration_major == null}None%{else}'${var.certificate_expiration_date_lasting_duration_major}'%{endif}, at_least=${var.certificate_expiration_date_at_least_percentage_major}))).publish('MINOR')
EOF

  rule {
    description           = "is too soon < ${var.certificate_expiration_date_threshold_major}days"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.certificate_expiration_date_disabled_major, var.certificate_expiration_date_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.certificate_expiration_date_notifications, "major", []), var.notifications.major)
    runbook_url           = try(coalesce(var.certificate_expiration_date_runbook_url, var.runbook_url), "")
    tip                   = var.certificate_expiration_date_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too soon < ${var.certificate_expiration_date_threshold_minor}days"
    severity              = "Minor"
    detect_label          = "MINOR"
    disabled              = coalesce(var.certificate_expiration_date_disabled_minor, var.certificate_expiration_date_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.certificate_expiration_date_notifications, "minor", []), var.notifications.minor)
    runbook_url           = try(coalesce(var.certificate_expiration_date_runbook_url, var.runbook_url), "")
    tip                   = var.certificate_expiration_date_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.certificate_expiration_date_max_delay
}

resource "signalfx_detector" "invalid_tls_certificate" {
  name = format("%s %s", local.detector_name_prefix, "TLS certificate")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  viz_options {
    label        = "signal"
    value_suffix = "days"
  }

  program_text = <<-EOF
    signal = data('http.cert_valid', filter=${module.filtering.signalflow}, rollup='min')${var.invalid_tls_certificate_aggregation_function}${var.invalid_tls_certificate_transformation_function}.publish('signal')
    detect(when(signal < ${var.invalid_tls_certificate_threshold_critical}, lasting=%{if var.invalid_tls_certificate_lasting_duration_critical == null}None%{else}'${var.invalid_tls_certificate_lasting_duration_critical}'%{endif}, at_least=${var.invalid_tls_certificate_at_least_percentage_critical})).publish('CRIT')
EOF

  rule {
    description           = "is invalid < ${var.invalid_tls_certificate_threshold_critical}days"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.invalid_tls_certificate_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.invalid_tls_certificate_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.invalid_tls_certificate_runbook_url, var.runbook_url), "")
    tip                   = var.invalid_tls_certificate_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.invalid_tls_certificate_max_delay
}

