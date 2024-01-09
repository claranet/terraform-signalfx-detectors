resource "signalfx_detector" "heartbeat" {
  name = format("%s %s", local.detector_name_prefix, "Elasticsearch heartbeat")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    from signalfx.detectors.not_reporting import not_reporting
    signal = data('elasticsearch.cluster.number-of-nodes', filter=${local.not_running_vm_filters} and ${module.filtering.signalflow})${var.heartbeat_aggregation_function}.publish('signal')
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

resource "signalfx_detector" "cluster_status" {
  name = format("%s %s", local.detector_name_prefix, "ElasticSearch cluster status")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    signal = data('elasticsearch.cluster.status', filter=${module.filtering.signalflow})${var.cluster_status_aggregation_function}${var.cluster_status_transformation_function}.publish('signal')
    detect(when(signal == ${var.cluster_status_threshold_critical}, lasting=%{if var.cluster_status_lasting_duration_critical == null}None%{else}'${var.cluster_status_lasting_duration_critical}'%{endif}, at_least=${var.cluster_status_at_least_percentage_critical})).publish('CRIT')
    detect(when(signal == ${var.cluster_status_threshold_major}, lasting=%{if var.cluster_status_lasting_duration_major == null}None%{else}'${var.cluster_status_lasting_duration_major}'%{endif}, at_least=${var.cluster_status_at_least_percentage_major}) and (not when(signal == ${var.cluster_status_threshold_critical}, lasting=%{if var.cluster_status_lasting_duration_critical == null}None%{else}'${var.cluster_status_lasting_duration_critical}'%{endif}, at_least=${var.cluster_status_at_least_percentage_critical}))).publish('MAJOR')
EOF

  rule {
    description           = "is red == ${var.cluster_status_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.cluster_status_disabled_critical, var.cluster_status_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.cluster_status_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.cluster_status_runbook_url, var.runbook_url), "")
    tip                   = var.cluster_status_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is yellow == ${var.cluster_status_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.cluster_status_disabled_major, var.cluster_status_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.cluster_status_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.cluster_status_runbook_url, var.runbook_url), "")
    tip                   = var.cluster_status_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.cluster_status_max_delay
}

resource "signalfx_detector" "cluster_initializing_shards" {
  name = format("%s %s", local.detector_name_prefix, "ElasticSearch cluster initializing shards")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    signal = data('elasticsearch.cluster.initializing-shards', filter=${module.filtering.signalflow}, rollup='average')${var.cluster_initializing_shards_aggregation_function}${var.cluster_initializing_shards_transformation_function}.publish('signal')
    detect(when(signal > ${var.cluster_initializing_shards_threshold_critical}, lasting=%{if var.cluster_initializing_shards_lasting_duration_critical == null}None%{else}'${var.cluster_initializing_shards_lasting_duration_critical}'%{endif}, at_least=${var.cluster_initializing_shards_at_least_percentage_critical})).publish('CRIT')
    detect(when(signal > ${var.cluster_initializing_shards_threshold_major}, lasting=%{if var.cluster_initializing_shards_lasting_duration_major == null}None%{else}'${var.cluster_initializing_shards_lasting_duration_major}'%{endif}, at_least=${var.cluster_initializing_shards_at_least_percentage_major}) and (not when(signal > ${var.cluster_initializing_shards_threshold_critical}, lasting=%{if var.cluster_initializing_shards_lasting_duration_critical == null}None%{else}'${var.cluster_initializing_shards_lasting_duration_critical}'%{endif}, at_least=${var.cluster_initializing_shards_at_least_percentage_critical}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.cluster_initializing_shards_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.cluster_initializing_shards_disabled_critical, var.cluster_initializing_shards_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.cluster_initializing_shards_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.cluster_initializing_shards_runbook_url, var.runbook_url), "")
    tip                   = var.cluster_initializing_shards_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.cluster_initializing_shards_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.cluster_initializing_shards_disabled_major, var.cluster_initializing_shards_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.cluster_initializing_shards_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.cluster_initializing_shards_runbook_url, var.runbook_url), "")
    tip                   = var.cluster_initializing_shards_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.cluster_initializing_shards_max_delay
}

resource "signalfx_detector" "cluster_relocating_shards" {
  name = format("%s %s", local.detector_name_prefix, "ElasticSearch cluster relocating shards")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    signal = data('elasticsearch.cluster.relocating-shards', filter=${module.filtering.signalflow}, rollup='average')${var.cluster_relocating_shards_aggregation_function}${var.cluster_relocating_shards_transformation_function}.publish('signal')
    detect(when(signal > ${var.cluster_relocating_shards_threshold_critical}, lasting=%{if var.cluster_relocating_shards_lasting_duration_critical == null}None%{else}'${var.cluster_relocating_shards_lasting_duration_critical}'%{endif}, at_least=${var.cluster_relocating_shards_at_least_percentage_critical})).publish('CRIT')
    detect(when(signal > ${var.cluster_relocating_shards_threshold_major}, lasting=%{if var.cluster_relocating_shards_lasting_duration_major == null}None%{else}'${var.cluster_relocating_shards_lasting_duration_major}'%{endif}, at_least=${var.cluster_relocating_shards_at_least_percentage_major}) and (not when(signal > ${var.cluster_relocating_shards_threshold_critical}, lasting=%{if var.cluster_relocating_shards_lasting_duration_critical == null}None%{else}'${var.cluster_relocating_shards_lasting_duration_critical}'%{endif}, at_least=${var.cluster_relocating_shards_at_least_percentage_critical}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.cluster_relocating_shards_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.cluster_relocating_shards_disabled_critical, var.cluster_relocating_shards_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.cluster_relocating_shards_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.cluster_relocating_shards_runbook_url, var.runbook_url), "")
    tip                   = var.cluster_relocating_shards_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.cluster_relocating_shards_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.cluster_relocating_shards_disabled_major, var.cluster_relocating_shards_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.cluster_relocating_shards_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.cluster_relocating_shards_runbook_url, var.runbook_url), "")
    tip                   = var.cluster_relocating_shards_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.cluster_relocating_shards_max_delay
}

