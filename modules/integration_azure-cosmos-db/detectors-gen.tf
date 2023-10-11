resource "signalfx_detector" "heartbeat" {
  name = format("%s %s", local.detector_name_prefix, "Azure Cosmos DB heartbeat")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    from signalfx.detectors.not_reporting import not_reporting
    base_filtering = filter('resource_type', 'Microsoft.DocumentDB/databaseAccounts') and filter('primary_aggregation_type', 'true')
    signal = data('AvailableStorage', filter=base_filtering and ${module.filtering.signalflow})${var.heartbeat_aggregation_function}${var.heartbeat_transformation_function}.publish('signal')
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

resource "signalfx_detector" "database_4xx_request_rate" {
  name = format("%s %s", local.detector_name_prefix, "Azure Cosmos DB database 4xx request rate")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  viz_options {
    label        = "signal"
    value_suffix = "%"
  }

  program_text = <<-EOF
    base_filtering = filter('resource_type', 'Microsoft.DocumentDB/databaseAccounts') and filter('primary_aggregation_type', 'true')
    db_4xx_requests = data('TotalRequests', filter=base_filtering and filter('statuscode', '4*') and ${module.filtering.signalflow}, extrapolation='zero')${var.database_4xx_request_rate_aggregation_function}${var.database_4xx_request_rate_transformation_function}
    total = data('TotalRequests', filter=base_filtering and ${module.filtering.signalflow}, extrapolation='zero')${var.database_4xx_request_rate_aggregation_function}${var.database_4xx_request_rate_transformation_function}
    signal = (db_4xx_requests/total).scale(100).fill(0).publish('signal')
    detect(when(signal > ${var.database_4xx_request_rate_threshold_critical}, lasting=%{if var.database_4xx_request_rate_lasting_duration_critical == null}None%{else}'${var.database_4xx_request_rate_lasting_duration_critical}'%{endif}, at_least=${var.database_4xx_request_rate_at_least_percentage_critical})).publish('CRIT')
    detect(when(signal > ${var.database_4xx_request_rate_threshold_major}, lasting=%{if var.database_4xx_request_rate_lasting_duration_major == null}None%{else}'${var.database_4xx_request_rate_lasting_duration_major}'%{endif}, at_least=${var.database_4xx_request_rate_at_least_percentage_major}) and (not when(signal > ${var.database_4xx_request_rate_threshold_critical}, lasting=%{if var.database_4xx_request_rate_lasting_duration_critical == null}None%{else}'${var.database_4xx_request_rate_lasting_duration_critical}'%{endif}, at_least=${var.database_4xx_request_rate_at_least_percentage_critical}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.database_4xx_request_rate_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.database_4xx_request_rate_disabled_critical, var.database_4xx_request_rate_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.database_4xx_request_rate_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.database_4xx_request_rate_runbook_url, var.runbook_url), "")
    tip                   = var.database_4xx_request_rate_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.database_4xx_request_rate_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.database_4xx_request_rate_disabled_major, var.database_4xx_request_rate_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.database_4xx_request_rate_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.database_4xx_request_rate_runbook_url, var.runbook_url), "")
    tip                   = var.database_4xx_request_rate_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.database_4xx_request_rate_max_delay
}

resource "signalfx_detector" "database_5xx_request_rate" {
  name = format("%s %s", local.detector_name_prefix, "Azure Cosmos DB database 5xx request rate")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  viz_options {
    label        = "signal"
    value_suffix = "%"
  }

  program_text = <<-EOF
    base_filtering = filter('resource_type', 'Microsoft.DocumentDB/databaseAccounts') and filter('primary_aggregation_type', 'true')
    db_5xx_requests = data('TotalRequests', filter=base_filtering and filter('statuscode', '5*') and ${module.filtering.signalflow}, extrapolation='zero')${var.database_5xx_request_rate_aggregation_function}${var.database_5xx_request_rate_transformation_function}
    total = data('TotalRequests', filter=base_filtering and ${module.filtering.signalflow}, extrapolation='zero')${var.database_5xx_request_rate_aggregation_function}${var.database_5xx_request_rate_transformation_function}
    signal = (db_5xx_requests/total).scale(100).fill(0).publish('signal')
    detect(when(signal > ${var.database_5xx_request_rate_threshold_critical}, lasting=%{if var.database_5xx_request_rate_lasting_duration_critical == null}None%{else}'${var.database_5xx_request_rate_lasting_duration_critical}'%{endif}, at_least=${var.database_5xx_request_rate_at_least_percentage_critical})).publish('CRIT')
    detect(when(signal > ${var.database_5xx_request_rate_threshold_major}, lasting=%{if var.database_5xx_request_rate_lasting_duration_major == null}None%{else}'${var.database_5xx_request_rate_lasting_duration_major}'%{endif}, at_least=${var.database_5xx_request_rate_at_least_percentage_major}) and (not when(signal > ${var.database_5xx_request_rate_threshold_critical}, lasting=%{if var.database_5xx_request_rate_lasting_duration_critical == null}None%{else}'${var.database_5xx_request_rate_lasting_duration_critical}'%{endif}, at_least=${var.database_5xx_request_rate_at_least_percentage_critical}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.database_5xx_request_rate_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.database_5xx_request_rate_disabled_critical, var.database_5xx_request_rate_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.database_5xx_request_rate_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.database_5xx_request_rate_runbook_url, var.runbook_url), "")
    tip                   = var.database_5xx_request_rate_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.database_5xx_request_rate_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.database_5xx_request_rate_disabled_major, var.database_5xx_request_rate_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.database_5xx_request_rate_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.database_5xx_request_rate_runbook_url, var.runbook_url), "")
    tip                   = var.database_5xx_request_rate_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.database_5xx_request_rate_max_delay
}

