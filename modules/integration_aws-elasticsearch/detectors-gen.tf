resource "signalfx_detector" "heartbeat" {
  name = format("%s %s", local.detector_name_prefix, "AWS Elasticsearch heartbeat")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    from signalfx.detectors.not_reporting import not_reporting
    base_filtering = filter('namespace', 'AWS/ES')
    signal = data('Nodes', filter=base_filtering and filter('stat', 'mean') and ${module.filtering.signalflow})${var.heartbeat_aggregation_function}.publish('signal')
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

resource "signalfx_detector" "jvm_memory_pressure" {
  name = format("%s %s", local.detector_name_prefix, "AWS Elasticsearch jvm memory pressure")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  viz_options {
    label        = "signal"
    value_suffix = "%"
  }

  program_text = <<-EOF
    base_filtering = filter('namespace', 'AWS/ES') and filter('stat', 'upper') and filter('NodeId', '*')
    signal = data('JVMMemoryPressure', filter=base_filtering and ${module.filtering.signalflow})${var.jvm_memory_pressure_aggregation_function}${var.jvm_memory_pressure_transformation_function}.publish('signal')
    detect(when(signal > ${var.jvm_memory_pressure_threshold_critical}, lasting=%{if var.jvm_memory_pressure_lasting_duration_critical == null}None%{else}'${var.jvm_memory_pressure_lasting_duration_critical}'%{endif}, at_least=${var.jvm_memory_pressure_at_least_percentage_critical})).publish('CRIT')
    detect(when(signal > ${var.jvm_memory_pressure_threshold_major}, lasting=%{if var.jvm_memory_pressure_lasting_duration_major == null}None%{else}'${var.jvm_memory_pressure_lasting_duration_major}'%{endif}, at_least=${var.jvm_memory_pressure_at_least_percentage_major}) and (not when(signal > ${var.jvm_memory_pressure_threshold_critical}, lasting=%{if var.jvm_memory_pressure_lasting_duration_critical == null}None%{else}'${var.jvm_memory_pressure_lasting_duration_critical}'%{endif}, at_least=${var.jvm_memory_pressure_at_least_percentage_critical}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.jvm_memory_pressure_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.jvm_memory_pressure_disabled_critical, var.jvm_memory_pressure_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.jvm_memory_pressure_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.jvm_memory_pressure_runbook_url, var.runbook_url), "")
    tip                   = var.jvm_memory_pressure_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.jvm_memory_pressure_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.jvm_memory_pressure_disabled_major, var.jvm_memory_pressure_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.jvm_memory_pressure_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.jvm_memory_pressure_runbook_url, var.runbook_url), "")
    tip                   = var.jvm_memory_pressure_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.jvm_memory_pressure_max_delay
}