resource "signalfx_detector" "cluster_unassigned_shards" {
  name = format("%s %s", local.detector_name_prefix, "ElasticSearch cluster unassigned shards")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    signal = data('elasticsearch.cluster.unassigned-shards', filter=${module.filtering.signalflow}, rollup='average')${var.cluster_unassigned_shards_aggregation_function}${var.cluster_unassigned_shards_transformation_function}.publish('signal')
    detect(when(signal > ${var.cluster_unassigned_shards_threshold_critical}, lasting=%{if var.cluster_unassigned_shards_lasting_duration_critical == null}None%{else}'${var.cluster_unassigned_shards_lasting_duration_critical}'%{endif}, at_least=${var.cluster_unassigned_shards_at_least_percentage_critical})).publish('CRIT')
    detect(when(signal > ${var.cluster_unassigned_shards_threshold_major}, lasting=%{if var.cluster_unassigned_shards_lasting_duration_major == null}None%{else}'${var.cluster_unassigned_shards_lasting_duration_major}'%{endif}, at_least=${var.cluster_unassigned_shards_at_least_percentage_major}) and (not when(signal > ${var.cluster_unassigned_shards_threshold_critical}, lasting=%{if var.cluster_unassigned_shards_lasting_duration_critical == null}None%{else}'${var.cluster_unassigned_shards_lasting_duration_critical}'%{endif}, at_least=${var.cluster_unassigned_shards_at_least_percentage_critical}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.cluster_unassigned_shards_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.cluster_unassigned_shards_disabled_critical, var.cluster_unassigned_shards_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.cluster_unassigned_shards_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.cluster_unassigned_shards_runbook_url, var.runbook_url), "")
    tip                   = var.cluster_unassigned_shards_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.cluster_unassigned_shards_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.cluster_unassigned_shards_disabled_major, var.cluster_unassigned_shards_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.cluster_unassigned_shards_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.cluster_unassigned_shards_runbook_url, var.runbook_url), "")
    tip                   = var.cluster_unassigned_shards_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.cluster_unassigned_shards_max_delay
}

resource "signalfx_detector" "cluster_pending_tasks" {
  name = format("%s %s", local.detector_name_prefix, "ElasticSearch cluster pending tasks")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    signal = data('elasticsearch.cluster.pending-tasks', filter=${module.filtering.signalflow}, rollup='average')${var.cluster_pending_tasks_aggregation_function}${var.cluster_pending_tasks_transformation_function}.publish('signal')
    detect(when(signal > ${var.cluster_pending_tasks_threshold_critical}, lasting=%{if var.cluster_pending_tasks_lasting_duration_critical == null}None%{else}'${var.cluster_pending_tasks_lasting_duration_critical}'%{endif}, at_least=${var.cluster_pending_tasks_at_least_percentage_critical})).publish('CRIT')
    detect(when(signal > ${var.cluster_pending_tasks_threshold_major}, lasting=%{if var.cluster_pending_tasks_lasting_duration_major == null}None%{else}'${var.cluster_pending_tasks_lasting_duration_major}'%{endif}, at_least=${var.cluster_pending_tasks_at_least_percentage_major}) and (not when(signal > ${var.cluster_pending_tasks_threshold_critical}, lasting=%{if var.cluster_pending_tasks_lasting_duration_critical == null}None%{else}'${var.cluster_pending_tasks_lasting_duration_critical}'%{endif}, at_least=${var.cluster_pending_tasks_at_least_percentage_critical}))).publish('MAJOR')
EOF

  rule {
    description           = "are too high > ${var.cluster_pending_tasks_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.cluster_pending_tasks_disabled_critical, var.cluster_pending_tasks_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.cluster_pending_tasks_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.cluster_pending_tasks_runbook_url, var.runbook_url), "")
    tip                   = var.cluster_pending_tasks_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "are too high > ${var.cluster_pending_tasks_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.cluster_pending_tasks_disabled_major, var.cluster_pending_tasks_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.cluster_pending_tasks_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.cluster_pending_tasks_runbook_url, var.runbook_url), "")
    tip                   = var.cluster_pending_tasks_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.cluster_pending_tasks_max_delay
}

resource "signalfx_detector" "cpu_usage" {
  name = format("%s %s", local.detector_name_prefix, "ElasticSearch cpu usage")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    base_filtering = filter('node_name', '*')
    signal = data('elasticsearch.process.cpu.percent', filter=base_filtering and ${module.filtering.signalflow}, rollup='average')${var.cpu_usage_aggregation_function}${var.cpu_usage_transformation_function}.publish('signal')
    detect(when(signal > ${var.cpu_usage_threshold_critical}, lasting=%{if var.cpu_usage_lasting_duration_critical == null}None%{else}'${var.cpu_usage_lasting_duration_critical}'%{endif}, at_least=${var.cpu_usage_at_least_percentage_critical})).publish('CRIT')
    detect(when(signal > ${var.cpu_usage_threshold_major}, lasting=%{if var.cpu_usage_lasting_duration_major == null}None%{else}'${var.cpu_usage_lasting_duration_major}'%{endif}, at_least=${var.cpu_usage_at_least_percentage_major}) and (not when(signal > ${var.cpu_usage_threshold_critical}, lasting=%{if var.cpu_usage_lasting_duration_critical == null}None%{else}'${var.cpu_usage_lasting_duration_critical}'%{endif}, at_least=${var.cpu_usage_at_least_percentage_critical}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.cpu_usage_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.cpu_usage_disabled_critical, var.cpu_usage_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.cpu_usage_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.cpu_usage_runbook_url, var.runbook_url), "")
    tip                   = var.cpu_usage_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.cpu_usage_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.cpu_usage_disabled_major, var.cpu_usage_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.cpu_usage_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.cpu_usage_runbook_url, var.runbook_url), "")
    tip                   = var.cpu_usage_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.cpu_usage_max_delay
}

