resource "signalfx_detector" "system_heartbeat" {
	name = "${var.prefix_slug == "" ? "" : "[${var.prefix_slug}]"}[${var.environment}] System Heartbeat Check"

	program_text = <<-EOF
		from signalfx.detectors.not_reporting import not_reporting
		signal = data('cpu.utilization', filter=(not filter('aws_state', '*terminated}', '*stopped}')) and (not filter('gcp_status', '*TERMINATED}', '*STOPPING}')) and (not filter('azure_power_state', 'stop*', 'deallocat*')))
		not_reporting.detector(stream=signal, resource_identifier=['host'], duration='${var.system_heartbeat_timeframe}').publish('CRIT')
	EOF

	rule {
		description = "System has not reported in ${var.system_heartbeat_timeframe}"
		severity = "Critical"
		detect_label = "CRIT"
		disabled = "${var.system_heartbeat_disabled_flag}"
	}
}

resource "signalfx_detector" "cpu" {
	name = "${var.prefix_slug == "" ? "" : "[${var.prefix_slug}]"}[${var.environment}] CPU usage"

	program_text = <<-EOF
		signal = data('cpu.utilization').${var.cpu_aggregation_function}${var.cpu_transformation_function}(over='${var.cpu_transformation_window}')
		detect(when(signal > ${var.cpu_threshold_critical})).publish('CRIT')
	EOF

	rule {
		description = "${var.cpu_transformation_function} CPU utilization over ${var.cpu_transformation_window} > ${var.cpu_threshold_critical}"
		severity = "Critical"
		detect_label = "CRIT"
		disabled = "${var.cpu_disabled_flag}"
	}
}

resource "signalfx_detector" "load" {
	name = "${var.prefix_slug == "" ? "" : "[${var.prefix_slug}]"}[${var.environment}] CPU load 5 ratio"

	program_text = <<-EOF
		signal = data('load.midterm').${load_aggregation_function}${var.load_transformation_function}(over='${var.load_transformation_window}')
		detect(when(signal > ${var.load_threshold_critical})).publish('CRIT')
	EOF

	rule {
		description = "${var.load_transformation_function} load(5m) over ${var.load_transformation_window} > ${var.load_threshold_critical}"
		severity = "Critical"
		detect_label = "CRIT"
		disabled = "${var.load_disabled_flag}"
	}
}

resource "signalfx_detector" "disk_space" {
	name = "${var.prefix_slug == "" ? "" : "[${var.prefix_slug}]"}[${var.environment}] Disk space usage"

	program_text = <<-EOF
		signal = data('disk.utilization').${disk_space_aggregation_function}${var.disk_space_transformation_function}(over='${var.disk_space_transformation_window}')
		detect(when(signal > ${var.disk_space_threshold_critical})).publish('CRIT')
	EOF

	rule {
		description = "${var.disk_space_transformation_function} disk space over ${var.disk_space_transformation_window} > ${var.disk_space_threshold_critical}"
		severity = "Critical"
		detect_label = "CRIT"
		disabled = "${var.disk_space_disabled_flag}"
	}
}

resource "signalfx_detector" "memory" {
	name = "${var.prefix_slug == "" ? "" : "[${var.prefix_slug}]"}[${var.environment}] Usable Memory"

	program_text = <<-EOF
		A = data('memory.utilization')${memory_aggregation_function}
		signal = (100-A).${var.memory_transformation_function}(over='${var.memory_transformation_window}')
		detect(when(signal < ${var.memory_threshold_critical})).publish('CRIT')
	EOF

	rule {
		description = "${var.memory_transformation_function} usable memory over ${var.memory_transformation_window} < ${var.memory_threshold_critical}"
		severity = "Critical"
		detect_label = "CRIT"
		disabled = "${var.memory_disabled_flag}"
	}
}
