resource "signalfx_detector" "cpu" {
	name = "CPU usage"

	program_text = <<-EOF
		signal = data('cpu.utilization').mean(by=['host'])
		detect(when(signal > ${var.cpu_threshold_critical})).publish('CRIT')
	EOF

	rule {
		description = "Average > ${var.cpu_threshold_critical}"
		severity = "Critical"
		detect_label = "CRIT"
	}
}

resource "signalfx_detector" "load" {
	name = "CPU load 5 ratio"

	program_text = <<-EOF
		signal = data('load.midterm').mean(by=['host']).min(over='${var.load_timeframe}')
		detect(when(signal > ${var.load_threshold_critical})).publish('CRIT')
	EOF

	rule {
		description = "Min > ${var.load_threshold_critical} for last ${var.load_timeframe}"
		severity = "Critical"
		detect_label = "CRIT"
	}
}

resource "signalfx_detector" "disk_space" {
	name = "Disk space usage"

	program_text = <<-EOF
		signal = data('disk.utilization').max(by=['host']).max(over='${var.disk_space_timeframe}')
		detect(when(signal > ${var.disk_space_threshold_critical})).publish('CRIT')
	EOF

	rule {
		description = "Max > ${var.disk_space_threshold_critical} for last ${var.disk_space_timeframe}"
		severity = "Critical"
		detect_label = "CRIT"
	}
}

resource "signalfx_detector" "memory" {
	name = "Usable Memory"

	program_text = <<-EOF
		A = data('memory.utilization').mean(by=['host'])
		signal = (100-A).max(over='${var.memory_timeframe}')
		detect(when(signal > ${var.memory_threshold_critical})).publish('CRIT')
	EOF

	rule {
		description = "Max > ${var.memory_threshold_critical} for last ${var.memory_timeframe}"
		severity = "Critical"
		detect_label = "CRIT"
	}
}