resource "signalfx_detector" "file_descriptors_usage" {
  name = format("%s %s", local.detector_name_prefix, "ElasticSearch file descriptors usage")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    base_filtering = filter('node_name', '*')
    A = data('elasticsearch.process.open_file_descriptors', filter=base_filtering and ${module.filtering.signalflow}, rollup='average')${var.file_descriptors_usage_aggregation_function}${var.file_descriptors_usage_transformation_function}
    B = data('elasticsearch.process.max_file_descriptors', filter=base_filtering and ${module.filtering.signalflow}, rollup='average')${var.file_descriptors_usage_aggregation_function}${var.file_descriptors_usage_transformation_function}
    signal = (A/B).scale(100).publish('signal')
    detect(when(signal > ${var.file_descriptors_usage_threshold_critical}, lasting=%{if var.file_descriptors_usage_lasting_duration_critical == null}None%{else}'${var.file_descriptors_usage_lasting_duration_critical}'%{endif}, at_least=${var.file_descriptors_usage_at_least_percentage_critical})).publish('CRIT')
    detect(when(signal > ${var.file_descriptors_usage_threshold_major}, lasting=%{if var.file_descriptors_usage_lasting_duration_major == null}None%{else}'${var.file_descriptors_usage_lasting_duration_major}'%{endif}, at_least=${var.file_descriptors_usage_at_least_percentage_major}) and (not when(signal > ${var.file_descriptors_usage_threshold_critical}, lasting=%{if var.file_descriptors_usage_lasting_duration_critical == null}None%{else}'${var.file_descriptors_usage_lasting_duration_critical}'%{endif}, at_least=${var.file_descriptors_usage_at_least_percentage_critical}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.file_descriptors_usage_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.file_descriptors_usage_disabled_critical, var.file_descriptors_usage_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.file_descriptors_usage_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.file_descriptors_usage_runbook_url, var.runbook_url), "")
    tip                   = var.file_descriptors_usage_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.file_descriptors_usage_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.file_descriptors_usage_disabled_major, var.file_descriptors_usage_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.file_descriptors_usage_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.file_descriptors_usage_runbook_url, var.runbook_url), "")
    tip                   = var.file_descriptors_usage_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.file_descriptors_usage_max_delay
}

resource "signalfx_detector" "jvm_heap_memory_usage" {
  name = format("%s %s", local.detector_name_prefix, "ElasticSearch jvm heap memory usage")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    base_filtering = filter('node_name', '*')
    signal = data('elasticsearch.jvm.mem.heap-used-percent', filter=base_filtering and ${module.filtering.signalflow}, rollup='average')${var.jvm_heap_memory_usage_aggregation_function}${var.jvm_heap_memory_usage_transformation_function}.publish('signal')
    detect(when(signal > ${var.jvm_heap_memory_usage_threshold_critical}, lasting=%{if var.jvm_heap_memory_usage_lasting_duration_critical == null}None%{else}'${var.jvm_heap_memory_usage_lasting_duration_critical}'%{endif}, at_least=${var.jvm_heap_memory_usage_at_least_percentage_critical})).publish('CRIT')
    detect(when(signal > ${var.jvm_heap_memory_usage_threshold_major}, lasting=%{if var.jvm_heap_memory_usage_lasting_duration_major == null}None%{else}'${var.jvm_heap_memory_usage_lasting_duration_major}'%{endif}, at_least=${var.jvm_heap_memory_usage_at_least_percentage_major}) and (not when(signal > ${var.jvm_heap_memory_usage_threshold_critical}, lasting=%{if var.jvm_heap_memory_usage_lasting_duration_critical == null}None%{else}'${var.jvm_heap_memory_usage_lasting_duration_critical}'%{endif}, at_least=${var.jvm_heap_memory_usage_at_least_percentage_critical}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.jvm_heap_memory_usage_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.jvm_heap_memory_usage_disabled_critical, var.jvm_heap_memory_usage_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.jvm_heap_memory_usage_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.jvm_heap_memory_usage_runbook_url, var.runbook_url), "")
    tip                   = var.jvm_heap_memory_usage_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.jvm_heap_memory_usage_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.jvm_heap_memory_usage_disabled_major, var.jvm_heap_memory_usage_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.jvm_heap_memory_usage_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.jvm_heap_memory_usage_runbook_url, var.runbook_url), "")
    tip                   = var.jvm_heap_memory_usage_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.jvm_heap_memory_usage_max_delay
}

