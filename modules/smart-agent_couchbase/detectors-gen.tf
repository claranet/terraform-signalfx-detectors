resource "signalfx_detector" "memory_used" {
  name = format("%s %s", local.detector_name_prefix, "Couchbase memory used")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  viz_options {
    label        = "signal"
    value_suffix = "%"
  }

  program_text = <<-EOF
    A = data('gauge.bucket.op.mem_used', filter=${module.filtering.signalflow})${var.memory_used_aggregation_function}${var.memory_used_transformation_function}
    B = data('gauge.bucket.op.ep_mem_high_wat', filter=${module.filtering.signalflow})${var.memory_used_aggregation_function}${var.memory_used_transformation_function}
    signal = (A/B).scale(100).fill(0).publish('signal')
    detect(when(signal > ${var.memory_used_threshold_critical}, lasting=${var.memory_used_lasting_duration_critical == null ? "None" : format("'%s'", var.memory_used_lasting_duration_critical)}, at_least=${var.memory_used_at_least_percentage_critical})).publish('CRIT')
    detect(when(signal > ${var.memory_used_threshold_major}, lasting=${var.memory_used_lasting_duration_major == null ? "None" : format("'%s'", var.memory_used_lasting_duration_major)}, at_least=${var.memory_used_at_least_percentage_major}) and (not when(signal > ${var.memory_used_threshold_critical}, lasting=${var.memory_used_lasting_duration_critical == null ? "None" : format("'%s'", var.memory_used_lasting_duration_critical)}, at_least=${var.memory_used_at_least_percentage_critical}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.memory_used_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.memory_used_disabled_critical, var.memory_used_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.memory_used_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.memory_used_runbook_url, var.runbook_url), "")
    tip                   = var.memory_used_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.memory_used_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.memory_used_disabled_major, var.memory_used_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.memory_used_notifications, "major", []), var.notifications.major)
    runbook_url           = try(coalesce(var.memory_used_runbook_url, var.runbook_url), "")
    tip                   = var.memory_used_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }
}

resource "signalfx_detector" "out_of_memory_errors" {
  name = format("%s %s", local.detector_name_prefix, "Couchbase out of memory errors")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    signal = data('gauge.bucket.op.ep_oom_errors', filter=${module.filtering.signalflow})${var.out_of_memory_errors_aggregation_function}${var.out_of_memory_errors_transformation_function}.publish('signal')
    detect(when(signal > ${var.out_of_memory_errors_threshold_critical}, lasting=${var.out_of_memory_errors_lasting_duration_critical == null ? "None" : format("'%s'", var.out_of_memory_errors_lasting_duration_critical)}, at_least=${var.out_of_memory_errors_at_least_percentage_critical})).publish('CRIT')
EOF

  rule {
    description           = "Hard out of memory errors > ${var.out_of_memory_errors_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.out_of_memory_errors_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.out_of_memory_errors_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.out_of_memory_errors_runbook_url, var.runbook_url), "")
    tip                   = var.out_of_memory_errors_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }
}

resource "signalfx_detector" "disk_write_queue" {
  name = format("%s %s", local.detector_name_prefix, "Couchbase disk write queue")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    signal = data('gauge.bucket.op.disk_write_queue', filter=${module.filtering.signalflow})${var.disk_write_queue_aggregation_function}${var.disk_write_queue_transformation_function}.publish('signal')
    detect(when(signal > ${var.disk_write_queue_threshold_critical}, lasting=${var.disk_write_queue_lasting_duration_critical == null ? "None" : format("'%s'", var.disk_write_queue_lasting_duration_critical)}, at_least=${var.disk_write_queue_at_least_percentage_critical})).publish('CRIT')
    detect(when(signal > ${var.disk_write_queue_threshold_major}, lasting=${var.disk_write_queue_lasting_duration_major == null ? "None" : format("'%s'", var.disk_write_queue_lasting_duration_major)}, at_least=${var.disk_write_queue_at_least_percentage_major}) and (not when(signal > ${var.disk_write_queue_threshold_critical}, lasting=${var.disk_write_queue_lasting_duration_critical == null ? "None" : format("'%s'", var.disk_write_queue_lasting_duration_critical)}, at_least=${var.disk_write_queue_at_least_percentage_critical}))).publish('MAJOR')
EOF

  rule {
    description           = "Disk write queue is very big > ${var.disk_write_queue_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.disk_write_queue_disabled_critical, var.disk_write_queue_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.disk_write_queue_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.disk_write_queue_runbook_url, var.runbook_url), "")
    tip                   = var.disk_write_queue_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "Disk write queue is big > ${var.disk_write_queue_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.disk_write_queue_disabled_major, var.disk_write_queue_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.disk_write_queue_notifications, "major", []), var.notifications.major)
    runbook_url           = try(coalesce(var.disk_write_queue_runbook_url, var.runbook_url), "")
    tip                   = var.disk_write_queue_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }
}

