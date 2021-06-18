resource "signalfx_detector" "concurrent_queries" {
  name = format("%s %s", local.detector_name_prefix, "GCP BigQuery concurrent queries")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)

  program_text = <<-EOF
    from signalfx.detectors.aperiodic import conditions
    signal = data('query/count', ${module.filtering.signalflow})${var.concurrent_queries_aggregation_function}${var.concurrent_queries_transformation_function}.publish('signal')
    ON_Condition_CRIT = conditions.generic_condition(signal, ${var.concurrent_queries_threshold_critical}, ${var.concurrent_queries_threshold_critical}, 'above', lasting('${var.concurrent_queries_aperiodic_duration}', ${var.concurrent_queries_aperiodic_percentage}), 'observed')
    ON_Condition_MAJOR = conditions.generic_condition(signal, ${var.concurrent_queries_threshold_major}, ${var.concurrent_queries_threshold_critical}, 'within_range', lasting('${var.concurrent_queries_aperiodic_duration}', ${var.concurrent_queries_aperiodic_percentage}), 'observed', strict_2=False)
    detect(ON_Condition_CRIT, off=when(signal is None, '${var.concurrent_queries_clear_duration}')).publish('CRIT')
    detect(ON_Condition_MAJOR, off=when(signal is None, '${var.concurrent_queries_clear_duration}')).publish('MAJOR')
EOF

  rule {
    description           = "are too high > ${var.concurrent_queries_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.concurrent_queries_disabled_critical, var.concurrent_queries_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.concurrent_queries_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.concurrent_queries_runbook_url, var.runbook_url), "")
    tip                   = var.concurrent_queries_tip
    parameterized_subject = coalesce(var.message_subject, local.rule_subject)
    parameterized_body    = coalesce(var.message_body, local.rule_body)
  }

  rule {
    description           = "are too high > ${var.concurrent_queries_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.concurrent_queries_disabled_major, var.concurrent_queries_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.concurrent_queries_notifications, "major", []), var.notifications.major)
    runbook_url           = try(coalesce(var.concurrent_queries_runbook_url, var.runbook_url), "")
    tip                   = var.concurrent_queries_tip
    parameterized_subject = coalesce(var.message_subject, local.rule_subject)
    parameterized_body    = coalesce(var.message_body, local.rule_body)
  }

}

resource "signalfx_detector" "execution_time" {
  name = format("%s %s", local.detector_name_prefix, "GCP BigQuery execution time")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)

  program_text = <<-EOF
    from signalfx.detectors.aperiodic import conditions
    signal = data('query/execution_times', ${module.filtering.signalflow})${var.execution_time_aggregation_function}${var.execution_time_transformation_function}.publish('signal')
    ON_Condition_CRIT = conditions.generic_condition(signal, ${var.execution_time_threshold_critical}, ${var.execution_time_threshold_critical}, 'above', lasting('${var.execution_time_aperiodic_duration}', ${var.execution_time_aperiodic_percentage}), 'observed')
    ON_Condition_MAJOR = conditions.generic_condition(signal, ${var.execution_time_threshold_major}, ${var.execution_time_threshold_critical}, 'within_range', lasting('${var.execution_time_aperiodic_duration}', ${var.execution_time_aperiodic_percentage}), 'observed', strict_2=False)
    detect(ON_Condition_CRIT, off=when(signal is None, '${var.execution_time_clear_duration}')).publish('CRIT')
    detect(ON_Condition_MAJOR, off=when(signal is None, '${var.execution_time_clear_duration}')).publish('MAJOR')
EOF

  rule {
    description           = "are too high > ${var.execution_time_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.execution_time_disabled_critical, var.execution_time_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.execution_time_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.execution_time_runbook_url, var.runbook_url), "")
    tip                   = var.execution_time_tip
    parameterized_subject = coalesce(var.message_subject, local.rule_subject)
    parameterized_body    = coalesce(var.message_body, local.rule_body)
  }

  rule {
    description           = "are too high > ${var.execution_time_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.execution_time_disabled_major, var.execution_time_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.execution_time_notifications, "major", []), var.notifications.major)
    runbook_url           = try(coalesce(var.execution_time_runbook_url, var.runbook_url), "")
    tip                   = var.execution_time_tip
    parameterized_subject = coalesce(var.message_subject, local.rule_subject)
    parameterized_body    = coalesce(var.message_body, local.rule_body)
  }

}