resource "signalfx_detector" "jvm_memory_young_usage" {
  name = format("%s %s", local.detector_name_prefix, "ElasticSearch jvm memory young usage")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    base_filtering = filter('node_name', '*')
    A = data('elasticsearch.jvm.mem.pools.young.used_in_bytes', filter=base_filtering and ${module.filtering.signalflow}, rollup='average')${var.jvm_memory_young_usage_aggregation_function}${var.jvm_memory_young_usage_transformation_function}
    B = data('elasticsearch.jvm.mem.pools.young.max_in_bytes', filter=base_filtering and ${module.filtering.signalflow}, rollup='average')${var.jvm_memory_young_usage_aggregation_function}${var.jvm_memory_young_usage_transformation_function}
    signal = (A/B).fill(0).scale(100).publish('signal')
    detect(when(signal > ${var.jvm_memory_young_usage_threshold_major}, lasting=%{if var.jvm_memory_young_usage_lasting_duration_major == null}None%{else}'${var.jvm_memory_young_usage_lasting_duration_major}'%{endif}, at_least=${var.jvm_memory_young_usage_at_least_percentage_major})).publish('MAJOR')
    detect(when(signal > ${var.jvm_memory_young_usage_threshold_minor}, lasting=%{if var.jvm_memory_young_usage_lasting_duration_minor == null}None%{else}'${var.jvm_memory_young_usage_lasting_duration_minor}'%{endif}, at_least=${var.jvm_memory_young_usage_at_least_percentage_minor}) and (not when(signal > ${var.jvm_memory_young_usage_threshold_major}, lasting=%{if var.jvm_memory_young_usage_lasting_duration_major == null}None%{else}'${var.jvm_memory_young_usage_lasting_duration_major}'%{endif}, at_least=${var.jvm_memory_young_usage_at_least_percentage_major}))).publish('MINOR')
EOF

  rule {
    description           = "is too high > ${var.jvm_memory_young_usage_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.jvm_memory_young_usage_disabled_major, var.jvm_memory_young_usage_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.jvm_memory_young_usage_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.jvm_memory_young_usage_runbook_url, var.runbook_url), "")
    tip                   = var.jvm_memory_young_usage_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.jvm_memory_young_usage_threshold_minor}"
    severity              = "Minor"
    detect_label          = "MINOR"
    disabled              = coalesce(var.jvm_memory_young_usage_disabled_minor, var.jvm_memory_young_usage_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.jvm_memory_young_usage_notifications, "minor", []), var.notifications.minor), null)
    runbook_url           = try(coalesce(var.jvm_memory_young_usage_runbook_url, var.runbook_url), "")
    tip                   = var.jvm_memory_young_usage_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.jvm_memory_young_usage_max_delay
}

resource "signalfx_detector" "jvm_memory_old_usage" {
  name = format("%s %s", local.detector_name_prefix, "ElasticSearch jvm memory old usage")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    base_filtering = filter('node_name', '*')
    A = data('elasticsearch.jvm.mem.pools.old.used_in_bytes', filter=base_filtering and ${module.filtering.signalflow}, rollup='average')${var.jvm_memory_old_usage_aggregation_function}${var.jvm_memory_old_usage_transformation_function}
    B = data('elasticsearch.jvm.mem.pools.old.max_in_bytes', filter=base_filtering and ${module.filtering.signalflow}, rollup='average')${var.jvm_memory_old_usage_aggregation_function}${var.jvm_memory_old_usage_transformation_function}
    signal = (A/B).fill(0).scale(100).publish('signal')
    detect(when(signal > ${var.jvm_memory_old_usage_threshold_major}, lasting=%{if var.jvm_memory_old_usage_lasting_duration_major == null}None%{else}'${var.jvm_memory_old_usage_lasting_duration_major}'%{endif}, at_least=${var.jvm_memory_old_usage_at_least_percentage_major})).publish('MAJOR')
    detect(when(signal > ${var.jvm_memory_old_usage_threshold_minor}, lasting=%{if var.jvm_memory_old_usage_lasting_duration_minor == null}None%{else}'${var.jvm_memory_old_usage_lasting_duration_minor}'%{endif}, at_least=${var.jvm_memory_old_usage_at_least_percentage_minor}) and (not when(signal > ${var.jvm_memory_old_usage_threshold_major}, lasting=%{if var.jvm_memory_old_usage_lasting_duration_major == null}None%{else}'${var.jvm_memory_old_usage_lasting_duration_major}'%{endif}, at_least=${var.jvm_memory_old_usage_at_least_percentage_major}))).publish('MINOR')
EOF

  rule {
    description           = "is too high > ${var.jvm_memory_old_usage_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.jvm_memory_old_usage_disabled_major, var.jvm_memory_old_usage_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.jvm_memory_old_usage_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.jvm_memory_old_usage_runbook_url, var.runbook_url), "")
    tip                   = var.jvm_memory_old_usage_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.jvm_memory_old_usage_threshold_minor}"
    severity              = "Minor"
    detect_label          = "MINOR"
    disabled              = coalesce(var.jvm_memory_old_usage_disabled_minor, var.jvm_memory_old_usage_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.jvm_memory_old_usage_notifications, "minor", []), var.notifications.minor), null)
    runbook_url           = try(coalesce(var.jvm_memory_old_usage_runbook_url, var.runbook_url), "")
    tip                   = var.jvm_memory_old_usage_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.jvm_memory_old_usage_max_delay
}

