resource "signalfx_detector" "sending_operations" {
  name = format("%s %s", local.detector_name_prefix, "GCP Pub/Sub Topic sending messages operations")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)

  program_text = <<-EOF
    reserved_topics = (not filter('topic_id', 'container-analysis-occurrences*', 'container-analysis-notes*', 'cloud-builds', 'gcr'))
    signal = data('topic/send_message_operation_count', filter=filter('monitored_resource', 'pubsub_topic') and reserved_topics and ${module.filter-tags.filter_custom}, extrapolation='zero', rollup='sum')${var.sending_operations_aggregation_function}${var.sending_operations_transformation_function}.publish('signal')
    detect(when(signal < ${var.sending_operations_threshold_major})).publish('MAJOR')
EOF

  rule {
    description           = "are too low < ${var.sending_operations_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.sending_operations_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.sending_operations_notifications, "major", []), var.notifications.major)
    runbook_url           = try(coalesce(var.sending_operations_runbook_url, var.runbook_url), "")
    tip                   = var.sending_operations_tip
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "unavailable_sending_operations" {
  name = format("%s %s", local.detector_name_prefix, "GCP Pub/Sub Topic sending unavailable messages")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)

  program_text = <<-EOF
    reserved_topics = (not filter('topic_id', 'container-analysis-occurrences*', 'container-analysis-notes*', 'cloud-builds', 'gcr'))
    signal = data('topic/send_message_operation_count', filter=filter('monitored_resource', 'pubsub_topic') and reserved_topics and ${module.filter-tags.filter_custom}, extrapolation='zero', rollup='sum')${var.unavailable_sending_operations_aggregation_function}${var.unavailable_sending_operations_transformation_function}.publish('signal')
    detect(when(signal > ${var.unavailable_sending_operations_threshold_critical})).publish('CRIT')
    detect(when(signal > ${var.unavailable_sending_operations_threshold_major}) and when(signal <= ${var.unavailable_sending_operations_threshold_critical})).publish('MAJOR')
EOF

  rule {
    description           = "are too high > ${var.unavailable_sending_operations_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.unavailable_sending_operations_disabled_critical, var.unavailable_sending_operations_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.unavailable_sending_operations_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.unavailable_sending_operations_runbook_url, var.runbook_url), "")
    tip                   = var.unavailable_sending_operations_tip
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "are too high > ${var.unavailable_sending_operations_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.unavailable_sending_operations_disabled_major, var.unavailable_sending_operations_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.unavailable_sending_operations_notifications, "major", []), var.notifications.major)
    runbook_url           = try(coalesce(var.unavailable_sending_operations_runbook_url, var.runbook_url), "")
    tip                   = var.unavailable_sending_operations_tip
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

resource "signalfx_detector" "unavailable_sending_operations_ratio" {
  name = format("%s %s", local.detector_name_prefix, "GCP Pub/Sub Topic sending unavailable messages ratio")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)

  program_text = <<-EOF
    reserved_topics = (not filter('topic_id', 'container-analysis-occurrences*', 'container-analysis-notes*', 'cloud-builds', 'gcr'))
    A = data('topic/send_message_operation_count', filter=filter('monitored_resource', 'pubsub_topic') and filter('response_code', 'unavailable') and reserved_topics and ${module.filter-tags.filter_custom}, extrapolation='zero', rollup='sum')${var.unavailable_sending_operations_ratio_aggregation_function}${var.unavailable_sending_operations_ratio_transformation_function}
    B = data('topic/send_message_operation_count', filter=filter('monitored_resource', 'pubsub_topic') and ${module.filter-tags.filter_custom}, extrapolation='zero', rollup='sum')${var.unavailable_sending_operations_ratio_aggregation_function}${var.unavailable_sending_operations_ratio_transformation_function}
    signal = (A/B).scale(100).fill(value=0).publish('signal')
    detect(when(signal > ${var.unavailable_sending_operations_ratio_threshold_critical})).publish('CRIT')
    detect(when(signal > ${var.unavailable_sending_operations_ratio_threshold_major}) and when(signal <= ${var.unavailable_sending_operations_ratio_threshold_critical})).publish('MAJOR')
EOF

  rule {
    description           = "is too high >= ${var.unavailable_sending_operations_ratio_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.unavailable_sending_operations_ratio_disabled_critical, var.unavailable_sending_operations_ratio_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.unavailable_sending_operations_ratio_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.unavailable_sending_operations_ratio_runbook_url, var.runbook_url), "")
    tip                   = var.unavailable_sending_operations_ratio_tip
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }

  rule {
    description           = "is too high >= ${var.unavailable_sending_operations_ratio_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.unavailable_sending_operations_ratio_disabled_major, var.unavailable_sending_operations_ratio_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.unavailable_sending_operations_ratio_notifications, "major", []), var.notifications.major)
    runbook_url           = try(coalesce(var.unavailable_sending_operations_ratio_runbook_url, var.runbook_url), "")
    tip                   = var.unavailable_sending_operations_ratio_tip
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