resource "signalfx_detector" "scanned_bytes" {
  name = format("%s %s", local.detector_name_prefix, "GCP BigQuery scanned bytes")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)

  program_text = <<-EOF
    from signalfx.detectors.aperiodic import conditions
    signal = data('query/scanned_bytes', ${module.filtering.signalflow})${var.scanned_bytes_aggregation_function}${var.scanned_bytes_transformation_function}.publish('signal')
    ON_Condition_CRIT = conditions.generic_condition(signal, ${var.scanned_bytes_threshold_critical}, ${var.scanned_bytes_threshold_critical}, 'above', lasting('${var.scanned_bytes_aperiodic_duration}', ${var.scanned_bytes_aperiodic_percentage}), 'observed')
    ON_Condition_MAJOR = conditions.generic_condition(signal, ${var.scanned_bytes_threshold_major}, ${var.scanned_bytes_threshold_critical}, 'within_range', lasting('${var.scanned_bytes_aperiodic_duration}', ${var.scanned_bytes_aperiodic_percentage}), 'observed', strict_2=False)
    detect(ON_Condition_CRIT, off=when(signal is None, '${var.scanned_bytes_clear_duration}')).publish('CRIT')
    detect(ON_Condition_MAJOR, off=when(signal is None, '${var.scanned_bytes_clear_duration}')).publish('MAJOR')
EOF

  rule {
    description           = "are too high > ${var.scanned_bytes_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.scanned_bytes_disabled_critical, var.scanned_bytes_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.scanned_bytes_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.scanned_bytes_runbook_url, var.runbook_url), "")
    tip                   = var.scanned_bytes_tip
    parameterized_subject = coalesce(var.message_subject, local.rule_subject)
    parameterized_body    = coalesce(var.message_body, local.rule_body)
  }

  rule {
    description           = "are too high > ${var.scanned_bytes_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.scanned_bytes_disabled_major, var.scanned_bytes_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.scanned_bytes_notifications, "major", []), var.notifications.major)
    runbook_url           = try(coalesce(var.scanned_bytes_runbook_url, var.runbook_url), "")
    tip                   = var.scanned_bytes_tip
    parameterized_subject = coalesce(var.message_subject, local.rule_subject)
    parameterized_body    = coalesce(var.message_body, local.rule_body)
  }

}

resource "signalfx_detector" "scanned_bytes_billed" {
  name = format("%s %s", local.detector_name_prefix, "GCP BigQuery scanned bytes billed")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)

  program_text = <<-EOF
    from signalfx.detectors.aperiodic import conditions
    signal = data('query/scanned_bytes_billed', ${module.filtering.signalflow})${var.scanned_bytes_billed_aggregation_function}${var.scanned_bytes_billed_transformation_function}.publish('signal')
    ON_Condition_CRIT = conditions.generic_condition(signal, ${var.scanned_bytes_billed_threshold_critical}, ${var.scanned_bytes_billed_threshold_critical}, 'above', lasting('${var.scanned_bytes_billed_aperiodic_duration}', ${var.scanned_bytes_billed_aperiodic_percentage}), 'observed')
    ON_Condition_MAJOR = conditions.generic_condition(signal, ${var.scanned_bytes_billed_threshold_major}, ${var.scanned_bytes_billed_threshold_critical}, 'within_range', lasting('${var.scanned_bytes_billed_aperiodic_duration}', ${var.scanned_bytes_billed_aperiodic_percentage}), 'observed', strict_2=False)
    detect(ON_Condition_CRIT, off=when(signal is None, '${var.scanned_bytes_billed_clear_duration}')).publish('CRIT')
    detect(ON_Condition_MAJOR, off=when(signal is None, '${var.scanned_bytes_billed_clear_duration}')).publish('MAJOR')