resource "signalfx_detector" "old-generation_garbage_collections_latency" {
  name = format("%s %s", local.detector_name_prefix, "ElasticSearch old-generation garbage collections latency")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    base_filtering = filter('node_name', '*')
    A = data('elasticsearch.jvm.gc.old-time', filter=base_filtering and ${module.filtering.signalflow}, rollup='delta', extrapolation='zero')${var.old-generation_garbage_collections_latency_aggregation_function}${var.old-generation_garbage_collections_latency_transformation_function}
    B = data('elasticsearch.jvm.gc.old-count', filter=base_filtering and ${module.filtering.signalflow}, rollup='delta', extrapolation='zero')${var.old-generation_garbage_collections_latency_aggregation_function}${var.old-generation_garbage_collections_latency_transformation_function}
    signal = (A/B).fill(0).publish('signal')
    detect(when(signal > ${var.old-generation_garbage_collections_latency_threshold_major}, lasting=%{if var.old-generation_garbage_collections_latency_lasting_duration_major == null}None%{else}'${var.old-generation_garbage_collections_latency_lasting_duration_major}'%{endif}, at_least=${var.old-generation_garbage_collections_latency_at_least_percentage_major})).publish('MAJOR')
    detect(when(signal > ${var.old-generation_garbage_collections_latency_threshold_minor}, lasting=%{if var.old-generation_garbage_collections_latency_lasting_duration_minor == null}None%{else}'${var.old-generation_garbage_collections_latency_lasting_duration_minor}'%{endif}, at_least=${var.old-generation_garbage_collections_latency_at_least_percentage_minor}) and (not when(signal > ${var.old-generation_garbage_collections_latency_threshold_major}, lasting=%{if var.old-generation_garbage_collections_latency_lasting_duration_major == null}None%{else}'${var.old-generation_garbage_collections_latency_lasting_duration_major}'%{endif}, at_least=${var.old-generation_garbage_collections_latency_at_least_percentage_major}))).publish('MINOR')
EOF

  rule {
    description           = "is too high > ${var.old-generation_garbage_collections_latency_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.old-generation_garbage_collections_latency_disabled_major, var.old-generation_garbage_collections_latency_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.old-generation_garbage_collections_latency_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.old-generation_garbage_collections_latency_runbook_url, var.runbook_url), "")
    tip                   = var.old-generation_garbage_collections_latency_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.old-generation_garbage_collections_latency_threshold_minor}"
    severity              = "Minor"
    detect_label          = "MINOR"
    disabled              = coalesce(var.old-generation_garbage_collections_latency_disabled_minor, var.old-generation_garbage_collections_latency_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.old-generation_garbage_collections_latency_notifications, "minor", []), var.notifications.minor), null)
    runbook_url           = try(coalesce(var.old-generation_garbage_collections_latency_runbook_url, var.runbook_url), "")
    tip                   = var.old-generation_garbage_collections_latency_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.old-generation_garbage_collections_latency_max_delay
}

resource "signalfx_detector" "young-generation_garbage_collections_latency" {
  name = format("%s %s", local.detector_name_prefix, "ElasticSearch young-generation garbage collections latency")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    base_filtering = filter('node_name', '*')
    A = data('elasticsearch.jvm.gc.time', filter=base_filtering and ${module.filtering.signalflow}, rollup='delta', extrapolation='zero')${var.young-generation_garbage_collections_latency_aggregation_function}${var.young-generation_garbage_collections_latency_transformation_function}
    B = data('elasticsearch.jvm.gc.count', filter=base_filtering and ${module.filtering.signalflow}, rollup='delta', extrapolation='zero')${var.young-generation_garbage_collections_latency_aggregation_function}${var.young-generation_garbage_collections_latency_transformation_function}
    signal = (A/B).fill(0).publish('signal')
    detect(when(signal > ${var.young-generation_garbage_collections_latency_threshold_major}, lasting=%{if var.young-generation_garbage_collections_latency_lasting_duration_major == null}None%{else}'${var.young-generation_garbage_collections_latency_lasting_duration_major}'%{endif}, at_least=${var.young-generation_garbage_collections_latency_at_least_percentage_major})).publish('MAJOR')
    detect(when(signal > ${var.young-generation_garbage_collections_latency_threshold_minor}, lasting=%{if var.young-generation_garbage_collections_latency_lasting_duration_minor == null}None%{else}'${var.young-generation_garbage_collections_latency_lasting_duration_minor}'%{endif}, at_least=${var.young-generation_garbage_collections_latency_at_least_percentage_minor}) and (not when(signal > ${var.young-generation_garbage_collections_latency_threshold_major}, lasting=%{if var.young-generation_garbage_collections_latency_lasting_duration_major == null}None%{else}'${var.young-generation_garbage_collections_latency_lasting_duration_major}'%{endif}, at_least=${var.young-generation_garbage_collections_latency_at_least_percentage_major}))).publish('MINOR')
EOF

  rule {
    description           = "is too high > ${var.young-generation_garbage_collections_latency_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.young-generation_garbage_collections_latency_disabled_major, var.young-generation_garbage_collections_latency_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.young-generation_garbage_collections_latency_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.young-generation_garbage_collections_latency_runbook_url, var.runbook_url), "")
    tip                   = var.young-generation_garbage_collections_latency_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.young-generation_garbage_collections_latency_threshold_minor}"
    severity              = "Minor"
    detect_label          = "MINOR"
    disabled              = coalesce(var.young-generation_garbage_collections_latency_disabled_minor, var.young-generation_garbage_collections_latency_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.young-generation_garbage_collections_latency_notifications, "minor", []), var.notifications.minor), null)
    runbook_url           = try(coalesce(var.young-generation_garbage_collections_latency_runbook_url, var.runbook_url), "")
    tip                   = var.young-generation_garbage_collections_latency_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.young-generation_garbage_collections_latency_max_delay
}

