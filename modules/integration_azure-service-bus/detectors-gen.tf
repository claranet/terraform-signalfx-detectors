resource "signalfx_detector" "deadlettered_messages" {
  name = format("%s %s", local.detector_name_prefix, "Azure Service Bus deadlettered messages count")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    base_filtering = filter('resource_type', 'Microsoft.ServiceBus/namespaces') and filter('primary_aggregation_type', 'true')
    signal = data('DeadletteredMessages', filter=base_filtering and ${module.filtering.signalflow})${var.deadlettered_messages_aggregation_function}${var.deadlettered_messages_transformation_function}.publish('signal')
    detect(when(signal > ${var.deadlettered_messages_threshold_critical}, lasting=%{if var.deadlettered_messages_lasting_duration_critical == null}None%{else}'${var.deadlettered_messages_lasting_duration_critical}'%{endif}, at_least=${var.deadlettered_messages_at_least_percentage_critical})).publish('CRIT')
    detect(when(signal > ${var.deadlettered_messages_threshold_major}, lasting=%{if var.deadlettered_messages_lasting_duration_major == null}None%{else}'${var.deadlettered_messages_lasting_duration_major}'%{endif}, at_least=${var.deadlettered_messages_at_least_percentage_major}) and (not when(signal > ${var.deadlettered_messages_threshold_critical}, lasting=%{if var.deadlettered_messages_lasting_duration_critical == null}None%{else}'${var.deadlettered_messages_lasting_duration_critical}'%{endif}, at_least=${var.deadlettered_messages_at_least_percentage_critical}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.deadlettered_messages_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.deadlettered_messages_disabled_critical, var.deadlettered_messages_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.deadlettered_messages_notifications, "critical", []), var.notifications.critical)
    runbook_url           = try(coalesce(var.deadlettered_messages_runbook_url, var.runbook_url), "")
    tip                   = var.deadlettered_messages_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.deadlettered_messages_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.deadlettered_messages_disabled_major, var.deadlettered_messages_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.deadlettered_messages_notifications, "major", []), var.notifications.major)
    runbook_url           = try(coalesce(var.deadlettered_messages_runbook_url, var.runbook_url), "")
    tip                   = var.deadlettered_messages_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.deadlettered_messages_max_delay
}