EOF

  rule {
    description           = "are too high > ${var.scanned_bytes_billed_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.scanned_bytes_billed_disabled_critical, var.scanned_bytes_billed_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.scanned_bytes_billed_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.scanned_bytes_billed_runbook_url, var.runbook_url), "")
    tip                   = var.scanned_bytes_billed_tip
    parameterized_subject = coalesce(var.message_subject, local.rule_subject)
    parameterized_body    = coalesce(var.message_body, local.rule_body)
  }

  rule {
    description           = "are too high > ${var.scanned_bytes_billed_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.scanned_bytes_billed_disabled_major, var.scanned_bytes_billed_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.scanned_bytes_billed_notifications, "major", []), var.notifications.major)
    runbook_url           = try(coalesce(var.scanned_bytes_billed_runbook_url, var.runbook_url), "")
    tip                   = var.scanned_bytes_billed_tip
    parameterized_subject = coalesce(var.message_subject, local.rule_subject)
    parameterized_body    = coalesce(var.message_body, local.rule_body)
  }

}

resource "signalfx_detector" "available_slots" {
  name = format("%s %s", local.detector_name_prefix, "GCP BigQuery available slots")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)

  program_text = <<-EOF
    from signalfx.detectors.aperiodic import conditions
    signal = data('slots/total_available', ${module.filtering.signalflow})${var.available_slots_aggregation_function}${var.available_slots_transformation_function}.publish('signal')
    ON_Condition_CRIT = conditions.generic_condition(signal, ${var.available_slots_threshold_critical}, ${var.available_slots_threshold_critical}, 'above', lasting('${var.available_slots_aperiodic_duration}', ${var.available_slots_aperiodic_percentage}), 'observed')
    ON_Condition_MAJOR = conditions.generic_condition(signal, ${var.available_slots_threshold_major}, ${var.available_slots_threshold_critical}, 'within_range', lasting('${var.available_slots_aperiodic_duration}', ${var.available_slots_aperiodic_percentage}), 'observed', strict_2=False)
    detect(ON_Condition_CRIT, off=when(signal is None, '${var.available_slots_clear_duration}')).publish('CRIT')
    detect(ON_Condition_MAJOR, off=when(signal is None, '${var.available_slots_clear_duration}')).publish('MAJOR')
EOF

  rule {
    description           = "are too low < ${var.available_slots_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.available_slots_disabled_critical, var.available_slots_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.available_slots_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.available_slots_runbook_url, var.runbook_url), "")
    tip                   = var.available_slots_tip
    parameterized_subject = coalesce(var.message_subject, local.rule_subject)
    parameterized_body    = coalesce(var.message_body, local.rule_body)
  }

  rule {
    description           = "are too low < ${var.available_slots_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.available_slots_disabled_major, var.available_slots_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.available_slots_notifications, "major", []), var.notifications.major)
    runbook_url           = try(coalesce(var.available_slots_runbook_url, var.runbook_url), "")
    tip                   = var.available_slots_tip
    parameterized_subject = coalesce(var.message_subject, local.rule_subject)
    parameterized_body    = coalesce(var.message_body, local.rule_body)
  }

}

resource "signalfx_detector" "stored_bytes" {
  name = format("%s %s", local.detector_name_prefix, "GCP BigQuery stored bytes")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)

  program_text = <<-EOF
    from signalfx.detectors.aperiodic import conditions
    signal = data('storage/stored_bytes', ${module.filtering.signalflow})${var.stored_bytes_aggregation_function}${var.stored_bytes_transformation_function}.publish('signal')
    ON_Condition_CRIT = conditions.generic_condition(signal, ${var.stored_bytes_threshold_critical}, ${var.stored_bytes_threshold_critical}, 'above', lasting('${var.stored_bytes_aperiodic_duration}', ${var.stored_bytes_aperiodic_percentage}), 'observed')
    ON_Condition_MAJOR = conditions.generic_condition(signal, ${var.stored_bytes_threshold_major}, ${var.stored_bytes_threshold_critical}, 'within_range', lasting('${var.stored_bytes_aperiodic_duration}', ${var.stored_bytes_aperiodic_percentage}), 'observed', strict_2=False)
    detect(ON_Condition_CRIT, off=when(signal is None, '${var.stored_bytes_clear_duration}')).publish('CRIT')
    detect(ON_Condition_MAJOR, off=when(signal is None, '${var.stored_bytes_clear_duration}')).publish('MAJOR')