resource "signalfx_detector" "indexing_latency" {
  name = format("%s %s", local.detector_name_prefix, "ElasticSearch indexing latency")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    base_filtering = filter('node_name', '*')
    A = data('elasticsearch.indices.indexing.index-time', filter=base_filtering and ${module.filtering.signalflow}, rollup='delta', extrapolation='zero')${var.indexing_latency_aggregation_function}${var.indexing_latency_transformation_function}
    B = data('elasticsearch.indices.indexing.index-total', filter=base_filtering and ${module.filtering.signalflow}, rollup='delta', extrapolation='zero')${var.indexing_latency_aggregation_function}${var.indexing_latency_transformation_function}
    signal = (A/B).fill(0).publish('signal')
    detect(when(signal > ${var.indexing_latency_threshold_major}, lasting=%{if var.indexing_latency_lasting_duration_major == null}None%{else}'${var.indexing_latency_lasting_duration_major}'%{endif}, at_least=${var.indexing_latency_at_least_percentage_major})).publish('MAJOR')
    detect(when(signal > ${var.indexing_latency_threshold_minor}, lasting=%{if var.indexing_latency_lasting_duration_minor == null}None%{else}'${var.indexing_latency_lasting_duration_minor}'%{endif}, at_least=${var.indexing_latency_at_least_percentage_minor}) and (not when(signal > ${var.indexing_latency_threshold_major}, lasting=%{if var.indexing_latency_lasting_duration_major == null}None%{else}'${var.indexing_latency_lasting_duration_major}'%{endif}, at_least=${var.indexing_latency_at_least_percentage_major}))).publish('MINOR')
EOF

  rule {
    description           = "is too high > ${var.indexing_latency_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.indexing_latency_disabled_major, var.indexing_latency_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.indexing_latency_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.indexing_latency_runbook_url, var.runbook_url), "")
    tip                   = var.indexing_latency_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.indexing_latency_threshold_minor}"
    severity              = "Minor"
    detect_label          = "MINOR"
    disabled              = coalesce(var.indexing_latency_disabled_minor, var.indexing_latency_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.indexing_latency_notifications, "minor", []), var.notifications.minor), null)
    runbook_url           = try(coalesce(var.indexing_latency_runbook_url, var.runbook_url), "")
    tip                   = var.indexing_latency_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.indexing_latency_max_delay
}

resource "signalfx_detector" "index_flushing_to_disk_latency" {
  name = format("%s %s", local.detector_name_prefix, "ElasticSearch index flushing to disk latency")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    base_filtering = filter('node_name', '*')
    A = data('elasticsearch.indices.flush.total-time', filter=base_filtering and ${module.filtering.signalflow}, rollup='delta', extrapolation='zero')${var.index_flushing_to_disk_latency_aggregation_function}${var.index_flushing_to_disk_latency_transformation_function}
    B = data('elasticsearch.indices.flush.total', filter=base_filtering and ${module.filtering.signalflow}, rollup='delta', extrapolation='zero')${var.index_flushing_to_disk_latency_aggregation_function}${var.index_flushing_to_disk_latency_transformation_function}
    signal = (A/B).fill(0).publish('signal')
    detect(when(signal > ${var.index_flushing_to_disk_latency_threshold_major}, lasting=%{if var.index_flushing_to_disk_latency_lasting_duration_major == null}None%{else}'${var.index_flushing_to_disk_latency_lasting_duration_major}'%{endif}, at_least=${var.index_flushing_to_disk_latency_at_least_percentage_major})).publish('MAJOR')
    detect(when(signal > ${var.index_flushing_to_disk_latency_threshold_minor}, lasting=%{if var.index_flushing_to_disk_latency_lasting_duration_minor == null}None%{else}'${var.index_flushing_to_disk_latency_lasting_duration_minor}'%{endif}, at_least=${var.index_flushing_to_disk_latency_at_least_percentage_minor}) and (not when(signal > ${var.index_flushing_to_disk_latency_threshold_major}, lasting=%{if var.index_flushing_to_disk_latency_lasting_duration_major == null}None%{else}'${var.index_flushing_to_disk_latency_lasting_duration_major}'%{endif}, at_least=${var.index_flushing_to_disk_latency_at_least_percentage_major}))).publish('MINOR')
EOF

  rule {
    description           = "is too high > ${var.index_flushing_to_disk_latency_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.index_flushing_to_disk_latency_disabled_major, var.index_flushing_to_disk_latency_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.index_flushing_to_disk_latency_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.index_flushing_to_disk_latency_runbook_url, var.runbook_url), "")
    tip                   = var.index_flushing_to_disk_latency_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.index_flushing_to_disk_latency_threshold_minor}"
    severity              = "Minor"
    detect_label          = "MINOR"
    disabled              = coalesce(var.index_flushing_to_disk_latency_disabled_minor, var.index_flushing_to_disk_latency_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.index_flushing_to_disk_latency_notifications, "minor", []), var.notifications.minor), null)
    runbook_url           = try(coalesce(var.index_flushing_to_disk_latency_runbook_url, var.runbook_url), "")
    tip                   = var.index_flushing_to_disk_latency_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.index_flushing_to_disk_latency_max_delay
}