resource "signalfx_detector" "fourxx_http_response" {
  name = format("%s %s", local.detector_name_prefix, "AWS Elasticsearch 4xx http response")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  viz_options {
    label        = "signal"
    value_suffix = "%"
  }

  program_text = <<-EOF
    base_filtering = filter('namespace', 'AWS/ES') and filter('stat', 'sum')
    A = data('4xx', filter=base_filtering and ${module.filtering.signalflow})${var.fourxx_http_response_aggregation_function}${var.fourxx_http_response_transformation_function}
    B = data('2xx', filter=base_filtering and ${module.filtering.signalflow})${var.fourxx_http_response_aggregation_function}${var.fourxx_http_response_transformation_function}
    signal = (A/(A+B)*100).publish('signal')
    detect(when(signal > ${var.fourxx_http_response_threshold_critical}, lasting=%{if var.fourxx_http_response_lasting_duration_critical == null}None%{else}'${var.fourxx_http_response_lasting_duration_critical}'%{endif}, at_least=${var.fourxx_http_response_at_least_percentage_critical})).publish('CRIT')
    detect(when(signal > ${var.fourxx_http_response_threshold_major}, lasting=%{if var.fourxx_http_response_lasting_duration_major == null}None%{else}'${var.fourxx_http_response_lasting_duration_major}'%{endif}, at_least=${var.fourxx_http_response_at_least_percentage_major}) and (not when(signal > ${var.fourxx_http_response_threshold_critical}, lasting=%{if var.fourxx_http_response_lasting_duration_critical == null}None%{else}'${var.fourxx_http_response_lasting_duration_critical}'%{endif}, at_least=${var.fourxx_http_response_at_least_percentage_critical}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.fourxx_http_response_threshold_critical}%"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.fourxx_http_response_disabled_critical, var.fourxx_http_response_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.fourxx_http_response_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.fourxx_http_response_runbook_url, var.runbook_url), "")
    tip                   = var.fourxx_http_response_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.fourxx_http_response_threshold_major}%"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.fourxx_http_response_disabled_major, var.fourxx_http_response_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.fourxx_http_response_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.fourxx_http_response_runbook_url, var.runbook_url), "")
    tip                   = var.fourxx_http_response_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.fourxx_http_response_max_delay
}

resource "signalfx_detector" "fivexx_http_response" {
  name = format("%s %s", local.detector_name_prefix, "AWS Elasticsearch 5xx http response")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  viz_options {
    label        = "elasticsearch_signal"
    value_suffix = "%"
  }

  program_text = <<-EOF
    base_filtering = filter('namespace', 'AWS/ES') and filter('stat', 'sum')
    error_stream = data('5xx', filter=base_filtering and ${module.filtering.signalflow})${var.fivexx_http_response_aggregation_function}${var.fivexx_http_response_transformation_function}
    opensearch_stream = data('OpenSearchRequests', filter=base_filtering and ${module.filtering.signalflow})${var.fivexx_http_response_aggregation_function}${var.fivexx_http_response_transformation_function}
    elasticsearch_stream = data('ElasticsearchRequests', filter=base_filtering and ${module.filtering.signalflow})${var.fivexx_http_response_aggregation_function}${var.fivexx_http_response_transformation_function}
    opensearch_signal = (error_stream/opensearch_stream*100).publish('opensearch_signal')
    elasticsearch_signal = (error_stream/elasticsearch_stream*100).publish('elasticsearch_signal')
    detect(when(opensearch_signal > ${var.fivexx_http_response_threshold_opensearch_critical}, lasting=%{if var.fivexx_http_response_lasting_duration_opensearch_critical == null}None%{else}'${var.fivexx_http_response_lasting_duration_opensearch_critical}'%{endif}, at_least=${var.fivexx_http_response_at_least_percentage_opensearch_critical})).publish('OPENSEARCH_CRIT')
    detect(when(opensearch_signal > ${var.fivexx_http_response_threshold_opensearch_major}, lasting=%{if var.fivexx_http_response_lasting_duration_opensearch_major == null}None%{else}'${var.fivexx_http_response_lasting_duration_opensearch_major}'%{endif}, at_least=${var.fivexx_http_response_at_least_percentage_opensearch_major}) and (not when(opensearch_signal > ${var.fivexx_http_response_threshold_opensearch_critical}, lasting=%{if var.fivexx_http_response_lasting_duration_opensearch_critical == null}None%{else}'${var.fivexx_http_response_lasting_duration_opensearch_critical}'%{endif}, at_least=${var.fivexx_http_response_at_least_percentage_opensearch_critical}))).publish('OPENSEARCH_MAJOR')
    detect(when(elasticsearch_signal > ${var.fivexx_http_response_threshold_elasticsearch_critical}, lasting=%{if var.fivexx_http_response_lasting_duration_elasticsearch_critical == null}None%{else}'${var.fivexx_http_response_lasting_duration_elasticsearch_critical}'%{endif}, at_least=${var.fivexx_http_response_at_least_percentage_elasticsearch_critical})).publish('ELASTICSEARCH_CRIT')
    detect(when(elasticsearch_signal > ${var.fivexx_http_response_threshold_elasticsearch_major}, lasting=%{if var.fivexx_http_response_lasting_duration_elasticsearch_major == null}None%{else}'${var.fivexx_http_response_lasting_duration_elasticsearch_major}'%{endif}, at_least=${var.fivexx_http_response_at_least_percentage_elasticsearch_major}) and (not when(elasticsearch_signal > ${var.fivexx_http_response_threshold_elasticsearch_critical}, lasting=%{if var.fivexx_http_response_lasting_duration_elasticsearch_critical == null}None%{else}'${var.fivexx_http_response_lasting_duration_elasticsearch_critical}'%{endif}, at_least=${var.fivexx_http_response_at_least_percentage_elasticsearch_critical}))).publish('ELASTICSEARCH_MAJOR')
EOF

  rule {
    description           = "is too high > ${var.fivexx_http_response_threshold_opensearch_critical}%"
    severity              = "Critical"
    detect_label          = "OPENSEARCH_CRIT"
    disabled              = coalesce(var.fivexx_http_response_disabled_opensearch_critical, var.fivexx_http_response_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.fivexx_http_response_notifications, "opensearch_critical", []), var.notifications.opensearch_critical), null)
    runbook_url           = try(coalesce(var.fivexx_http_response_runbook_url, var.runbook_url), "")
    tip                   = var.fivexx_http_response_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.fivexx_http_response_threshold_opensearch_major}%"
    severity              = "Major"
    detect_label          = "OPENSEARCH_MAJOR"
    disabled              = coalesce(var.fivexx_http_response_disabled_opensearch_major, var.fivexx_http_response_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.fivexx_http_response_notifications, "opensearch_major", []), var.notifications.opensearch_major), null)
    runbook_url           = try(coalesce(var.fivexx_http_response_runbook_url, var.runbook_url), "")
    tip                   = var.fivexx_http_response_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.fivexx_http_response_threshold_elasticsearch_critical}%"
    severity              = "Critical"
    detect_label          = "ELASTICSEARCH_CRIT"
    disabled              = coalesce(var.fivexx_http_response_disabled_elasticsearch_critical, var.fivexx_http_response_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.fivexx_http_response_notifications, "elasticsearch_critical", []), var.notifications.elasticsearch_critical), null)
    runbook_url           = try(coalesce(var.fivexx_http_response_runbook_url, var.runbook_url), "")
    tip                   = var.fivexx_http_response_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.fivexx_http_response_threshold_elasticsearch_major}%"
    severity              = "Major"
    detect_label          = "ELASTICSEARCH_MAJOR"
    disabled              = coalesce(var.fivexx_http_response_disabled_elasticsearch_major, var.fivexx_http_response_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.fivexx_http_response_notifications, "elasticsearch_major", []), var.notifications.elasticsearch_major), null)
    runbook_url           = try(coalesce(var.fivexx_http_response_runbook_url, var.runbook_url), "")
    tip                   = var.fivexx_http_response_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.fivexx_http_response_max_delay
}