EOF

  rule {
    description           = "are too high > ${var.stored_bytes_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.stored_bytes_disabled_critical, var.stored_bytes_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.stored_bytes_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.stored_bytes_runbook_url, var.runbook_url), "")
    tip                   = var.stored_bytes_tip
    parameterized_subject = coalesce(var.message_subject, local.rule_subject)
    parameterized_body    = coalesce(var.message_body, local.rule_body)
  }

  rule {
    description           = "are too high > ${var.stored_bytes_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.stored_bytes_disabled_major, var.stored_bytes_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.stored_bytes_notifications, "major", []), var.notifications.major)
    runbook_url           = try(coalesce(var.stored_bytes_runbook_url, var.runbook_url), "")
    tip                   = var.stored_bytes_tip
    parameterized_subject = coalesce(var.message_subject, local.rule_subject)
    parameterized_body    = coalesce(var.message_body, local.rule_body)
  }

}

resource "signalfx_detector" "table_count" {
  name = format("%s %s", local.detector_name_prefix, "GCP BigQuery table count")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)

  program_text = <<-EOF
    from signalfx.detectors.aperiodic import conditions
    signal = data('storage/table_count', ${module.filtering.signalflow})${var.table_count_aggregation_function}${var.table_count_transformation_function}.publish('signal')
    ON_Condition_CRIT = conditions.generic_condition(signal, ${var.table_count_threshold_critical}, ${var.table_count_threshold_critical}, 'above', lasting('${var.table_count_aperiodic_duration}', ${var.table_count_aperiodic_percentage}), 'observed')
    ON_Condition_MAJOR = conditions.generic_condition(signal, ${var.table_count_threshold_major}, ${var.table_count_threshold_critical}, 'within_range', lasting('${var.table_count_aperiodic_duration}', ${var.table_count_aperiodic_percentage}), 'observed', strict_2=False)
    detect(ON_Condition_CRIT, off=when(signal is None, '${var.table_count_clear_duration}')).publish('CRIT')
    detect(ON_Condition_MAJOR, off=when(signal is None, '${var.table_count_clear_duration}')).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.table_count_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.table_count_disabled_critical, var.table_count_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.table_count_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.table_count_runbook_url, var.runbook_url), "")
    tip                   = var.table_count_tip
    parameterized_subject = coalesce(var.message_subject, local.rule_subject)
    parameterized_body    = coalesce(var.message_body, local.rule_body)
  }

  rule {
    description           = "is too high > ${var.table_count_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.table_count_disabled_major, var.table_count_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.table_count_notifications, "major", []), var.notifications.major)
    runbook_url           = try(coalesce(var.table_count_runbook_url, var.runbook_url), "")
    tip                   = var.table_count_tip
    parameterized_subject = coalesce(var.message_subject, local.rule_subject)
    parameterized_body    = coalesce(var.message_body, local.rule_body)
  }

}

resource "signalfx_detector" "uploaded_bytes" {
  name = format("%s %s", local.detector_name_prefix, "GCP BigQuery uploaded bytes")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)

  program_text = <<-EOF
    from signalfx.detectors.aperiodic import conditions
    signal = data('storage/uploaded_bytes', ${module.filtering.signalflow})${var.uploaded_bytes_aggregation_function}${var.uploaded_bytes_transformation_function}.publish('signal')
    ON_Condition_CRIT = conditions.generic_condition(signal, ${var.uploaded_bytes_threshold_critical}, ${var.uploaded_bytes_threshold_critical}, 'above', lasting('${var.uploaded_bytes_aperiodic_duration}', ${var.uploaded_bytes_aperiodic_percentage}), 'observed')
    ON_Condition_MAJOR = conditions.generic_condition(signal, ${var.uploaded_bytes_threshold_major}, ${var.uploaded_bytes_threshold_critical}, 'within_range', lasting('${var.uploaded_bytes_aperiodic_duration}', ${var.uploaded_bytes_aperiodic_percentage}), 'observed', strict_2=False)
    detect(ON_Condition_CRIT, off=when(signal is None, '${var.uploaded_bytes_clear_duration}')).publish('CRIT')
    detect(ON_Condition_MAJOR, off=when(signal is None, '${var.uploaded_bytes_clear_duration}')).publish('MAJOR')
