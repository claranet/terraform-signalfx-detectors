resource "signalfx_detector" "error_rate_5xx" {
  name = format("%s %s", local.detector_name_prefix, "GCP Load Balancer 5xx error rate")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  viz_options {
    label        = "signal"
    value_suffix = "%"
  }

  program_text = <<-EOF
    base_filtering = filter('service', 'loadbalancing')
    errors = data('https/request_count', filter=base_filtering and filter('response_code_class', '500') and ${module.filtering.signalflow}, rollup='sum', extrapolation='zero')${var.error_rate_5xx_aggregation_function}${var.error_rate_5xx_transformation_function}
    requests = data('https/request_count', filter=base_filtering and ${module.filtering.signalflow}, rollup='sum', extrapolation='zero')${var.error_rate_5xx_aggregation_function}${var.error_rate_5xx_transformation_function}
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

resource "signalfx_detector" "error_rate_4xx" {
  name = format("%s %s", local.detector_name_prefix, "GCP Load Balancer 4xx error rate")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  viz_options {
    label        = "signal"
    value_suffix = "%"
  }

  program_text = <<-EOF
    base_filtering = filter('service', 'loadbalancing')
    errors = data('https/request_count', filter=base_filtering and filter('response_code_class', '400') and ${module.filtering.signalflow}, rollup='sum', extrapolation='zero')${var.error_rate_4xx_aggregation_function}${var.error_rate_4xx_transformation_function}
    requests = data('https/request_count', filter=base_filtering and ${module.filtering.signalflow}, rollup='sum', extrapolation='zero')${var.error_rate_4xx_aggregation_function}${var.error_rate_4xx_transformation_function}
    signal = (errors/requests).scale(100).fill(value=0).publish('signal')
    detect(when(signal > ${var.error_rate_4xx_threshold_critical}%{if var.error_rate_4xx_lasting_duration_critical != null}, lasting='${var.error_rate_4xx_lasting_duration_critical}', at_least=${var.error_rate_4xx_at_least_percentage_critical}%{endif}) and when(requests > ${var.minimum_traffic})).publish('CRIT')
    detect(when(signal > ${var.error_rate_4xx_threshold_major}%{if var.error_rate_4xx_lasting_duration_major != null}, lasting='${var.error_rate_4xx_lasting_duration_major}', at_least=${var.error_rate_4xx_at_least_percentage_major}%{endif}) and when(requests > ${var.minimum_traffic}) and (not when(signal > ${var.error_rate_4xx_threshold_critical}%{if var.error_rate_4xx_lasting_duration_critical != null}, lasting='${var.error_rate_4xx_lasting_duration_critical}', at_least=${var.error_rate_4xx_at_least_percentage_critical}%{endif}) and when(requests > ${var.minimum_traffic}))).publish('MAJOR')
    detect(when(signal > ${var.error_rate_4xx_threshold_minor}%{if var.error_rate_4xx_lasting_duration_minor != null}, lasting='${var.error_rate_4xx_lasting_duration_minor}', at_least=${var.error_rate_4xx_at_least_percentage_minor}%{endif}) and when(requests > ${var.minimum_traffic}) and (not when(signal > ${var.error_rate_4xx_threshold_major}%{if var.error_rate_4xx_lasting_duration_major != null}, lasting='${var.error_rate_4xx_lasting_duration_major}', at_least=${var.error_rate_4xx_at_least_percentage_major}%{endif}) and when(requests > ${var.minimum_traffic}))).publish('MINOR')
EOF

  rule {
    description           = "is too high > ${var.error_rate_4xx_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.error_rate_4xx_disabled_critical, var.error_rate_4xx_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.error_rate_4xx_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.error_rate_4xx_runbook_url, var.runbook_url), "")
    tip                   = var.error_rate_4xx_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.error_rate_4xx_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.error_rate_4xx_disabled_major, var.error_rate_4xx_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.error_rate_4xx_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.error_rate_4xx_runbook_url, var.runbook_url), "")
    tip                   = var.error_rate_4xx_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.error_rate_4xx_threshold_minor}%"
    severity              = "Minor"
    detect_label          = "MINOR"
    disabled              = coalesce(var.error_rate_4xx_disabled_minor, var.error_rate_4xx_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.error_rate_4xx_notifications, "minor", []), var.notifications.minor), null)
    runbook_url           = try(coalesce(var.error_rate_4xx_runbook_url, var.runbook_url), "")
    tip                   = var.error_rate_4xx_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.error_rate_4xx_max_delay
}