resource "signalfx_detector" "shard_count" {
  name = format("%s %s", local.detector_name_prefix, "AWS Elasticsearch shard count")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    base_filtering = filter('namespace', 'AWS/ES') and filter('stat', 'upper') and filter('NodeId', '*')
    A = data('ShardCount', filter=base_filtering and ${module.filtering.signalflow})${var.shard_count_aggregation_function}${var.shard_count_transformation_function}
    signal = A.sum(by=['NodeId']).publish('signal')
    detect(when(signal > ${var.shard_count_threshold_critical}, lasting=%{if var.shard_count_lasting_duration_critical == null}None%{else}'${var.shard_count_lasting_duration_critical}'%{endif}, at_least=${var.shard_count_at_least_percentage_critical})).publish('CRIT')
    detect(when(signal > ${var.shard_count_threshold_major}, lasting=%{if var.shard_count_lasting_duration_major == null}None%{else}'${var.shard_count_lasting_duration_major}'%{endif}, at_least=${var.shard_count_at_least_percentage_major}) and (not when(signal > ${var.shard_count_threshold_critical}, lasting=%{if var.shard_count_lasting_duration_critical == null}None%{else}'${var.shard_count_lasting_duration_critical}'%{endif}, at_least=${var.shard_count_at_least_percentage_critical}))).publish('MAJOR')
EOF

  rule {
    description           = "is too high > ${var.shard_count_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.shard_count_disabled_critical, var.shard_count_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.shard_count_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.shard_count_runbook_url, var.runbook_url), "")
    tip                   = var.shard_count_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.shard_count_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.shard_count_disabled_major, var.shard_count_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.shard_count_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.shard_count_runbook_url, var.runbook_url), "")
    tip                   = var.shard_count_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.shard_count_max_delay
}