EOF

  rule {
    description           = "are too high > ${var.uploaded_bytes_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.uploaded_bytes_disabled_critical, var.uploaded_bytes_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.uploaded_bytes_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.uploaded_bytes_runbook_url, var.runbook_url), "")
    tip                   = var.uploaded_bytes_tip
    parameterized_subject = coalesce(var.message_subject, local.rule_subject)
    parameterized_body    = coalesce(var.message_body, local.rule_body)
  }

  rule {
    description           = "are too high > ${var.uploaded_bytes_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.uploaded_bytes_disabled_major, var.uploaded_bytes_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.uploaded_bytes_notifications, "major", []), var.notifications.major)
    runbook_url           = try(coalesce(var.uploaded_bytes_runbook_url, var.runbook_url), "")
    tip                   = var.uploaded_bytes_tip
    parameterized_subject = coalesce(var.message_subject, local.rule_subject)
    parameterized_body    = coalesce(var.message_body, local.rule_body)
  }

}

resource "signalfx_detector" "uploaded_bytes_billed" {
  name = format("%s %s", local.detector_name_prefix, "GCP BigQuery uploaded bytes billed")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)

  program_text = <<-EOF
    from signalfx.detectors.aperiodic import conditions
    signal = data('storage/uploaded_bytes_billed', ${module.filtering.signalflow})${var.uploaded_bytes_billed_aggregation_function}${var.uploaded_bytes_billed_transformation_function}.publish('signal')
    ON_Condition_CRIT = conditions.generic_condition(signal, ${var.uploaded_bytes_billed_threshold_critical}, ${var.uploaded_bytes_billed_threshold_critical}, 'above', lasting('${var.uploaded_bytes_billed_aperiodic_duration}', ${var.uploaded_bytes_billed_aperiodic_percentage}), 'observed')
    ON_Condition_MAJOR = conditions.generic_condition(signal, ${var.uploaded_bytes_billed_threshold_major}, ${var.uploaded_bytes_billed_threshold_critical}, 'within_range', lasting('${var.uploaded_bytes_billed_aperiodic_duration}', ${var.uploaded_bytes_billed_aperiodic_percentage}), 'observed', strict_2=False)
    detect(ON_Condition_CRIT, off=when(signal is None, '${var.uploaded_bytes_billed_clear_duration}')).publish('CRIT')
    detect(ON_Condition_MAJOR, off=when(signal is None, '${var.uploaded_bytes_billed_clear_duration}')).publish('MAJOR')
EOF

  rule {
    description           = "are too high > ${var.uploaded_bytes_billed_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.uploaded_bytes_billed_disabled_critical, var.uploaded_bytes_billed_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.uploaded_bytes_billed_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.uploaded_bytes_billed_runbook_url, var.runbook_url), "")
    tip                   = var.uploaded_bytes_billed_tip
    parameterized_subject = coalesce(var.message_subject, local.rule_subject)
    parameterized_body    = coalesce(var.message_body, local.rule_body)
  }

  rule {
    description           = "are too high > ${var.uploaded_bytes_billed_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.uploaded_bytes_billed_disabled_major, var.uploaded_bytes_billed_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.uploaded_bytes_billed_notifications, "major", []), var.notifications.major)
    runbook_url           = try(coalesce(var.uploaded_bytes_billed_runbook_url, var.runbook_url), "")
    tip                   = var.uploaded_bytes_billed_tip
    parameterized_subject = coalesce(var.message_subject, local.rule_subject)
    parameterized_body    = coalesce(var.message_body, local.rule_body)
  }

}