resource "signalfx_detector" "scaling" {
  name = format("%s %s", local.detector_name_prefix, "Azure Cosmos DB scaling")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  viz_options {
    label        = "signal"
    value_suffix = "%"
  }

  program_text = <<-EOF
    base_filtering = filter('resource_type', 'Microsoft.DocumentDB/databaseAccounts') and filter('primary_aggregation_type', 'true')
    throttled = data('TotalRequests', filter=base_filtering and filter('statuscode', '429') and ${module.filtering.signalflow}, extrapolation='zero')${var.scaling_aggregation_function}${var.scaling_transformation_function}
    total = data('TotalRequests', filter=base_filtering and ${module.filtering.signalflow}, extrapolation='zero')${var.scaling_aggregation_function}${var.scaling_transformation_function}
    signal = (throttled/total).scale(100).fill(0).publish('signal')
    detect(when(signal > ${var.scaling_threshold_critical}, lasting=%{if var.scaling_lasting_duration_critical == null}None%{else}'${var.scaling_lasting_duration_critical}'%{endif}, at_least=${var.scaling_at_least_percentage_critical})).publish('CRIT')
    detect(when(signal > ${var.scaling_threshold_major}, lasting=%{if var.scaling_lasting_duration_major == null}None%{else}'${var.scaling_lasting_duration_major}'%{endif}, at_least=${var.scaling_at_least_percentage_major}) and (not when(signal > ${var.scaling_threshold_critical}, lasting=%{if var.scaling_lasting_duration_critical == null}None%{else}'${var.scaling_lasting_duration_critical}'%{endif}, at_least=${var.scaling_at_least_percentage_critical}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.scaling_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.scaling_disabled_critical, var.scaling_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.scaling_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.scaling_runbook_url, var.runbook_url), "")
    tip                   = var.scaling_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.scaling_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.scaling_disabled_major, var.scaling_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.scaling_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.scaling_runbook_url, var.runbook_url), "")
    tip                   = var.scaling_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.scaling_max_delay
}

resource "signalfx_detector" "request_units_consumption" {
  name = format("%s %s", local.detector_name_prefix, "Azure Cosmos DB request units consumption")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  viz_options {
    label        = "signal"
    value_suffix = "%"
  }

  program_text = <<-EOF
    base_filtering = filter('resource_type', 'Microsoft.DocumentDB/databaseAccounts') and filter('primary_aggregation_type', 'true')
    signal = data('NormalizedruConsumption', filter=base_filtering and ${module.filtering.signalflow})${var.request_units_consumption_aggregation_function}${var.request_units_consumption_transformation_function}.publish('signal')
    detect(when(signal > ${var.request_units_consumption_threshold_critical}, lasting=%{if var.request_units_consumption_lasting_duration_critical == null}None%{else}'${var.request_units_consumption_lasting_duration_critical}'%{endif}, at_least=${var.request_units_consumption_at_least_percentage_critical})).publish('CRIT')
    detect(when(signal > ${var.request_units_consumption_threshold_major}, lasting=%{if var.request_units_consumption_lasting_duration_major == null}None%{else}'${var.request_units_consumption_lasting_duration_major}'%{endif}, at_least=${var.request_units_consumption_at_least_percentage_major}) and (not when(signal > ${var.request_units_consumption_threshold_critical}, lasting=%{if var.request_units_consumption_lasting_duration_critical == null}None%{else}'${var.request_units_consumption_lasting_duration_critical}'%{endif}, at_least=${var.request_units_consumption_at_least_percentage_critical}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.request_units_consumption_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.request_units_consumption_disabled_critical, var.request_units_consumption_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.request_units_consumption_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.request_units_consumption_runbook_url, var.runbook_url), "")
    tip                   = var.request_units_consumption_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.request_units_consumption_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.request_units_consumption_disabled_major, var.request_units_consumption_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.request_units_consumption_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.request_units_consumption_runbook_url, var.runbook_url), "")
    tip                   = var.request_units_consumption_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.request_units_consumption_max_delay
}