resource "signalfx_detector" "search_query_latency" {
  name = format("%s %s", local.detector_name_prefix, "ElasticSearch search query latency")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    base_filtering = filter('node_name', '*')
    A = data('elasticsearch.indices.search.query-time', filter=base_filtering and ${module.filtering.signalflow}, rollup='delta', extrapolation='zero')${var.search_query_latency_aggregation_function}${var.search_query_latency_transformation_function}
    B = data('elasticsearch.indices.search.query-total', filter=base_filtering and ${module.filtering.signalflow}, rollup='delta', extrapolation='zero')${var.search_query_latency_aggregation_function}${var.search_query_latency_transformation_function}
    signal = (A/B).fill(0).publish('signal')
    detect(when(signal > ${var.search_query_latency_threshold_major}, lasting=%{if var.search_query_latency_lasting_duration_major == null}None%{else}'${var.search_query_latency_lasting_duration_major}'%{endif}, at_least=${var.search_query_latency_at_least_percentage_major})).publish('MAJOR')
    detect(when(signal > ${var.search_query_latency_threshold_minor}, lasting=%{if var.search_query_latency_lasting_duration_minor == null}None%{else}'${var.search_query_latency_lasting_duration_minor}'%{endif}, at_least=${var.search_query_latency_at_least_percentage_minor}) and (not when(signal > ${var.search_query_latency_threshold_major}, lasting=%{if var.search_query_latency_lasting_duration_major == null}None%{else}'${var.search_query_latency_lasting_duration_major}'%{endif}, at_least=${var.search_query_latency_at_least_percentage_major}))).publish('MINOR')
EOF

  rule {
    description           = "is too high > ${var.search_query_latency_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.search_query_latency_disabled_major, var.search_query_latency_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.search_query_latency_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.search_query_latency_runbook_url, var.runbook_url), "")
    tip                   = var.search_query_latency_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.search_query_latency_threshold_minor}"
    severity              = "Minor"
    detect_label          = "MINOR"
    disabled              = coalesce(var.search_query_latency_disabled_minor, var.search_query_latency_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.search_query_latency_notifications, "minor", []), var.notifications.minor), null)
    runbook_url           = try(coalesce(var.search_query_latency_runbook_url, var.runbook_url), "")
    tip                   = var.search_query_latency_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.search_query_latency_max_delay
}

resource "signalfx_detector" "search_fetch_latency" {
  name = format("%s %s", local.detector_name_prefix, "ElasticSearch search fetch latency")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    base_filtering = filter('node_name', '*')
    A = data('elasticsearch.indices.search.fetch-time', filter=base_filtering and ${module.filtering.signalflow}, rollup='delta', extrapolation='zero')${var.search_fetch_latency_aggregation_function}${var.search_fetch_latency_transformation_function}
    B = data('elasticsearch.indices.search.fetch-total', filter=base_filtering and ${module.filtering.signalflow}, rollup='delta', extrapolation='zero')${var.search_fetch_latency_aggregation_function}${var.search_fetch_latency_transformation_function}
    signal = (A/B).fill(0).publish('signal')
    detect(when(signal > ${var.search_fetch_latency_threshold_major}, lasting=%{if var.search_fetch_latency_lasting_duration_major == null}None%{else}'${var.search_fetch_latency_lasting_duration_major}'%{endif}, at_least=${var.search_fetch_latency_at_least_percentage_major})).publish('MAJOR')
    detect(when(signal > ${var.search_fetch_latency_threshold_minor}, lasting=%{if var.search_fetch_latency_lasting_duration_minor == null}None%{else}'${var.search_fetch_latency_lasting_duration_minor}'%{endif}, at_least=${var.search_fetch_latency_at_least_percentage_minor}) and (not when(signal > ${var.search_fetch_latency_threshold_major}, lasting=%{if var.search_fetch_latency_lasting_duration_major == null}None%{else}'${var.search_fetch_latency_lasting_duration_major}'%{endif}, at_least=${var.search_fetch_latency_at_least_percentage_major}))).publish('MINOR')
EOF

  rule {
    description           = "is too high > ${var.search_fetch_latency_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.search_fetch_latency_disabled_major, var.search_fetch_latency_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.search_fetch_latency_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.search_fetch_latency_runbook_url, var.runbook_url), "")
    tip                   = var.search_fetch_latency_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.search_fetch_latency_threshold_minor}"
    severity              = "Minor"
    detect_label          = "MINOR"
    disabled              = coalesce(var.search_fetch_latency_disabled_minor, var.search_fetch_latency_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.search_fetch_latency_notifications, "minor", []), var.notifications.minor), null)
    runbook_url           = try(coalesce(var.search_fetch_latency_runbook_url, var.runbook_url), "")
    tip                   = var.search_fetch_latency_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.search_fetch_latency_max_delay
}