resource "signalfx_detector" "cluster_status" {
  name = format("%s %s", local.detector_name_prefix, "AWS Elasticsearch cluster status")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    base_filtering = filter('namespace', 'AWS/ES') and filter('stat', 'upper')
    red = data('ClusterStatus.red', filter=base_filtering and ${module.filtering.signalflow})${var.cluster_status_aggregation_function}${var.cluster_status_transformation_function}.publish('red')
    yellow = data('ClusterStatus.yellow', filter=base_filtering and ${module.filtering.signalflow})${var.cluster_status_aggregation_function}${var.cluster_status_transformation_function}.publish('yellow')
    detect(when(red >= ${var.cluster_status_threshold_critical}, lasting=%{if var.cluster_status_lasting_duration_critical == null}None%{else}'${var.cluster_status_lasting_duration_critical}'%{endif}, at_least=${var.cluster_status_at_least_percentage_critical})).publish('CRIT')
    detect(when(yellow >= ${var.cluster_status_threshold_major}, lasting=%{if var.cluster_status_lasting_duration_major == null}None%{else}'${var.cluster_status_lasting_duration_major}'%{endif}, at_least=${var.cluster_status_at_least_percentage_major})).publish('MAJOR')
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

resource "signalfx_detector" "free_space" {
  name = format("%s %s", local.detector_name_prefix, "AWS Elasticsearch free storage space")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  viz_options {
    label      = "signal"
    value_unit = "Gibibyte"
  }

  program_text = <<-EOF
    base_filtering = filter('namespace', 'AWS/ES')
    signal = data('FreeStorageSpace', filter=base_filtering and filter('stat', 'lower') and filter('NodeId', '*') and ${module.filtering.signalflow})${var.free_space_transformation_function}.publish('signal')
    detect(when(signal < ${var.free_space_threshold_major}, lasting=%{if var.free_space_lasting_duration_major == null}None%{else}'${var.free_space_lasting_duration_major}'%{endif}, at_least=${var.free_space_at_least_percentage_major}) and (not when(signal < ${var.free_space_threshold_critical}, lasting=%{if var.free_space_lasting_duration_critical == null}None%{else}'${var.free_space_lasting_duration_critical}'%{endif}, at_least=${var.free_space_at_least_percentage_critical}))).publish('MAJOR')
    detect(when(signal < ${var.free_space_threshold_critical}, lasting=%{if var.free_space_lasting_duration_critical == null}None%{else}'${var.free_space_lasting_duration_critical}'%{endif}, at_least=${var.free_space_at_least_percentage_critical})).publish('CRIT')
EOF

  rule {
    description           = "is too low < ${var.free_space_threshold_major}Gibibyte"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.free_space_disabled_major, var.free_space_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.free_space_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.free_space_runbook_url, var.runbook_url), "")
    tip                   = var.free_space_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too low < ${var.free_space_threshold_critical}Gibibyte"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.free_space_disabled_critical, var.free_space_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.free_space_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.free_space_runbook_url, var.runbook_url), "")
    tip                   = var.free_space_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.free_space_max_delay
}

resource "signalfx_detector" "ultrawarm_free_space" {
  name = format("%s %s", local.detector_name_prefix, "AWS Elasticsearch ultrawarm free storage space")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  viz_options {
    label      = "signal"
    value_unit = "Gibibyte"
  }

  program_text = <<-EOF
    base_filtering = filter('namespace', 'AWS/ES')
    signal = data('WarmFreeStorageSpace', filter=base_filtering and filter('stat', 'lower') and filter('NodeId', '*') and ${module.filtering.signalflow})${var.ultrawarm_free_space_transformation_function}.publish('signal')
    detect(when(signal < ${var.ultrawarm_free_space_threshold_major}, lasting=%{if var.ultrawarm_free_space_lasting_duration_major == null}None%{else}'${var.ultrawarm_free_space_lasting_duration_major}'%{endif}, at_least=${var.ultrawarm_free_space_at_least_percentage_major}) and (not when(signal < ${var.ultrawarm_free_space_threshold_critical}, lasting=%{if var.ultrawarm_free_space_lasting_duration_critical == null}None%{else}'${var.ultrawarm_free_space_lasting_duration_critical}'%{endif}, at_least=${var.ultrawarm_free_space_at_least_percentage_critical}))).publish('MAJOR')
    detect(when(signal < ${var.ultrawarm_free_space_threshold_critical}, lasting=%{if var.ultrawarm_free_space_lasting_duration_critical == null}None%{else}'${var.ultrawarm_free_space_lasting_duration_critical}'%{endif}, at_least=${var.ultrawarm_free_space_at_least_percentage_critical})).publish('CRIT')
EOF

  rule {
    description           = "is too low < ${var.ultrawarm_free_space_threshold_major}Gibibyte"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.ultrawarm_free_space_disabled_major, var.ultrawarm_free_space_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.ultrawarm_free_space_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.ultrawarm_free_space_runbook_url, var.runbook_url), "")
    tip                   = var.ultrawarm_free_space_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too low < ${var.ultrawarm_free_space_threshold_critical}Gibibyte"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.ultrawarm_free_space_disabled_critical, var.ultrawarm_free_space_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.ultrawarm_free_space_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.ultrawarm_free_space_runbook_url, var.runbook_url), "")
    tip                   = var.ultrawarm_free_space_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.ultrawarm_free_space_max_delay
}

