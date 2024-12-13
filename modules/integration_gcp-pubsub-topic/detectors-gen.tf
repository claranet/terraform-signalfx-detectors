resource "signalfx_detector" "sending_operations" {
  name = format("%s %s", local.detector_name_prefix, "GCP Pub/Sub Topic sending messages operations")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    base_filtering = filter('monitored_resource', 'pubsub_topic') and (not filter('topic_id', 'container-analysis-occurrences*', 'container-analysis-notes*', 'cloud-builds', 'gcr'))
    signal = data('topic/send_message_operation_count', filter=base_filtering and ${module.filtering.signalflow}, rollup='sum', extrapolation='zero')${var.sending_operations_aggregation_function}${var.sending_operations_transformation_function}.publish('signal')
    detect(when(signal < ${var.sending_operations_threshold_major}%{if var.sending_operations_lasting_duration_major != null}, lasting='${var.sending_operations_lasting_duration_major}', at_least=${var.sending_operations_at_least_percentage_major}%{endif})).publish('MAJOR')
EOF

  rule {
    description           = "is too low < ${var.sending_operations_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.sending_operations_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.sending_operations_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.sending_operations_runbook_url, var.runbook_url), "")
    tip                   = var.sending_operations_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.sending_operations_max_delay
}

resource "signalfx_detector" "unavailable_sending_operations" {
  name = format("%s %s", local.detector_name_prefix, "GCP Pub/Sub Topic sending unavailable messages")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    base_filtering = filter('monitored_resource', 'pubsub_topic') and (not filter('topic_id', 'container-analysis-occurrences*', 'container-analysis-notes*', 'cloud-builds', 'gcr'))
    signal = data('topic/send_message_operation_count', filter=base_filtering and ${module.filtering.signalflow}, rollup='sum', extrapolation='zero')${var.unavailable_sending_operations_aggregation_function}${var.unavailable_sending_operations_transformation_function}.publish('signal')
    detect(when(signal > ${var.unavailable_sending_operations_threshold_critical}%{if var.unavailable_sending_operations_lasting_duration_critical != null}, lasting='${var.unavailable_sending_operations_lasting_duration_critical}', at_least=${var.unavailable_sending_operations_at_least_percentage_critical}%{endif})).publish('CRIT')
    detect(when(signal > ${var.unavailable_sending_operations_threshold_major}%{if var.unavailable_sending_operations_lasting_duration_major != null}, lasting='${var.unavailable_sending_operations_lasting_duration_major}', at_least=${var.unavailable_sending_operations_at_least_percentage_major}%{endif}) and (not when(signal > ${var.unavailable_sending_operations_threshold_critical}%{if var.unavailable_sending_operations_lasting_duration_critical != null}, lasting='${var.unavailable_sending_operations_lasting_duration_critical}', at_least=${var.unavailable_sending_operations_at_least_percentage_critical}%{endif}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.unavailable_sending_operations_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.unavailable_sending_operations_disabled_critical, var.unavailable_sending_operations_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.unavailable_sending_operations_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.unavailable_sending_operations_runbook_url, var.runbook_url), "")
    tip                   = var.unavailable_sending_operations_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.unavailable_sending_operations_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.unavailable_sending_operations_disabled_major, var.unavailable_sending_operations_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.unavailable_sending_operations_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.unavailable_sending_operations_runbook_url, var.runbook_url), "")
    tip                   = var.unavailable_sending_operations_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.unavailable_sending_operations_max_delay
}

resource "signalfx_detector" "unavailable_sending_operations_ratio" {
  name = format("%s %s", local.detector_name_prefix, "GCP Pub/Sub Topic sending unavailable messages ratio")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    A = data('topic/send_message_operation_count', filter=filter('monitored_resource', 'pubsub_topic') and filter('response_code', 'unavailable') and (not filter('topic_id', 'container-analysis-occurrences*', 'container-analysis-notes*', 'cloud-builds', 'gcr')) and ${module.filtering.signalflow}, rollup='sum', extrapolation='zero')${var.unavailable_sending_operations_ratio_aggregation_function}${var.unavailable_sending_operations_ratio_transformation_function}
    B = data('topic/send_message_operation_count', filter=filter('monitored_resource', 'pubsub_topic') and ${module.filtering.signalflow}, rollup='sum', extrapolation='zero')${var.unavailable_sending_operations_ratio_aggregation_function}${var.unavailable_sending_operations_ratio_transformation_function}
    signal = (A/B).scale(100).fill(value=0).publish('signal')
    detect(when(signal > ${var.unavailable_sending_operations_ratio_threshold_critical}%{if var.unavailable_sending_operations_ratio_lasting_duration_critical != null}, lasting='${var.unavailable_sending_operations_ratio_lasting_duration_critical}', at_least=${var.unavailable_sending_operations_ratio_at_least_percentage_critical}%{endif})).publish('CRIT')
    detect(when(signal > ${var.unavailable_sending_operations_ratio_threshold_major}%{if var.unavailable_sending_operations_ratio_lasting_duration_major != null}, lasting='${var.unavailable_sending_operations_ratio_lasting_duration_major}', at_least=${var.unavailable_sending_operations_ratio_at_least_percentage_major}%{endif}) and (not when(signal > ${var.unavailable_sending_operations_ratio_threshold_critical}%{if var.unavailable_sending_operations_ratio_lasting_duration_critical != null}, lasting='${var.unavailable_sending_operations_ratio_lasting_duration_critical}', at_least=${var.unavailable_sending_operations_ratio_at_least_percentage_critical}%{endif}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.unavailable_sending_operations_ratio_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.unavailable_sending_operations_ratio_disabled_critical, var.unavailable_sending_operations_ratio_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.unavailable_sending_operations_ratio_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.unavailable_sending_operations_ratio_runbook_url, var.runbook_url), "")
    tip                   = var.unavailable_sending_operations_ratio_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.unavailable_sending_operations_ratio_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.unavailable_sending_operations_ratio_disabled_major, var.unavailable_sending_operations_ratio_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.unavailable_sending_operations_ratio_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.unavailable_sending_operations_ratio_runbook_url, var.runbook_url), "")
    tip                   = var.unavailable_sending_operations_ratio_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.unavailable_sending_operations_ratio_max_delay
}