resource "signalfx_detector" "fielddata_cache_evictions_rate_of_change" {
  name = format("%s %s", local.detector_name_prefix, "ElasticSearch fielddata cache evictions rate of change")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    base_filtering = filter('node_name', '*')
    A = data('elasticsearch.indices.fielddata.evictions', filter=base_filtering and ${module.filtering.signalflow}, rollup='delta', extrapolation='zero')${var.fielddata_cache_evictions_rate_of_change_aggregation_function}${var.fielddata_cache_evictions_rate_of_change_transformation_function}
    signal = A.rateofchange().publish('signal')
    detect(when(signal > ${var.fielddata_cache_evictions_rate_of_change_threshold_major}, lasting=%{if var.fielddata_cache_evictions_rate_of_change_lasting_duration_major == null}None%{else}'${var.fielddata_cache_evictions_rate_of_change_lasting_duration_major}'%{endif}, at_least=${var.fielddata_cache_evictions_rate_of_change_at_least_percentage_major})).publish('MAJOR')
    detect(when(signal > ${var.fielddata_cache_evictions_rate_of_change_threshold_minor}, lasting=%{if var.fielddata_cache_evictions_rate_of_change_lasting_duration_minor == null}None%{else}'${var.fielddata_cache_evictions_rate_of_change_lasting_duration_minor}'%{endif}, at_least=${var.fielddata_cache_evictions_rate_of_change_at_least_percentage_minor}) and (not when(signal > ${var.fielddata_cache_evictions_rate_of_change_threshold_major}, lasting=%{if var.fielddata_cache_evictions_rate_of_change_lasting_duration_major == null}None%{else}'${var.fielddata_cache_evictions_rate_of_change_lasting_duration_major}'%{endif}, at_least=${var.fielddata_cache_evictions_rate_of_change_at_least_percentage_major}))).publish('MINOR')
EOF

  rule {
    description           = "is too high > ${var.fielddata_cache_evictions_rate_of_change_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.fielddata_cache_evictions_rate_of_change_disabled_major, var.fielddata_cache_evictions_rate_of_change_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.fielddata_cache_evictions_rate_of_change_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.fielddata_cache_evictions_rate_of_change_runbook_url, var.runbook_url), "")
    tip                   = var.fielddata_cache_evictions_rate_of_change_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.fielddata_cache_evictions_rate_of_change_threshold_minor}"
    severity              = "Minor"
    detect_label          = "MINOR"
    disabled              = coalesce(var.fielddata_cache_evictions_rate_of_change_disabled_minor, var.fielddata_cache_evictions_rate_of_change_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.fielddata_cache_evictions_rate_of_change_notifications, "minor", []), var.notifications.minor), null)
    runbook_url           = try(coalesce(var.fielddata_cache_evictions_rate_of_change_runbook_url, var.runbook_url), "")
    tip                   = var.fielddata_cache_evictions_rate_of_change_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.fielddata_cache_evictions_rate_of_change_max_delay
}

resource "signalfx_detector" "max_time_spent_by_task_in_queue_rate_of_change" {
  name = format("%s %s", local.detector_name_prefix, "ElasticSearch max time spent by task in queue rate of change")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    A = data('elasticsearch.cluster.task-max-wait-time', filter=${module.filtering.signalflow}, rollup='average')${var.max_time_spent_by_task_in_queue_rate_of_change_aggregation_function}${var.max_time_spent_by_task_in_queue_rate_of_change_transformation_function}
    signal = A.rateofchange().publish('signal')
    detect(when(signal > ${var.max_time_spent_by_task_in_queue_rate_of_change_threshold_major}, lasting=%{if var.max_time_spent_by_task_in_queue_rate_of_change_lasting_duration_major == null}None%{else}'${var.max_time_spent_by_task_in_queue_rate_of_change_lasting_duration_major}'%{endif}, at_least=${var.max_time_spent_by_task_in_queue_rate_of_change_at_least_percentage_major})).publish('MAJOR')
    detect(when(signal > ${var.max_time_spent_by_task_in_queue_rate_of_change_threshold_minor}, lasting=%{if var.max_time_spent_by_task_in_queue_rate_of_change_lasting_duration_minor == null}None%{else}'${var.max_time_spent_by_task_in_queue_rate_of_change_lasting_duration_minor}'%{endif}, at_least=${var.max_time_spent_by_task_in_queue_rate_of_change_at_least_percentage_minor}) and (not when(signal > ${var.max_time_spent_by_task_in_queue_rate_of_change_threshold_major}, lasting=%{if var.max_time_spent_by_task_in_queue_rate_of_change_lasting_duration_major == null}None%{else}'${var.max_time_spent_by_task_in_queue_rate_of_change_lasting_duration_major}'%{endif}, at_least=${var.max_time_spent_by_task_in_queue_rate_of_change_at_least_percentage_major}))).publish('MINOR')
EOF

  rule {
    description           = "is too high > ${var.max_time_spent_by_task_in_queue_rate_of_change_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.max_time_spent_by_task_in_queue_rate_of_change_disabled_major, var.max_time_spent_by_task_in_queue_rate_of_change_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.max_time_spent_by_task_in_queue_rate_of_change_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.max_time_spent_by_task_in_queue_rate_of_change_runbook_url, var.runbook_url), "")
    tip                   = var.max_time_spent_by_task_in_queue_rate_of_change_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.max_time_spent_by_task_in_queue_rate_of_change_threshold_minor}"
    severity              = "Minor"
    detect_label          = "MINOR"
    disabled              = coalesce(var.max_time_spent_by_task_in_queue_rate_of_change_disabled_minor, var.max_time_spent_by_task_in_queue_rate_of_change_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.max_time_spent_by_task_in_queue_rate_of_change_notifications, "minor", []), var.notifications.minor), null)
    runbook_url           = try(coalesce(var.max_time_spent_by_task_in_queue_rate_of_change_runbook_url, var.runbook_url), "")
    tip                   = var.max_time_spent_by_task_in_queue_rate_of_change_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.max_time_spent_by_task_in_queue_rate_of_change_max_delay
}