resource "signalfx_detector" "cluster_cpu" {
  name = format("%s %s", local.detector_name_prefix, "AWS Elasticsearch cpu utilization")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    base_filtering = filter('namespace', 'AWS/ES') and filter('stat', 'upper') and filter('NodeId', '*')
    data_node_cpu = data('CPUUtilization', filter=base_filtering and ${module.filtering.signalflow})${var.cluster_cpu_transformation_function}
    warm_node_cpu = data('WarmCPUUtilization', filter=base_filtering and ${module.filtering.signalflow})${var.cluster_cpu_transformation_function}
    signal = union(data_node_cpu, warm_node_cpu).publish('signal')
    detect(when(signal > ${var.cluster_cpu_threshold_major}, lasting=%{if var.cluster_cpu_lasting_duration_major == null}None%{else}'${var.cluster_cpu_lasting_duration_major}'%{endif}, at_least=${var.cluster_cpu_at_least_percentage_major}) and (not when(signal > ${var.cluster_cpu_threshold_critical}, lasting=%{if var.cluster_cpu_lasting_duration_critical == null}None%{else}'${var.cluster_cpu_lasting_duration_critical}'%{endif}, at_least=${var.cluster_cpu_at_least_percentage_critical}))).publish('MAJOR')
    detect(when(signal > ${var.cluster_cpu_threshold_critical}, lasting=%{if var.cluster_cpu_lasting_duration_critical == null}None%{else}'${var.cluster_cpu_lasting_duration_critical}'%{endif}, at_least=${var.cluster_cpu_at_least_percentage_critical})).publish('CRIT')
EOF

  rule {
    description           = "is too high > ${var.cluster_cpu_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.cluster_cpu_disabled_major, var.cluster_cpu_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.cluster_cpu_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.cluster_cpu_runbook_url, var.runbook_url), "")
    tip                   = var.cluster_cpu_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.cluster_cpu_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.cluster_cpu_disabled_critical, var.cluster_cpu_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.cluster_cpu_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.cluster_cpu_runbook_url, var.runbook_url), "")
    tip                   = var.cluster_cpu_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.cluster_cpu_max_delay
}

resource "signalfx_detector" "master_cpu" {
  name = format("%s %s", local.detector_name_prefix, "AWS Elasticsearch master cpu utilization")

  authorized_writer_teams = var.authorized_writer_teams
  teams                   = try(coalescelist(var.teams, var.authorized_writer_teams), null)
  tags                    = compact(concat(local.common_tags, local.tags, var.extra_tags))

  program_text = <<-EOF
    base_filtering = filter('namespace', 'AWS/ES') and filter('stat', 'upper') and filter('NodeId', '*')
    signal = data('MasterCPUUtilization', filter=base_filtering and ${module.filtering.signalflow})${var.master_cpu_transformation_function}.publish('signal')
    detect(when(signal > ${var.master_cpu_threshold_major}, lasting=%{if var.master_cpu_lasting_duration_major == null}None%{else}'${var.master_cpu_lasting_duration_major}'%{endif}, at_least=${var.master_cpu_at_least_percentage_major}) and (not when(signal > ${var.master_cpu_threshold_critical}, lasting=%{if var.master_cpu_lasting_duration_critical == null}None%{else}'${var.master_cpu_lasting_duration_critical}'%{endif}, at_least=${var.master_cpu_at_least_percentage_critical}))).publish('MAJOR')
    detect(when(signal > ${var.master_cpu_threshold_critical}, lasting=%{if var.master_cpu_lasting_duration_critical == null}None%{else}'${var.master_cpu_lasting_duration_critical}'%{endif}, at_least=${var.master_cpu_at_least_percentage_critical})).publish('CRIT')
EOF

  rule {
    description           = "is too high > ${var.master_cpu_threshold_major}"
    severity              = "Major"
    detect_label          = "MAJOR"
    disabled              = coalesce(var.master_cpu_disabled_major, var.master_cpu_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.master_cpu_notifications, "major", []), var.notifications.major), null)
    runbook_url           = try(coalesce(var.master_cpu_runbook_url, var.runbook_url), "")
    tip                   = var.master_cpu_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  rule {
    description           = "is too high > ${var.master_cpu_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.master_cpu_disabled_critical, var.master_cpu_disabled, var.detectors_disabled)
    notifications         = try(coalescelist(lookup(var.master_cpu_notifications, "critical", []), var.notifications.critical), null)
    runbook_url           = try(coalesce(var.master_cpu_runbook_url, var.runbook_url), "")
    tip                   = var.master_cpu_tip
    parameterized_subject = var.message_subject == "" ? local.rule_subject : var.message_subject
    parameterized_body    = var.message_body == "" ? local.rule_body : var.message_body
  }

  max_delay = var.master_cpu_max_delay
}

