resource "signalfx_detector" "activity_error_rate" {
  name = format("%s %s", local.detector_name_prefix, "Azure DataFactory activity error rate")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  viz_options {
    label        = "signal"
    value_suffix = "%"
  }

  program_text = <<-EOF
    base_filtering = filter('resource_type', 'Microsoft.DataFactory/factories') and filter('primary_aggregation_type', 'true')
    adf_activity_succeeded_run = data('ActivitySucceededRuns', filter=base_filtering and ${module.filtering.signalflow})${var.activity_error_rate_aggregation_function}${var.activity_error_rate_transformation_function}
    adf_activity_failed_run = data('ActivityFailedRuns', filter=base_filtering and ${module.filtering.signalflow})${var.activity_error_rate_aggregation_function}${var.activity_error_rate_transformation_function}
    signal = (adf_activity_failed_run/(adf_activity_succeeded_run+adf_activity_failed_run)).scale(100).fill(0).publish('signal')
    detect(when(signal > ${var.activity_error_rate_threshold_critical}, lasting=%{if var.activity_error_rate_lasting_duration_critical == null}None%{else}'${var.activity_error_rate_lasting_duration_critical}'%{endif}, at_least=${var.activity_error_rate_at_least_percentage_critical})).publish('CRIT')
    detect(when(signal > ${var.activity_error_rate_threshold_major}, lasting=%{if var.activity_error_rate_lasting_duration_major == null}None%{else}'${var.activity_error_rate_lasting_duration_major}'%{endif}, at_least=${var.activity_error_rate_at_least_percentage_major}) and (not when(signal > ${var.activity_error_rate_threshold_critical}, lasting=%{if var.activity_error_rate_lasting_duration_critical == null}None%{else}'${var.activity_error_rate_lasting_duration_critical}'%{endif}, at_least=${var.activity_error_rate_at_least_percentage_critical}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.activity_error_rate_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.activity_error_rate_disabled_critical, var.activity_error_rate_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.activity_error_rate_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.activity_error_rate_runbook_url, var.runbook_url), "")
    tip                   = var.activity_error_rate_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.activity_error_rate_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.activity_error_rate_disabled_major, var.activity_error_rate_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.activity_error_rate_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.activity_error_rate_runbook_url, var.runbook_url), "")
    tip                   = var.activity_error_rate_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.activity_error_rate_max_delay
}

resource "signalfx_detector" "pipeline_error_rate" {
  name = format("%s %s", local.detector_name_prefix, "Azure DataFactory pipeline error rate")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  viz_options {
    label        = "signal"
    value_suffix = "%"
  }

  program_text = <<-EOF
    base_filtering = filter('resource_type', 'Microsoft.DataFactory/factories') and filter('primary_aggregation_type', 'true')
    adf_pipeline_succeeded_run = data('PipelineSucceededRuns', filter=base_filtering and ${module.filtering.signalflow})${var.pipeline_error_rate_aggregation_function}${var.pipeline_error_rate_transformation_function}
    adf_pipeline_failed_run = data('PipelineFailedRuns', filter=base_filtering and ${module.filtering.signalflow})${var.pipeline_error_rate_aggregation_function}${var.pipeline_error_rate_transformation_function}
    signal = (adf_pipeline_failed_run/(adf_pipeline_succeeded_run+adf_pipeline_failed_run)).scale(100).fill(0).publish('signal')
    detect(when(signal > ${var.pipeline_error_rate_threshold_critical}, lasting=%{if var.pipeline_error_rate_lasting_duration_critical == null}None%{else}'${var.pipeline_error_rate_lasting_duration_critical}'%{endif}, at_least=${var.pipeline_error_rate_at_least_percentage_critical})).publish('CRIT')
    detect(when(signal > ${var.pipeline_error_rate_threshold_major}, lasting=%{if var.pipeline_error_rate_lasting_duration_major == null}None%{else}'${var.pipeline_error_rate_lasting_duration_major}'%{endif}, at_least=${var.pipeline_error_rate_at_least_percentage_major}) and (not when(signal > ${var.pipeline_error_rate_threshold_critical}, lasting=%{if var.pipeline_error_rate_lasting_duration_critical == null}None%{else}'${var.pipeline_error_rate_lasting_duration_critical}'%{endif}, at_least=${var.pipeline_error_rate_at_least_percentage_critical}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.pipeline_error_rate_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.pipeline_error_rate_disabled_critical, var.pipeline_error_rate_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.pipeline_error_rate_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.pipeline_error_rate_runbook_url, var.runbook_url), "")
    tip                   = var.pipeline_error_rate_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.pipeline_error_rate_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.pipeline_error_rate_disabled_major, var.pipeline_error_rate_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.pipeline_error_rate_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.pipeline_error_rate_runbook_url, var.runbook_url), "")
    tip                   = var.pipeline_error_rate_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.pipeline_error_rate_max_delay
}

