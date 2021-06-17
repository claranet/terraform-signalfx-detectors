resource "signalfx_detector" "heartbeat" {
  name = format("%s %s", local.detector_name_prefix, "Cassandra heartbeat")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)

  max_delay = 900

  program_text = <<-EOF
    from signalfx.detectors.not_reporting import not_reporting
    signal = data('counter.cassandra.Storage.Load.Count', filter=${local.not_running_vm_filters} and ${module.filtering.signalflow})${var.heartbeat_aggregation_function}.publish('signal')
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
    parameterized_subject = local.rule_subject_novalue
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "read_p99_latency" {
  name = format("%s %s", local.detector_name_prefix, "Cassandra read latency 99th percentile")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)

  program_text = <<-EOF
    signal = data('gauge.cassandra.ClientRequest.Read.Latency.99thPercentile', filter=${module.filtering.signalflow}).scale(0.001)${var.read_p99_latency_aggregation_function}${var.read_p99_latency_transformation_function}.publish('signal')
    detect(when(signal > ${var.read_p99_latency_threshold_critical})).publish('CRIT')
    detect(when(signal > ${var.read_p99_latency_threshold_major}) and when(signal <= ${var.read_p99_latency_threshold_critical})).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.read_p99_latency_threshold_critical}ms"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.read_p99_latency_disabled_critical, var.read_p99_latency_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.read_p99_latency_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.read_p99_latency_runbook_url, var.runbook_url), "")
    tip                   = var.read_p99_latency_tip
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "is too high > ${var.read_p99_latency_threshold_major}ms"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.read_p99_latency_disabled_major, var.read_p99_latency_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.read_p99_latency_notifications, "major", []), var.notifications.major)
    runbook_url           = try(coalesce(var.read_p99_latency_runbook_url, var.runbook_url), "")
    tip                   = var.read_p99_latency_tip
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "write_p99_latency" {
  name = format("%s %s", local.detector_name_prefix, "Cassandra write latency 99th percentile")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)

  program_text = <<-EOF
    signal = data('gauge.cassandra.ClientRequest.Write.Latency.99thPercentile', filter=${module.filtering.signalflow}).scale(0.001)${var.write_p99_latency_aggregation_function}${var.write_p99_latency_transformation_function}.publish('signal')
    detect(when(signal > ${var.write_p99_latency_threshold_critical})).publish('CRIT')
    detect(when(signal > ${var.write_p99_latency_threshold_major}) and when(signal <= ${var.write_p99_latency_threshold_critical})).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.write_p99_latency_threshold_critical}ms"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.write_p99_latency_disabled_critical, var.write_p99_latency_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.write_p99_latency_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.write_p99_latency_runbook_url, var.runbook_url), "")
    tip                   = var.write_p99_latency_tip
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "is too high > ${var.write_p99_latency_threshold_major}ms"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.write_p99_latency_disabled_major, var.write_p99_latency_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.write_p99_latency_notifications, "major", []), var.notifications.major)
    runbook_url           = try(coalesce(var.write_p99_latency_runbook_url, var.runbook_url), "")
    tip                   = var.write_p99_latency_tip
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "read_real_time_latency" {
  name = format("%s %s", local.detector_name_prefix, "Cassandra read latency real time")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)

  program_text = <<-EOF
    A = data('counter.cassandra.ClientRequest.Read.TotalLatency.Count', filter=${module.filtering.signalflow})${var.read_real_time_latency_aggregation_function}${var.read_real_time_latency_transformation_function}
    B = data('counter.cassandra.ClientRequest.Read.Latency.Count', filter=${module.filtering.signalflow})${var.read_real_time_latency_aggregation_function}${var.read_real_time_latency_transformation_function}
    signal = (A/B).fill(0).scale(0.001).publish('signal')
    detect(when(signal > ${var.read_real_time_latency_threshold_critical})).publish('CRIT')
    detect(when(signal > ${var.read_real_time_latency_threshold_major}) and when(signal <= ${var.read_real_time_latency_threshold_critical})).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.read_real_time_latency_threshold_critical}ms"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.read_real_time_latency_disabled_critical, var.read_real_time_latency_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.read_real_time_latency_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.read_real_time_latency_runbook_url, var.runbook_url), "")
    tip                   = var.read_real_time_latency_tip
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "is too high > ${var.read_real_time_latency_threshold_major}ms"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.read_real_time_latency_disabled_major, var.read_real_time_latency_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.read_real_time_latency_notifications, "major", []), var.notifications.major)
    runbook_url           = try(coalesce(var.read_real_time_latency_runbook_url, var.runbook_url), "")
    tip                   = var.read_real_time_latency_tip
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "write_real_time_latency" {
  name = format("%s %s", local.detector_name_prefix, "Cassandra write latency real time")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)

  program_text = <<-EOF
    A = data('counter.cassandra.ClientRequest.Write.TotalLatency.Count', filter=${module.filtering.signalflow})${var.write_real_time_latency_aggregation_function}${var.write_real_time_latency_transformation_function}
    B = data('counter.cassandra.ClientRequest.Write.Latency.Count', filter=${module.filtering.signalflow})${var.write_real_time_latency_aggregation_function}${var.write_real_time_latency_transformation_function}
    signal = (A/B).fill(0).scale(0.001).publish('signal')
    detect(when(signal > ${var.write_real_time_latency_threshold_critical})).publish('CRIT')
    detect(when(signal > ${var.write_real_time_latency_threshold_major}) and when(signal <= ${var.write_real_time_latency_threshold_critical})).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.write_real_time_latency_threshold_critical}ms"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.write_real_time_latency_disabled_critical, var.write_real_time_latency_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.write_real_time_latency_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.write_real_time_latency_runbook_url, var.runbook_url), "")
    tip                   = var.write_real_time_latency_tip
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "is too high > ${var.write_real_time_latency_threshold_major}ms"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.write_real_time_latency_disabled_major, var.write_real_time_latency_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.write_real_time_latency_notifications, "major", []), var.notifications.major)
    runbook_url           = try(coalesce(var.write_real_time_latency_runbook_url, var.runbook_url), "")
    tip                   = var.write_real_time_latency_tip
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "casread_p99_latency" {
  name = format("%s %s", local.detector_name_prefix, "Cassandra transactional read latency 99th percentile")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)

  program_text = <<-EOF
    signal = data('gauge.cassandra.ClientRequest.CASRead.Latency.99thPercentile', filter=${module.filtering.signalflow}).scale(0.001)${var.casread_p99_latency_aggregation_function}${var.casread_p99_latency_transformation_function}.publish('signal')
    detect(when(signal > ${var.casread_p99_latency_threshold_critical})).publish('CRIT')
    detect(when(signal > ${var.casread_p99_latency_threshold_major}) and when(signal <= ${var.casread_p99_latency_threshold_critical})).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.casread_p99_latency_threshold_critical}ms"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.casread_p99_latency_disabled_critical, var.casread_p99_latency_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.casread_p99_latency_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.casread_p99_latency_runbook_url, var.runbook_url), "")
    tip                   = var.casread_p99_latency_tip
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "is too high > ${var.casread_p99_latency_threshold_major}ms"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.casread_p99_latency_disabled_major, var.casread_p99_latency_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.casread_p99_latency_notifications, "major", []), var.notifications.major)
    runbook_url           = try(coalesce(var.casread_p99_latency_runbook_url, var.runbook_url), "")
    tip                   = var.casread_p99_latency_tip
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "caswrite_p99_latency" {
  name = format("%s %s", local.detector_name_prefix, "Cassandra transactional write latency 99th percentile")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)

  program_text = <<-EOF
    signal = data('gauge.cassandra.ClientRequest.CASWrite.Latency.99thPercentile', filter=${module.filtering.signalflow}).scale(0.001)${var.caswrite_p99_latency_aggregation_function}${var.caswrite_p99_latency_transformation_function}.publish('signal')
    detect(when(signal > ${var.caswrite_p99_latency_threshold_critical})).publish('CRIT')
    detect(when(signal > ${var.caswrite_p99_latency_threshold_major}) and when(signal <= ${var.caswrite_p99_latency_threshold_critical})).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.caswrite_p99_latency_threshold_critical}ms"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.caswrite_p99_latency_disabled_critical, var.caswrite_p99_latency_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.caswrite_p99_latency_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.caswrite_p99_latency_runbook_url, var.runbook_url), "")
    tip                   = var.caswrite_p99_latency_tip
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "is too high > ${var.caswrite_p99_latency_threshold_major}ms"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.caswrite_p99_latency_disabled_major, var.caswrite_p99_latency_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.caswrite_p99_latency_notifications, "major", []), var.notifications.major)
    runbook_url           = try(coalesce(var.caswrite_p99_latency_runbook_url, var.runbook_url), "")
    tip                   = var.caswrite_p99_latency_tip
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "casread_real_time_latency" {
  name = format("%s %s", local.detector_name_prefix, "Cassandra transactional read latency real time")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)

  program_text = <<-EOF
    A = data('counter.cassandra.ClientRequest.CASRead.TotalLatency.Count', filter=${module.filtering.signalflow})${var.casread_real_time_latency_aggregation_function}${var.casread_real_time_latency_transformation_function}
    B = data('counter.cassandra.ClientRequest.CASRead.Latency.Count', filter=${module.filtering.signalflow})${var.casread_real_time_latency_aggregation_function}${var.casread_real_time_latency_transformation_function}
    signal = (A/B).fill(0).scale(0.001).publish('signal')
    detect(when(signal > ${var.casread_real_time_latency_threshold_critical})).publish('CRIT')
    detect(when(signal > ${var.casread_real_time_latency_threshold_major}) and when(signal <= ${var.casread_real_time_latency_threshold_critical})).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.casread_real_time_latency_threshold_critical}ms"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.casread_real_time_latency_disabled_critical, var.casread_real_time_latency_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.casread_real_time_latency_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.casread_real_time_latency_runbook_url, var.runbook_url), "")
    tip                   = var.casread_real_time_latency_tip
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "is too high > ${var.casread_real_time_latency_threshold_major}ms"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.casread_real_time_latency_disabled_major, var.casread_real_time_latency_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.casread_real_time_latency_notifications, "major", []), var.notifications.major)
    runbook_url           = try(coalesce(var.casread_real_time_latency_runbook_url, var.runbook_url), "")
    tip                   = var.casread_real_time_latency_tip
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "caswrite_real_time_latency" {
  name = format("%s %s", local.detector_name_prefix, "Cassandra transactional write latency real time")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)

  program_text = <<-EOF
    A = data('counter.cassandra.ClientRequest.CASWrite.TotalLatency.Count', filter=${module.filtering.signalflow})${var.caswrite_real_time_latency_aggregation_function}${var.caswrite_real_time_latency_transformation_function}
    B = data('counter.cassandra.ClientRequest.CASWrite.Latency.Count', filter=${module.filtering.signalflow})${var.caswrite_real_time_latency_aggregation_function}${var.caswrite_real_time_latency_transformation_function}
    signal = (A/B).fill(0).scale(0.001).publish('signal')
    detect(when(signal > ${var.caswrite_real_time_latency_threshold_critical})).publish('CRIT')
    detect(when(signal > ${var.caswrite_real_time_latency_threshold_major}) and when(signal <= ${var.caswrite_real_time_latency_threshold_critical})).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.caswrite_real_time_latency_threshold_critical}ms"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.caswrite_real_time_latency_disabled_critical, var.caswrite_real_time_latency_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.caswrite_real_time_latency_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.caswrite_real_time_latency_runbook_url, var.runbook_url), "")
    tip                   = var.caswrite_real_time_latency_tip
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "is too high > ${var.caswrite_real_time_latency_threshold_major}ms"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.caswrite_real_time_latency_disabled_major, var.caswrite_real_time_latency_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.caswrite_real_time_latency_notifications, "major", []), var.notifications.major)
    runbook_url           = try(coalesce(var.caswrite_real_time_latency_runbook_url, var.runbook_url), "")
    tip                   = var.caswrite_real_time_latency_tip
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "storage_exceptions" {
  name = format("%s %s", local.detector_name_prefix, "Cassandra storage exceptions count")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)

  program_text = <<-EOF
    signal = data('counter.cassandra.Storage.Exceptions.Count', filter=${module.filtering.signalflow})${var.storage_exceptions_aggregation_function}${var.storage_exceptions_transformation_function}.publish('signal')
    detect(when(signal > ${var.storage_exceptions_threshold_major})).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.storage_exceptions_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.storage_exceptions_disabled_major, var.storage_exceptions_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.storage_exceptions_notifications, "major", []), var.notifications.major)
    runbook_url           = try(coalesce(var.storage_exceptions_runbook_url, var.runbook_url), "")
    tip                   = var.storage_exceptions_tip
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}
