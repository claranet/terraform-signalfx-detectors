resource "signalfx_detector" "heartbeat" {
  name = format("%s %s", local.detector_name_prefix, "Elasticsearch heartbeat")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    from signalfx.detectors.not_reporting import not_reporting
    base_filtering = filter('plugin', 'elasticsearch')
    signal = data('elasticsearch.cluster.number-of-nodes', filter=${local.not_running_vm_filters} and base_filtering and ${module.filtering.signalflow})${var.heartbeat_aggregation_function}.publish('signal')
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
    base_filtering = filter('plugin', 'elasticsearch')
    signal = data('elasticsearch.cluster.status', filter=base_filtering and ${module.filtering.signalflow})${var.cluster_status_aggregation_function}${var.cluster_status_transformation_function}.publish('signal')
    detect(when(signal >= ${var.cluster_status_threshold_critical}, lasting=%{if var.cluster_status_lasting_duration_critical == null}None%{else}'${var.cluster_status_lasting_duration_critical}'%{endif}, at_least=${var.cluster_status_at_least_percentage_critical})).publish('CRIT')
    detect(when(signal >= ${var.cluster_status_threshold_major}, lasting=%{if var.cluster_status_lasting_duration_major == null}None%{else}'${var.cluster_status_lasting_duration_major}'%{endif}, at_least=${var.cluster_status_at_least_percentage_major})).publish('MAJOR')
EOF

  rule {
    description           = "is red >= ${var.cluster_status_threshold_critical}"
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
    description           = "is yellow >= ${var.cluster_status_threshold_major}"
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
    base_filtering = filter('plugin', 'elasticsearch')
    signal = data('elasticsearch.cluster.initializing-shards', filter=base_filtering and ${module.filtering.signalflow}, rollup='average')${var.cluster_initializing_shards_aggregation_function}${var.cluster_initializing_shards_transformation_function}.publish('signal')
    detect(when(signal >= ${var.cluster_initializing_shards_threshold_critical}, lasting=%{if var.cluster_initializing_shards_lasting_duration_critical == null}None%{else}'${var.cluster_initializing_shards_lasting_duration_critical}'%{endif}, at_least=${var.cluster_initializing_shards_at_least_percentage_critical})).publish('CRIT')
    detect(when(signal > ${var.cluster_initializing_shards_threshold_major}, lasting=%{if var.cluster_initializing_shards_lasting_duration_major == null}None%{else}'${var.cluster_initializing_shards_lasting_duration_major}'%{endif}, at_least=${var.cluster_initializing_shards_at_least_percentage_major}) and (not when(signal >= ${var.cluster_initializing_shards_threshold_critical}, lasting=%{if var.cluster_initializing_shards_lasting_duration_critical == null}None%{else}'${var.cluster_initializing_shards_lasting_duration_critical}'%{endif}, at_least=${var.cluster_initializing_shards_at_least_percentage_critical}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high >= ${var.cluster_initializing_shards_threshold_critical}"
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
    base_filtering = filter('plugin', 'elasticsearch')
    signal = data('elasticsearch.cluster.relocating-shards', filter=base_filtering and ${module.filtering.signalflow}, rollup='average')${var.cluster_relocating_shards_aggregation_function}${var.cluster_relocating_shards_transformation_function}.publish('signal')
    detect(when(signal > ${var.cluster_relocating_shards_threshold_critical}, lasting=%{if var.cluster_relocating_shards_lasting_duration_critical == null}None%{else}'${var.cluster_relocating_shards_lasting_duration_critical}'%{endif}, at_least=${var.cluster_relocating_shards_at_least_percentage_critical})).publish('CRIT')
EOF

  rule {
    description           = "is too high > ${var.cluster_relocating_shards_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.cluster_relocating_shards_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.cluster_relocating_shards_notifications, "critical", []), var.notifications.critical), null)
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
    base_filtering = filter('plugin', 'elasticsearch')
    signal = data('elasticsearch.cluster.unassigned-shards', filter=base_filtering and ${module.filtering.signalflow}, rollup='average')${var.cluster_unassigned_shards_aggregation_function}${var.cluster_unassigned_shards_transformation_function}.publish('signal')
    detect(when(signal > ${var.cluster_unassigned_shards_threshold_critical}, lasting=%{if var.cluster_unassigned_shards_lasting_duration_critical == null}None%{else}'${var.cluster_unassigned_shards_lasting_duration_critical}'%{endif}, at_least=${var.cluster_unassigned_shards_at_least_percentage_critical})).publish('CRIT')
EOF

  rule {
    description           = "is too high > ${var.cluster_unassigned_shards_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.cluster_unassigned_shards_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.cluster_unassigned_shards_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.cluster_unassigned_shards_runbook_url, var.runbook_url), "")
    tip                   = var.cluster_unassigned_shards_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.cluster_unassigned_shards_max_delay
}

resource "signalfx_detector" "pending_tasks" {
  name = format("%s %s", local.detector_name_prefix, "ElasticSearch pending tasks")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    base_filtering = filter('plugin', 'elasticsearch')
    signal = data('elasticsearch.cluster.pending-tasks', filter=base_filtering and ${module.filtering.signalflow}, rollup='average')${var.pending_tasks_aggregation_function}${var.pending_tasks_transformation_function}.publish('signal')
    detect(when(signal >= ${var.pending_tasks_threshold_critical}, lasting=%{if var.pending_tasks_lasting_duration_critical == null}None%{else}'${var.pending_tasks_lasting_duration_critical}'%{endif}, at_least=${var.pending_tasks_at_least_percentage_critical})).publish('CRIT')
    detect(when(signal > ${var.pending_tasks_threshold_major}, lasting=%{if var.pending_tasks_lasting_duration_major == null}None%{else}'${var.pending_tasks_lasting_duration_major}'%{endif}, at_least=${var.pending_tasks_at_least_percentage_major}) and (not when(signal >= ${var.pending_tasks_threshold_critical}, lasting=%{if var.pending_tasks_lasting_duration_critical == null}None%{else}'${var.pending_tasks_lasting_duration_critical}'%{endif}, at_least=${var.pending_tasks_at_least_percentage_critical}))).publish('MAJOR')
EOF

  rule {
    description           = "are too high >= ${var.pending_tasks_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.pending_tasks_disabled_critical, var.pending_tasks_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.pending_tasks_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.pending_tasks_runbook_url, var.runbook_url), "")
    tip                   = var.pending_tasks_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "are too high > ${var.pending_tasks_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.pending_tasks_disabled_major, var.pending_tasks_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.pending_tasks_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.pending_tasks_runbook_url, var.runbook_url), "")
    tip                   = var.pending_tasks_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.pending_tasks_max_delay
}

resource "signalfx_detector" "cpu_usage" {
  name = format("%s %s", local.detector_name_prefix, "ElasticSearch cpu usage")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    base_filtering = filter('node_name', '*') and filter('plugin', 'elasticsearch')
    signal = data('elasticsearch.process.cpu.percent', filter=base_filtering and ${module.filtering.signalflow}, rollup='average')${var.cpu_usage_aggregation_function}${var.cpu_usage_transformation_function}.publish('signal')
    detect(when(signal >= ${var.cpu_usage_threshold_critical}, lasting=%{if var.cpu_usage_lasting_duration_critical == null}None%{else}'${var.cpu_usage_lasting_duration_critical}'%{endif}, at_least=${var.cpu_usage_at_least_percentage_critical})).publish('CRIT')
    detect(when(signal > ${var.cpu_usage_threshold_major}, lasting=%{if var.cpu_usage_lasting_duration_major == null}None%{else}'${var.cpu_usage_lasting_duration_major}'%{endif}, at_least=${var.cpu_usage_at_least_percentage_major}) and (not when(signal >= ${var.cpu_usage_threshold_critical}, lasting=%{if var.cpu_usage_lasting_duration_critical == null}None%{else}'${var.cpu_usage_lasting_duration_critical}'%{endif}, at_least=${var.cpu_usage_at_least_percentage_critical}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high >= ${var.cpu_usage_threshold_critical}"
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

resource "signalfx_detector" "file_descriptors" {
  name = format("%s %s", local.detector_name_prefix, "ElasticSearch file descriptors")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    base_filtering = filter('node_name', '*') and filter('plugin', 'elasticsearch')
    A = data('elasticsearch.process.open_file_descriptors', filter=base_filtering and ${module.filtering.signalflow}, rollup='average')${var.file_descriptors_aggregation_function}${var.file_descriptors_transformation_function}
    B = data('elasticsearch.process.max_file_descriptors', filter=base_filtering and ${module.filtering.signalflow}, rollup='average')${var.file_descriptors_aggregation_function}${var.file_descriptors_transformation_function}
    signal = (A/B).scale(100).publish('signal')
    detect(when(signal >= ${var.file_descriptors_threshold_critical}, lasting=%{if var.file_descriptors_lasting_duration_critical == null}None%{else}'${var.file_descriptors_lasting_duration_critical}'%{endif}, at_least=${var.file_descriptors_at_least_percentage_critical})).publish('CRIT')
    detect(when(signal > ${var.file_descriptors_threshold_major}, lasting=%{if var.file_descriptors_lasting_duration_major == null}None%{else}'${var.file_descriptors_lasting_duration_major}'%{endif}, at_least=${var.file_descriptors_at_least_percentage_major}) and (not when(signal >= ${var.file_descriptors_threshold_critical}, lasting=%{if var.file_descriptors_lasting_duration_critical == null}None%{else}'${var.file_descriptors_lasting_duration_critical}'%{endif}, at_least=${var.file_descriptors_at_least_percentage_critical}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high >= ${var.file_descriptors_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.file_descriptors_disabled_critical, var.file_descriptors_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.file_descriptors_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.file_descriptors_runbook_url, var.runbook_url), "")
    tip                   = var.file_descriptors_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.file_descriptors_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.file_descriptors_disabled_major, var.file_descriptors_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.file_descriptors_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.file_descriptors_runbook_url, var.runbook_url), "")
    tip                   = var.file_descriptors_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.file_descriptors_max_delay
}

resource "signalfx_detector" "jvm_heap_memory_usage" {
  name = format("%s %s", local.detector_name_prefix, "ElasticSearch jvm heap memory usage")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    base_filtering = filter('node_name', '*') and filter('plugin', 'elasticsearch')
    signal = data('elasticsearch.jvm.mem.heap-used-percent', filter=base_filtering and ${module.filtering.signalflow}, rollup='average')${var.jvm_heap_memory_usage_aggregation_function}${var.jvm_heap_memory_usage_transformation_function}.publish('signal')
    detect(when(signal >= ${var.jvm_heap_memory_usage_threshold_critical}, lasting=%{if var.jvm_heap_memory_usage_lasting_duration_critical == null}None%{else}'${var.jvm_heap_memory_usage_lasting_duration_critical}'%{endif}, at_least=${var.jvm_heap_memory_usage_at_least_percentage_critical})).publish('CRIT')
    detect(when(signal > ${var.jvm_heap_memory_usage_threshold_major}, lasting=%{if var.jvm_heap_memory_usage_lasting_duration_major == null}None%{else}'${var.jvm_heap_memory_usage_lasting_duration_major}'%{endif}, at_least=${var.jvm_heap_memory_usage_at_least_percentage_major}) and (not when(signal >= ${var.jvm_heap_memory_usage_threshold_critical}, lasting=%{if var.jvm_heap_memory_usage_lasting_duration_critical == null}None%{else}'${var.jvm_heap_memory_usage_lasting_duration_critical}'%{endif}, at_least=${var.jvm_heap_memory_usage_at_least_percentage_critical}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high >= ${var.jvm_heap_memory_usage_threshold_critical}"
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
    base_filtering = filter('node_name', '*') and filter('plugin', 'elasticsearch')
    A = data('elasticsearch.jvm.mem.pools.young.used_in_bytes', filter=base_filtering and ${module.filtering.signalflow}, rollup='average')${var.jvm_memory_young_usage_aggregation_function}${var.jvm_memory_young_usage_transformation_function}
    B = data('elasticsearch.jvm.mem.pools.young.max_in_bytes', filter=base_filtering and ${module.filtering.signalflow}, rollup='average')${var.jvm_memory_young_usage_aggregation_function}${var.jvm_memory_young_usage_transformation_function}
    signal = (A/B).fill(0).scale(100).publish('signal')
    detect(when(signal >= ${var.jvm_memory_young_usage_threshold_major}, lasting=%{if var.jvm_memory_young_usage_lasting_duration_major == null}None%{else}'${var.jvm_memory_young_usage_lasting_duration_major}'%{endif}, at_least=${var.jvm_memory_young_usage_at_least_percentage_major})).publish('MAJOR')
    detect(when(signal > ${var.jvm_memory_young_usage_threshold_minor}, lasting=%{if var.jvm_memory_young_usage_lasting_duration_minor == null}None%{else}'${var.jvm_memory_young_usage_lasting_duration_minor}'%{endif}, at_least=${var.jvm_memory_young_usage_at_least_percentage_minor}) and (not when(signal >= ${var.jvm_memory_young_usage_threshold_major}, lasting=%{if var.jvm_memory_young_usage_lasting_duration_major == null}None%{else}'${var.jvm_memory_young_usage_lasting_duration_major}'%{endif}, at_least=${var.jvm_memory_young_usage_at_least_percentage_major}))).publish('MINOR')
EOF

  rule {
    description           = "is too high >= ${var.jvm_memory_young_usage_threshold_major}"
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
    base_filtering = filter('node_name', '*') and filter('plugin', 'elasticsearch')
    A = data('elasticsearch.jvm.mem.pools.old.used_in_bytes', filter=base_filtering and ${module.filtering.signalflow}, rollup='average')${var.jvm_memory_old_usage_aggregation_function}${var.jvm_memory_old_usage_transformation_function}
    B = data('elasticsearch.jvm.mem.pools.old.max_in_bytes', filter=base_filtering and ${module.filtering.signalflow}, rollup='average')${var.jvm_memory_old_usage_aggregation_function}${var.jvm_memory_old_usage_transformation_function}
    signal = (A/B).fill(0).scale(100).publish('signal')
    detect(when(signal >= ${var.jvm_memory_old_usage_threshold_major}, lasting=%{if var.jvm_memory_old_usage_lasting_duration_major == null}None%{else}'${var.jvm_memory_old_usage_lasting_duration_major}'%{endif}, at_least=${var.jvm_memory_old_usage_at_least_percentage_major})).publish('MAJOR')
    detect(when(signal > ${var.jvm_memory_old_usage_threshold_minor}, lasting=%{if var.jvm_memory_old_usage_lasting_duration_minor == null}None%{else}'${var.jvm_memory_old_usage_lasting_duration_minor}'%{endif}, at_least=${var.jvm_memory_old_usage_at_least_percentage_minor}) and (not when(signal >= ${var.jvm_memory_old_usage_threshold_major}, lasting=%{if var.jvm_memory_old_usage_lasting_duration_major == null}None%{else}'${var.jvm_memory_old_usage_lasting_duration_major}'%{endif}, at_least=${var.jvm_memory_old_usage_at_least_percentage_major}))).publish('MINOR')
EOF

  rule {
    description           = "is too high >= ${var.jvm_memory_old_usage_threshold_major}"
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

resource "signalfx_detector" "jvm_gc_old_collection_latency" {
  name = format("%s %s", local.detector_name_prefix, "ElasticSearch jvm gc old collection latency")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    base_filtering = filter('node_name', '*') and filter('plugin', 'elasticsearch')
    A = data('elasticsearch.jvm.gc.old-time', filter=base_filtering and ${module.filtering.signalflow}, rollup='delta', extrapolation='zero')${var.jvm_gc_old_collection_latency_aggregation_function}${var.jvm_gc_old_collection_latency_transformation_function}
    B = data('elasticsearch.jvm.gc.old-count', filter=base_filtering and ${module.filtering.signalflow}, rollup='delta', extrapolation='zero')${var.jvm_gc_old_collection_latency_aggregation_function}${var.jvm_gc_old_collection_latency_transformation_function}
    signal = (A/B).fill(0).publish('signal')
    detect(when(signal >= ${var.jvm_gc_old_collection_latency_threshold_major}, lasting=%{if var.jvm_gc_old_collection_latency_lasting_duration_major == null}None%{else}'${var.jvm_gc_old_collection_latency_lasting_duration_major}'%{endif}, at_least=${var.jvm_gc_old_collection_latency_at_least_percentage_major})).publish('MAJOR')
    detect(when(signal > ${var.jvm_gc_old_collection_latency_threshold_minor}, lasting=%{if var.jvm_gc_old_collection_latency_lasting_duration_minor == null}None%{else}'${var.jvm_gc_old_collection_latency_lasting_duration_minor}'%{endif}, at_least=${var.jvm_gc_old_collection_latency_at_least_percentage_minor}) and (not when(signal >= ${var.jvm_gc_old_collection_latency_threshold_major}, lasting=%{if var.jvm_gc_old_collection_latency_lasting_duration_major == null}None%{else}'${var.jvm_gc_old_collection_latency_lasting_duration_major}'%{endif}, at_least=${var.jvm_gc_old_collection_latency_at_least_percentage_major}))).publish('MINOR')
EOF

  rule {
    description           = "is too high >= ${var.jvm_gc_old_collection_latency_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.jvm_gc_old_collection_latency_disabled_major, var.jvm_gc_old_collection_latency_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.jvm_gc_old_collection_latency_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.jvm_gc_old_collection_latency_runbook_url, var.runbook_url), "")
    tip                   = var.jvm_gc_old_collection_latency_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.jvm_gc_old_collection_latency_threshold_minor}"
    severity              = "Minor"
    detect_label          = "MINOR"
    disabled              = coalesce(var.jvm_gc_old_collection_latency_disabled_minor, var.jvm_gc_old_collection_latency_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.jvm_gc_old_collection_latency_notifications, "minor", []), var.notifications.minor), null)
    runbook_url           = try(coalesce(var.jvm_gc_old_collection_latency_runbook_url, var.runbook_url), "")
    tip                   = var.jvm_gc_old_collection_latency_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.jvm_gc_old_collection_latency_max_delay
}

resource "signalfx_detector" "jvm_gc_young_collection_latency" {
  name = format("%s %s", local.detector_name_prefix, "ElasticSearch jvm gc young collection latency")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    base_filtering = filter('node_name', '*') and filter('plugin', 'elasticsearch')
    A = data('elasticsearch.jvm.gc.time', filter=base_filtering and ${module.filtering.signalflow}, rollup='delta', extrapolation='zero')${var.jvm_gc_young_collection_latency_aggregation_function}${var.jvm_gc_young_collection_latency_transformation_function}
    B = data('elasticsearch.jvm.gc.count', filter=base_filtering and ${module.filtering.signalflow}, rollup='delta', extrapolation='zero')${var.jvm_gc_young_collection_latency_aggregation_function}${var.jvm_gc_young_collection_latency_transformation_function}
    signal = (A/B).fill(0).publish('signal')
    detect(when(signal >= ${var.jvm_gc_young_collection_latency_threshold_major}, lasting=%{if var.jvm_gc_young_collection_latency_lasting_duration_major == null}None%{else}'${var.jvm_gc_young_collection_latency_lasting_duration_major}'%{endif}, at_least=${var.jvm_gc_young_collection_latency_at_least_percentage_major})).publish('MAJOR')
    detect(when(signal > ${var.jvm_gc_young_collection_latency_threshold_minor}, lasting=%{if var.jvm_gc_young_collection_latency_lasting_duration_minor == null}None%{else}'${var.jvm_gc_young_collection_latency_lasting_duration_minor}'%{endif}, at_least=${var.jvm_gc_young_collection_latency_at_least_percentage_minor}) and (not when(signal >= ${var.jvm_gc_young_collection_latency_threshold_major}, lasting=%{if var.jvm_gc_young_collection_latency_lasting_duration_major == null}None%{else}'${var.jvm_gc_young_collection_latency_lasting_duration_major}'%{endif}, at_least=${var.jvm_gc_young_collection_latency_at_least_percentage_major}))).publish('MINOR')
EOF

  rule {
    description           = "is too high >= ${var.jvm_gc_young_collection_latency_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.jvm_gc_young_collection_latency_disabled_major, var.jvm_gc_young_collection_latency_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.jvm_gc_young_collection_latency_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.jvm_gc_young_collection_latency_runbook_url, var.runbook_url), "")
    tip                   = var.jvm_gc_young_collection_latency_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.jvm_gc_young_collection_latency_threshold_minor}"
    severity              = "Minor"
    detect_label          = "MINOR"
    disabled              = coalesce(var.jvm_gc_young_collection_latency_disabled_minor, var.jvm_gc_young_collection_latency_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.jvm_gc_young_collection_latency_notifications, "minor", []), var.notifications.minor), null)
    runbook_url           = try(coalesce(var.jvm_gc_young_collection_latency_runbook_url, var.runbook_url), "")
    tip                   = var.jvm_gc_young_collection_latency_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.jvm_gc_young_collection_latency_max_delay
}

resource "signalfx_detector" "indexing_latency" {
  name = format("%s %s", local.detector_name_prefix, "ElasticSearch indexing latency")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    base_filtering = filter('node_name', '*') and filter('plugin', 'elasticsearch')
    A = data('elasticsearch.indices.indexing.index-time', filter=base_filtering and ${module.filtering.signalflow}, rollup='delta', extrapolation='zero')${var.indexing_latency_aggregation_function}${var.indexing_latency_transformation_function}
    B = data('elasticsearch.indices.indexing.index-total', filter=base_filtering and ${module.filtering.signalflow}, rollup='delta', extrapolation='zero')${var.indexing_latency_aggregation_function}${var.indexing_latency_transformation_function}
    signal = (A/B).fill(0).publish('signal')
    detect(when(signal >= ${var.indexing_latency_threshold_major}, lasting=%{if var.indexing_latency_lasting_duration_major == null}None%{else}'${var.indexing_latency_lasting_duration_major}'%{endif}, at_least=${var.indexing_latency_at_least_percentage_major})).publish('MAJOR')
    detect(when(signal > ${var.indexing_latency_threshold_minor}, lasting=%{if var.indexing_latency_lasting_duration_minor == null}None%{else}'${var.indexing_latency_lasting_duration_minor}'%{endif}, at_least=${var.indexing_latency_at_least_percentage_minor}) and (not when(signal >= ${var.indexing_latency_threshold_major}, lasting=%{if var.indexing_latency_lasting_duration_major == null}None%{else}'${var.indexing_latency_lasting_duration_major}'%{endif}, at_least=${var.indexing_latency_at_least_percentage_major}))).publish('MINOR')
EOF

  rule {
    description           = "is too high >= ${var.indexing_latency_threshold_major}"
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

resource "signalfx_detector" "flush_latency" {
  name = format("%s %s", local.detector_name_prefix, "ElasticSearch flush latency")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    base_filtering = filter('node_name', '*') and filter('plugin', 'elasticsearch')
    A = data('elasticsearch.indices.flush.total-time', filter=base_filtering and ${module.filtering.signalflow}, rollup='delta', extrapolation='zero')${var.flush_latency_aggregation_function}${var.flush_latency_transformation_function}
    B = data('elasticsearch.indices.flush.total', filter=base_filtering and ${module.filtering.signalflow}, rollup='delta', extrapolation='zero')${var.flush_latency_aggregation_function}${var.flush_latency_transformation_function}
    signal = (A/B).fill(0).publish('signal')
    detect(when(signal >= ${var.flush_latency_threshold_major}, lasting=%{if var.flush_latency_lasting_duration_major == null}None%{else}'${var.flush_latency_lasting_duration_major}'%{endif}, at_least=${var.flush_latency_at_least_percentage_major})).publish('MAJOR')
    detect(when(signal > ${var.flush_latency_threshold_minor}, lasting=%{if var.flush_latency_lasting_duration_minor == null}None%{else}'${var.flush_latency_lasting_duration_minor}'%{endif}, at_least=${var.flush_latency_at_least_percentage_minor}) and (not when(signal >= ${var.flush_latency_threshold_major}, lasting=%{if var.flush_latency_lasting_duration_major == null}None%{else}'${var.flush_latency_lasting_duration_major}'%{endif}, at_least=${var.flush_latency_at_least_percentage_major}))).publish('MINOR')
EOF

  rule {
    description           = "is too high >= ${var.flush_latency_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.flush_latency_disabled_major, var.flush_latency_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.flush_latency_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.flush_latency_runbook_url, var.runbook_url), "")
    tip                   = var.flush_latency_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.flush_latency_threshold_minor}"
    severity              = "Minor"
    detect_label          = "MINOR"
    disabled              = coalesce(var.flush_latency_disabled_minor, var.flush_latency_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.flush_latency_notifications, "minor", []), var.notifications.minor), null)
    runbook_url           = try(coalesce(var.flush_latency_runbook_url, var.runbook_url), "")
    tip                   = var.flush_latency_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.flush_latency_max_delay
}

resource "signalfx_detector" "search_latency" {
  name = format("%s %s", local.detector_name_prefix, "ElasticSearch search latency")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    base_filtering = filter('node_name', '*') and filter('plugin', 'elasticsearch')
    A = data('elasticsearch.indices.search.query-time', filter=base_filtering and ${module.filtering.signalflow}, rollup='delta', extrapolation='zero')${var.search_latency_aggregation_function}${var.search_latency_transformation_function}
    B = data('elasticsearch.indices.search.query-total', filter=base_filtering and ${module.filtering.signalflow}, rollup='delta', extrapolation='zero')${var.search_latency_aggregation_function}${var.search_latency_transformation_function}
    signal = (A/B).fill(0).publish('signal')
    detect(when(signal >= ${var.search_latency_threshold_major}, lasting=%{if var.search_latency_lasting_duration_major == null}None%{else}'${var.search_latency_lasting_duration_major}'%{endif}, at_least=${var.search_latency_at_least_percentage_major})).publish('MAJOR')
    detect(when(signal > ${var.search_latency_threshold_minor}, lasting=%{if var.search_latency_lasting_duration_minor == null}None%{else}'${var.search_latency_lasting_duration_minor}'%{endif}, at_least=${var.search_latency_at_least_percentage_minor}) and (not when(signal >= ${var.search_latency_threshold_major}, lasting=%{if var.search_latency_lasting_duration_major == null}None%{else}'${var.search_latency_lasting_duration_major}'%{endif}, at_least=${var.search_latency_at_least_percentage_major}))).publish('MINOR')
EOF

  rule {
    description           = "is too high >= ${var.search_latency_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.search_latency_disabled_major, var.search_latency_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.search_latency_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.search_latency_runbook_url, var.runbook_url), "")
    tip                   = var.search_latency_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.search_latency_threshold_minor}"
    severity              = "Minor"
    detect_label          = "MINOR"
    disabled              = coalesce(var.search_latency_disabled_minor, var.search_latency_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.search_latency_notifications, "minor", []), var.notifications.minor), null)
    runbook_url           = try(coalesce(var.search_latency_runbook_url, var.runbook_url), "")
    tip                   = var.search_latency_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.search_latency_max_delay
}

resource "signalfx_detector" "fetch_latency" {
  name = format("%s %s", local.detector_name_prefix, "ElasticSearch fetch latency")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    base_filtering = filter('node_name', '*') and filter('plugin', 'elasticsearch')
    A = data('elasticsearch.indices.search.fetch-time', filter=base_filtering and ${module.filtering.signalflow}, rollup='delta', extrapolation='zero')${var.fetch_latency_aggregation_function}${var.fetch_latency_transformation_function}
    B = data('elasticsearch.indices.search.fetch-total', filter=base_filtering and ${module.filtering.signalflow}, rollup='delta', extrapolation='zero')${var.fetch_latency_aggregation_function}${var.fetch_latency_transformation_function}
    signal = (A/B).fill(0).publish('signal')
    detect(when(signal >= ${var.fetch_latency_threshold_major}, lasting=%{if var.fetch_latency_lasting_duration_major == null}None%{else}'${var.fetch_latency_lasting_duration_major}'%{endif}, at_least=${var.fetch_latency_at_least_percentage_major})).publish('MAJOR')
    detect(when(signal > ${var.fetch_latency_threshold_minor}, lasting=%{if var.fetch_latency_lasting_duration_minor == null}None%{else}'${var.fetch_latency_lasting_duration_minor}'%{endif}, at_least=${var.fetch_latency_at_least_percentage_minor}) and (not when(signal >= ${var.fetch_latency_threshold_major}, lasting=%{if var.fetch_latency_lasting_duration_major == null}None%{else}'${var.fetch_latency_lasting_duration_major}'%{endif}, at_least=${var.fetch_latency_at_least_percentage_major}))).publish('MINOR')
EOF

  rule {
    description           = "is too high >= ${var.fetch_latency_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.fetch_latency_disabled_major, var.fetch_latency_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.fetch_latency_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.fetch_latency_runbook_url, var.runbook_url), "")
    tip                   = var.fetch_latency_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.fetch_latency_threshold_minor}"
    severity              = "Minor"
    detect_label          = "MINOR"
    disabled              = coalesce(var.fetch_latency_disabled_minor, var.fetch_latency_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.fetch_latency_notifications, "minor", []), var.notifications.minor), null)
    runbook_url           = try(coalesce(var.fetch_latency_runbook_url, var.runbook_url), "")
    tip                   = var.fetch_latency_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.fetch_latency_max_delay
}

resource "signalfx_detector" "field_data_evictions_change" {
  name = format("%s %s", local.detector_name_prefix, "ElasticSearch field_data evictions change")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    base_filtering = filter('node_name', '*') and filter('plugin', 'elasticsearch')
    A = data('elasticsearch.indices.fielddata.evictions', filter=base_filtering and ${module.filtering.signalflow}, rollup='delta', extrapolation='zero')${var.field_data_evictions_change_aggregation_function}${var.field_data_evictions_change_transformation_function}
    signal = A.rateofchange().publish('signal')
    detect(when(signal >= ${var.field_data_evictions_change_threshold_major}, lasting=%{if var.field_data_evictions_change_lasting_duration_major == null}None%{else}'${var.field_data_evictions_change_lasting_duration_major}'%{endif}, at_least=${var.field_data_evictions_change_at_least_percentage_major})).publish('MAJOR')
    detect(when(signal > ${var.field_data_evictions_change_threshold_minor}, lasting=%{if var.field_data_evictions_change_lasting_duration_minor == null}None%{else}'${var.field_data_evictions_change_lasting_duration_minor}'%{endif}, at_least=${var.field_data_evictions_change_at_least_percentage_minor}) and (not when(signal >= ${var.field_data_evictions_change_threshold_major}, lasting=%{if var.field_data_evictions_change_lasting_duration_major == null}None%{else}'${var.field_data_evictions_change_lasting_duration_major}'%{endif}, at_least=${var.field_data_evictions_change_at_least_percentage_major}))).publish('MINOR')
EOF

  rule {
    description           = "is too high >= ${var.field_data_evictions_change_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.field_data_evictions_change_disabled_major, var.field_data_evictions_change_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.field_data_evictions_change_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.field_data_evictions_change_runbook_url, var.runbook_url), "")
    tip                   = var.field_data_evictions_change_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.field_data_evictions_change_threshold_minor}"
    severity              = "Minor"
    detect_label          = "MINOR"
    disabled              = coalesce(var.field_data_evictions_change_disabled_minor, var.field_data_evictions_change_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.field_data_evictions_change_notifications, "minor", []), var.notifications.minor), null)
    runbook_url           = try(coalesce(var.field_data_evictions_change_runbook_url, var.runbook_url), "")
    tip                   = var.field_data_evictions_change_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.field_data_evictions_change_max_delay
}

resource "signalfx_detector" "task_time_in_queue_change" {
  name = format("%s %s", local.detector_name_prefix, "ElasticSearch task time in queue change")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    base_filtering = filter('plugin', 'elasticsearch')
    A = data('elasticsearch.cluster.task-max-wait-time', filter=base_filtering and ${module.filtering.signalflow}, rollup='average')${var.task_time_in_queue_change_aggregation_function}${var.task_time_in_queue_change_transformation_function}
    signal = A.rateofchange().publish('signal')
    detect(when(signal >= ${var.task_time_in_queue_change_threshold_major}, lasting=%{if var.task_time_in_queue_change_lasting_duration_major == null}None%{else}'${var.task_time_in_queue_change_lasting_duration_major}'%{endif}, at_least=${var.task_time_in_queue_change_at_least_percentage_major})).publish('MAJOR')
    detect(when(signal > ${var.task_time_in_queue_change_threshold_minor}, lasting=%{if var.task_time_in_queue_change_lasting_duration_minor == null}None%{else}'${var.task_time_in_queue_change_lasting_duration_minor}'%{endif}, at_least=${var.task_time_in_queue_change_at_least_percentage_minor}) and (not when(signal >= ${var.task_time_in_queue_change_threshold_major}, lasting=%{if var.task_time_in_queue_change_lasting_duration_major == null}None%{else}'${var.task_time_in_queue_change_lasting_duration_major}'%{endif}, at_least=${var.task_time_in_queue_change_at_least_percentage_major}))).publish('MINOR')
EOF

  rule {
    description           = "is too high >= ${var.task_time_in_queue_change_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.task_time_in_queue_change_disabled_major, var.task_time_in_queue_change_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.task_time_in_queue_change_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.task_time_in_queue_change_runbook_url, var.runbook_url), "")
    tip                   = var.task_time_in_queue_change_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.task_time_in_queue_change_threshold_minor}"
    severity              = "Minor"
    detect_label          = "MINOR"
    disabled              = coalesce(var.task_time_in_queue_change_disabled_minor, var.task_time_in_queue_change_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.task_time_in_queue_change_notifications, "minor", []), var.notifications.minor), null)
    runbook_url           = try(coalesce(var.task_time_in_queue_change_runbook_url, var.runbook_url), "")
    tip                   = var.task_time_in_queue_change_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.task_time_in_queue_change_max_delay
}