resource "signalfx_detector" "backend_latency_service" {
  name = format("%s %s", local.detector_name_prefix, "GCP Load Balancer backend latency per service")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  viz_options {
    label      = "signal"
    value_unit = "Millisecond"
  }

  program_text = <<-EOF
    base_filtering = filter('service', 'loadbalancing')
    signal = data('https/backend_latencies', filter=base_filtering and filter('backend_target_type', 'BACKEND_SERVICE') and ${module.filtering.signalflow}, rollup='average', extrapolation='zero')${var.backend_latency_service_aggregation_function}${var.backend_latency_service_transformation_function}.publish('signal')
    detect(when(signal > ${var.backend_latency_service_threshold_critical}%{if var.backend_latency_service_lasting_duration_critical != null}, lasting='${var.backend_latency_service_lasting_duration_critical}', at_least=${var.backend_latency_service_at_least_percentage_critical}%{endif})).publish('CRIT')
    detect(when(signal > ${var.backend_latency_service_threshold_major}%{if var.backend_latency_service_lasting_duration_major != null}, lasting='${var.backend_latency_service_lasting_duration_major}', at_least=${var.backend_latency_service_at_least_percentage_major}%{endif}) and (not when(signal > ${var.backend_latency_service_threshold_critical}%{if var.backend_latency_service_lasting_duration_critical != null}, lasting='${var.backend_latency_service_lasting_duration_critical}', at_least=${var.backend_latency_service_at_least_percentage_critical}%{endif}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.backend_latency_service_threshold_critical}Millisecond"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.backend_latency_service_disabled_critical, var.backend_latency_service_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.backend_latency_service_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.backend_latency_service_runbook_url, var.runbook_url), "")
    tip                   = var.backend_latency_service_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.backend_latency_service_threshold_major}Millisecond"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.backend_latency_service_disabled_major, var.backend_latency_service_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.backend_latency_service_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.backend_latency_service_runbook_url, var.runbook_url), "")
    tip                   = var.backend_latency_service_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.backend_latency_service_max_delay
}

resource "signalfx_detector" "backend_latency_bucket" {
  name = format("%s %s", local.detector_name_prefix, "GCP Load Balancer backend latency per bucket")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  viz_options {
    label      = "signal"
    value_unit = "Millisecond"
  }

  program_text = <<-EOF
    base_filtering = filter('service', 'loadbalancing')
    signal = data('https/backend_latencies', filter=base_filtering and filter('backend_target_type', 'BACKEND_BUCKET') and ${module.filtering.signalflow}, rollup='average', extrapolation='zero')${var.backend_latency_bucket_aggregation_function}${var.backend_latency_bucket_transformation_function}.publish('signal')
    detect(when(signal > ${var.backend_latency_bucket_threshold_critical}%{if var.backend_latency_bucket_lasting_duration_critical != null}, lasting='${var.backend_latency_bucket_lasting_duration_critical}', at_least=${var.backend_latency_bucket_at_least_percentage_critical}%{endif})).publish('CRIT')
    detect(when(signal > ${var.backend_latency_bucket_threshold_major}%{if var.backend_latency_bucket_lasting_duration_major != null}, lasting='${var.backend_latency_bucket_lasting_duration_major}', at_least=${var.backend_latency_bucket_at_least_percentage_major}%{endif}) and (not when(signal > ${var.backend_latency_bucket_threshold_critical}%{if var.backend_latency_bucket_lasting_duration_critical != null}, lasting='${var.backend_latency_bucket_lasting_duration_critical}', at_least=${var.backend_latency_bucket_at_least_percentage_critical}%{endif}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.backend_latency_bucket_threshold_critical}Millisecond"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.backend_latency_bucket_disabled_critical, var.backend_latency_bucket_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.backend_latency_bucket_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.backend_latency_bucket_runbook_url, var.runbook_url), "")
    tip                   = var.backend_latency_bucket_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.backend_latency_bucket_threshold_major}Millisecond"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.backend_latency_bucket_disabled_major, var.backend_latency_bucket_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.backend_latency_bucket_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.backend_latency_bucket_runbook_url, var.runbook_url), "")
    tip                   = var.backend_latency_bucket_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.backend_latency_bucket_max_delay
}

resource "signalfx_detector" "request_count" {
  name = format("%s %s", local.detector_name_prefix, "GCP Load Balancer request count")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    base_filtering = filter('service', 'loadbalancing')
    signal = data('https/request_count', filter=base_filtering and ${module.filtering.signalflow}, rollup='sum', extrapolation='last_value')${var.request_count_aggregation_function}${var.request_count_transformation_function}.publish('signal')
    detect(when(signal > ${var.request_count_threshold_minor}%{if var.request_count_lasting_duration_minor != null}, lasting='${var.request_count_lasting_duration_minor}', at_least=${var.request_count_at_least_percentage_minor}%{endif})).publish('MINOR')
    detect(when(signal > ${var.request_count_threshold_warning}%{if var.request_count_lasting_duration_warning != null}, lasting='${var.request_count_lasting_duration_warning}', at_least=${var.request_count_at_least_percentage_warning}%{endif}) and (not when(signal > ${var.request_count_threshold_minor}%{if var.request_count_lasting_duration_minor != null}, lasting='${var.request_count_lasting_duration_minor}', at_least=${var.request_count_at_least_percentage_minor}%{endif}))).publish('WARN')
EOF

  rule {
    description           = "is too high > ${var.request_count_threshold_minor}"
    severity              = "Minor"
    detect_label          = "MINOR"
    disabled              = coalesce(var.request_count_disabled_minor, var.request_count_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.request_count_notifications, "minor", []), var.notifications.minor), null)
    runbook_url           = try(coalesce(var.request_count_runbook_url, var.runbook_url), "")
    tip                   = var.request_count_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.request_count_threshold_warning}"
    severity              = "Warning"
    detect_label          = "WARN"
    disabled              = coalesce(var.request_count_disabled_warning, var.request_count_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.request_count_notifications, "warning", []), var.notifications.warning), null)
    runbook_url           = try(coalesce(var.request_count_runbook_url, var.runbook_url), "")
    tip                   = var.request_count_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.request_count_max_delay
}

