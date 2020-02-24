resource "signalfx_detector" "ALB_no_healthy_instances" {
	name = "ALB healthy instances"

	program_text = <<-EOF
		A = data('HealthyHostCount', filter=filter('namespace', 'AWS/ApplicationELB')).sum(by=['aws_region', 'LoadBalancer'])
		B = data('UnHealthyHostCount', filter=filter('namespace', 'AWS/ApplicationELB')).sum(by=['aws_region','LoadBalancer'])
		signal = (A/(A+B)).scale(100).min(over='5m')
		detect(when(signal < 1)).publish('CRIT')
	EOF

	rule {
		description = "Minimum < 1 for last 5m"
		severity = "Critical"
		detect_label = "CRIT"
		parameterized_subject = "{{#if anomalous}}
   Rule "{{ruleName}}" in detector "{{detectorName}}" triggered at {{timestamp}}.
{{else}}
   Rule "{{ruleName}}" in detector "{{detectorName}}" cleared at {{timestamp}}.
{{/if}}

{{#if anomalous}}
Triggering condition: {{{readableRule}}}
{{/if}}

{{#if anomalous}}Signal value: {{inputs.A.value}}
{{else}}Current signal value: {{inputs.A.value}}
{{/if}}

{{#notEmpty dimensions}}
Signal details:
{{{dimensions}}}
{{/notEmpty}}

{{#if anomalous}}
{{#if runbookUrl}}Runbook: {{{runbookUrl}}}{{/if}}
{{#if tip}}Tip: {{{tip}}}{{/if}}
{{/if}}"
	}

}

resource "signalfx_detector" "ALB_latency" {
	name = "ALB latency"

	program_text = <<-EOF
		signal = data('TargetResponseTime', filter=filter('namespace', 'AWS/ApplicationELB')).mean(by=['aws_region', 'LoadBalancer']).min(over='5m')
		detect(when(signal > 3)).publish('CRIT')
	EOF

	rule {
		description = "Minimum > 3 for last 5m"
		severity = "Critical"
		detect_label = "CRIT"
	}

}

resource "signalfx_detector" "ALB_httpcode_5xx" {
	name = "$ALB HTTP code 5xx"

	program_text = <<-EOF
		A = data('HTTPCode_ELB_5XX_Count', filter=filter('namespace', 'AWS/ApplicationELB'), rollup='rate').mean(by=['aws_region','LoadBalancer'])
		B = data('RequestCount', filter=filter('namespace', 'AWS/ApplicationELB'), rollup='rate').mean(by=['aws_region','LoadBalancer'])
		signal = (A/(B + 5)).scale(100).min(over='5m')
		detect(when(signal > 80)).publish('CRIT')
	EOF

	rule {
		description = "Minimum > 80 for last 5m"
		severity = "Critical"
		detect_label = "CRIT"
	}

}

resource "signalfx_detector" "ALB_httpcode_4xx" {
	name = "ALB HTTP code 4xx"

	program_text = <<-EOF
		A = data('HTTPCode_ELB_4XX_Count', filter=filter('namespace', 'AWS/ApplicationELB'), rollup='rate').mean(by=['aws_region','LoadBalancer'])
		B = data('RequestCount', filter=filter('namespace', 'AWS/ApplicationELB'), rollup='rate').mean(by=['aws_region','LoadBalancer'])
		signal = (A/(B + 5)).scale(100).min(over='5m')
		detect(when(signal > 80)).publish('CRIT')
	EOF

	rule {
		description = "Minimum > 80 for last 5m"
		severity = "Critical"
		detect_label = "CRIT"
	}

}

resource "signalfx_detector" "ALB_httpcode_target_5xx" {
	name    = "ALB target HTTP code 5xx"

	program_text = <<-EOF
		A = data('HTTPCode_Target_5XX_Count', filter=filter('namespace', 'AWS/ApplicationELB'), rollup='rate').mean(by=['aws_region','LoadBalancer'])
		B = data('RequestCount', filter=filter('namespace', 'AWS/ApplicationELB'), rollup='rate').mean(by=['aws_region','LoadBalancer'])
		signal = (A/(B + 5)).scale(100).min(over='5m')
		detect(when(signal > 80)).publish('CRIT')
	EOF

	rule {
		description = "Minimum > 80 for last 5m"
		severity = "Critical"
		detect_label = "CRIT"
	}

}

resource "signalfx_detector" "ALB_httpcode_target_4xx" {
	name    = "ALB target HTTP code 4xx"

	program_text = <<-EOF
		A = data('HTTPCode_Target_4XX_Count', filter=filter('namespace', 'AWS/ApplicationELB'), rollup='rate').mean(by=['aws_region','LoadBalancer'])
		B = data('RequestCount', filter=filter('namespace', 'AWS/ApplicationELB'), rollup='rate').mean(by=['aws_region','LoadBalancer'])
		signal = (A/(B + 5)).scale(100).min(over='5m')
		detect(when(signal > 80)).publish('CRIT')
	EOF

	rule {
		description = "Minimum > 80 for last 5m"
		severity = "Critical"
		detect_label = "CRIT"
	}

}