resource "signalfx_detector" "trigger_error_rate" {
  name = format("%s %s", local.detector_name_prefix, "Azure DataFactory trigger error rate")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    base_filtering = filter('resource_type', 'Microsoft.DataFactory/factories') and filter('primary_aggregation_type', 'true')
    adf_trigger_succeeded_run = data('TriggerSucceededRuns', filter=base_filtering and ${module.filtering.signalflow})${var.trigger_error_rate_aggregation_function}${var.trigger_error_rate_transformation_function}
    adf_trigger_failed_run = data('TriggerFailedRuns', filter=base_filtering and ${module.filtering.signalflow})${var.trigger_error_rate_aggregation_function}${var.trigger_error_rate_transformation_function}
    signal = (adf_trigger_failed_run/(adf_trigger_succeeded_run+adf_trigger_failed_run)).scale(100).fill(0).publish('signal')
    detect(when(signal > ${var.trigger_error_rate_threshold_critical}, lasting=%{if var.trigger_error_rate_lasting_duration_critical == null}None%{else}'${var.trigger_error_rate_lasting_duration_critical}'%{endif}, at_least=${var.trigger_error_rate_at_least_percentage_critical})).publish('CRIT')
    detect(when(signal > ${var.trigger_error_rate_threshold_major}, lasting=%{if var.trigger_error_rate_lasting_duration_major == null}None%{else}'${var.trigger_error_rate_lasting_duration_major}'%{endif}, at_least=${var.trigger_error_rate_at_least_percentage_major}) and (not when(signal > ${var.trigger_error_rate_threshold_critical}, lasting=%{if var.trigger_error_rate_lasting_duration_critical == null}None%{else}'${var.trigger_error_rate_lasting_duration_critical}'%{endif}, at_least=${var.trigger_error_rate_at_least_percentage_critical}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.trigger_error_rate_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.trigger_error_rate_disabled_critical, var.trigger_error_rate_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.trigger_error_rate_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.trigger_error_rate_runbook_url, var.runbook_url), "")
    tip                   = var.trigger_error_rate_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.trigger_error_rate_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.trigger_error_rate_disabled_major, var.trigger_error_rate_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.trigger_error_rate_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.trigger_error_rate_runbook_url, var.runbook_url), "")
    tip                   = var.trigger_error_rate_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.trigger_error_rate_max_delay
}

resource "signalfx_detector" "available_memory" {
  name = format("%s %s", local.detector_name_prefix, "Azure DataFactory available memory")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  viz_options {
    label      = "signal"
    value_unit = "Mebibyte"
  }

  program_text = <<-EOF
    base_filtering = filter('resource_type', 'Microsoft.DataFactory/factories') and filter('primary_aggregation_type', 'true')
    memory = data('IntegrationRuntimeAvailableMemory', filter=base_filtering and ${module.filtering.signalflow})${var.available_memory_aggregation_function}${var.available_memory_transformation_function}
    signal = memory.scale(1/1024**2).publish('signal')
    detect(when(signal < ${var.available_memory_threshold_critical}, lasting=%{if var.available_memory_lasting_duration_critical == null}None%{else}'${var.available_memory_lasting_duration_critical}'%{endif}, at_least=${var.available_memory_at_least_percentage_critical})).publish('CRIT')
    detect(when(signal < ${var.available_memory_threshold_major}, lasting=%{if var.available_memory_lasting_duration_major == null}None%{else}'${var.available_memory_lasting_duration_major}'%{endif}, at_least=${var.available_memory_at_least_percentage_major}) and (not when(signal < ${var.available_memory_threshold_critical}, lasting=%{if var.available_memory_lasting_duration_critical == null}None%{else}'${var.available_memory_lasting_duration_critical}'%{endif}, at_least=${var.available_memory_at_least_percentage_critical}))).publish('MAJOR')
EOF

  rule {
    description           = "is too low < ${var.available_memory_threshold_critical}Mebibyte"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.available_memory_disabled_critical, var.available_memory_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.available_memory_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.available_memory_runbook_url, var.runbook_url), "")
    tip                   = var.available_memory_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too low < ${var.available_memory_threshold_major}Mebibyte"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.available_memory_disabled_major, var.available_memory_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.available_memory_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.available_memory_runbook_url, var.runbook_url), "")
    tip                   = var.available_memory_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.available_memory_max_delay
}

resource "signalfx_detector" "cpu_percentage" {
  name = format("%s %s", local.detector_name_prefix, "Azure DataFactory cpu percentage")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  viz_options {
    label        = "signal"
    value_suffix = "%"
  }

  program_text = <<-EOF
    base_filtering = filter('resource_type', 'Microsoft.DataFactory/factories') and filter('primary_aggregation_type', 'true')
    signal = data('IntegrationRuntimeCpuPercentage', filter=base_filtering and ${module.filtering.signalflow})${var.cpu_percentage_aggregation_function}${var.cpu_percentage_transformation_function}.publish('signal')
    detect(when(signal > ${var.cpu_percentage_threshold_critical}, lasting=%{if var.cpu_percentage_lasting_duration_critical == null}None%{else}'${var.cpu_percentage_lasting_duration_critical}'%{endif}, at_least=${var.cpu_percentage_at_least_percentage_critical})).publish('CRIT')
    detect(when(signal > ${var.cpu_percentage_threshold_major}, lasting=%{if var.cpu_percentage_lasting_duration_major == null}None%{else}'${var.cpu_percentage_lasting_duration_major}'%{endif}, at_least=${var.cpu_percentage_at_least_percentage_major}) and (not when(signal > ${var.cpu_percentage_threshold_critical}, lasting=%{if var.cpu_percentage_lasting_duration_critical == null}None%{else}'${var.cpu_percentage_lasting_duration_critical}'%{endif}, at_least=${var.cpu_percentage_at_least_percentage_critical}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.cpu_percentage_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.cpu_percentage_disabled_critical, var.cpu_percentage_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.cpu_percentage_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.cpu_percentage_runbook_url, var.runbook_url), "")
    tip                   = var.cpu_percentage_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.cpu_percentage_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.cpu_percentage_disabled_major, var.cpu_percentage_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.cpu_percentage_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.cpu_percentage_runbook_url, var.runbook_url), "")
    tip                   = var.cpu_percentage_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.cpu_percentage_max_delay
}

