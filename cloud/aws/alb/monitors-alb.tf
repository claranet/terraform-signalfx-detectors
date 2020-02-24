resource "signalfx_detector" "ALB_no_healthy_instances" {
  count   = var.alb_no_healthy_instances_enabled == "true" ? 1 : 0
  name    = "${var.prefix_slug == "" ? "" : "[${var.prefix_slug}]"}[${var.environment}] ALB healthy instances {{#is_alert}}is at 0{{/is_alert}}{{#is_warning}}is at {{value}}%%{{/is_warning}}"

  /*query = <<EOQ
    ${var.alb_no_healthy_instances_time_aggregator}(${var.alb_no_healthy_instances_timeframe}): (
      sum:aws.applicationelb.healthy_host_count.minimum${module.filter-tags.query_alert} by {region,loadbalancer} / (
      sum:aws.applicationelb.healthy_host_count.minimum${module.filter-tags.query_alert} by {region,loadbalancer} +
      sum:aws.applicationelb.un_healthy_host_count.maximum${module.filter-tags.query_alert} by {region,loadbalancer} )
    ) * 100 < 1
EOQ*/

  program_text = <<-EOF
      A = data('HealthyHostCount', rollup='sum').${var.alb_no_healthy_instances_time_aggregator}.sum(by=['aws_region','LoadBalancerName'])
			B = data('UnHealthyHostCount', rollup='sum').${var.alb_no_healthy_instances_time_aggregator}.sum(by=['aws_region','LoadBalancerName'])
			signal = (A/(A+B)).scale(100)
			detect(when(signal < ${var.alb_no_healthy_instances_threshold_critical}, max('${var.alb_no_healthy_instances_timeframe}'))).publish('CRIT')

  EOF

	rule {
		description = coalesce(var.alb_no_healthy_instances_message, var.message)
		severity = "Critical"
	}

}

resource "signalfx_detector" "ALB_latency" {
  count   = var.latency_enabled == "true" ? 1 : 0
  name    = "${var.prefix_slug == "" ? "" : "[${var.prefix_slug}]"}[${var.environment}] ALB latency {{#is_alert}}{{{comparator}}} {{threshold}}s ({{value}}s){{/is_alert}}{{#is_warning}}{{{comparator}}} {{warn_threshold}}s ({{value}}s){{/is_warning}}"

  /*query = <<EOQ
    ${var.latency_time_aggregator}(${var.latency_timeframe}):
      default(avg:aws.applicationelb.target_response_time.average${module.filter-tags.query_alert} by {region,loadbalancer}, 0)
    > ${var.latency_threshold_critical}
EOQ*/

  program_text = <<-EOF
      signal = data('TargetResponseTime', rollup='mean').${var.latency_time_aggregator}.mean(by=['aws_region','LoadBalancerName'])
			
			detect(when(signal > ${var.latency_threshold_critical}, max('${var.latency_timeframe}'))).publish('CRIT')

  EOF

	rule {
		description = coalesce(var.latency_message, var.message)
		severity = "Critical"
	}

}

resource "signalfx_detector" "ALB_httpcode_5xx" {
  count   = var.httpcode_alb_5xx_enabled == "true" ? 1 : 0
  name    = "${var.prefix_slug == "" ? "" : "[${var.prefix_slug}]"}[${var.environment}] ALB HTTP code 5xx {{#is_alert}}{{{comparator}}} {{threshold}}% ({{value}}%){{/is_alert}}{{#is_warning}}{{{comparator}}} {{warn_threshold}}% ({{value}}%){{/is_warning}}"

  /*query = <<EOQ
    ${var.httpcode_alb_5xx_time_aggregator}(${var.httpcode_alb_5xx_timeframe}):
      default(avg:aws.applicationelb.httpcode_elb_5xx${module.filter-tags.query_alert} by {region,loadbalancer}.as_rate(), 0) / (
      default(avg:aws.applicationelb.request_count${module.filter-tags.query_alert} by {region,loadbalancer}.as_rate() + ${var.artificial_requests_count}, 1))
      * 100 > ${var.httpcode_alb_5xx_threshold_critical}
  EOQ*/

  program_text = <<-EOF
      A = data('HTTPCode_ELB_5XX_Count', rollup='mean').${var.httpcode_alb_5xx_time_aggregator}.mean(by=['aws_region','LoadBalancerName'])
			B = data('RequestCount', rollup='mean').${var.httpcode_alb_5xx_time_aggregator}.mean(by=['aws_region','LoadBalancerName'])

      signal = (A/B + ${var.artificial_requests_count}).scale(100)
			detect(when(signal > ${var.httpcode_alb_5xx_threshold_critical}, max('${var.httpcode_alb_5xx_timeframe}'))).publish('CRIT')

  EOF

	rule {
		description = coalesce(var.httpcode_alb_5xx_message, var.message)
		severity = "Critical"
	}

}

resource "signalfx_detector" "ALB_httpcode_4xx" {
  count   = var.httpcode_alb_4xx_enabled == "true" ? 1 : 0
  name    = "${var.prefix_slug == "" ? "" : "[${var.prefix_slug}]"}[${var.environment}] ALB HTTP code 4xx {{#is_alert}}{{{comparator}}} {{threshold}}% ({{value}}%){{/is_alert}}{{#is_warning}}{{{comparator}}} {{warn_threshold}}% ({{value}}%){{/is_warning}}"

  /*query = <<EOQ
    ${var.httpcode_alb_4xx_time_aggregator}(${var.httpcode_alb_4xx_timeframe}):
      default(avg:aws.applicationelb.httpcode_elb_4xx${module.filter-tags.query_alert} by {region,loadbalancer}.as_rate(), 0) / (
      default(avg:aws.applicationelb.request_count${module.filter-tags.query_alert} by {region,loadbalancer}.as_rate() + ${var.artificial_requests_count}, 1))
      * 100 > ${var.httpcode_alb_4xx_threshold_critical}
  EOQ*/

  program_text = <<-EOF
      A = data('HTTPCode_ELB_4XX_Count', rollup='mean').${var.httpcode_alb_4xx_time_aggregator}.mean(by=['aws_region','LoadBalancerName'])
			B = data('RequestCount', rollup='mean').${var.httpcode_alb_4xx_time_aggregator}.mean(by=['aws_region','LoadBalancerName'])

      signal = (A/B + ${var.artificial_requests_count}).scale(100)
			detect(when(signal > ${var.httpcode_alb_4xx_threshold_critical}, max('${var.httpcode_alb_4xx_timeframe}'))).publish('CRIT')

  EOF

	rule {
		description = coalesce(var.httpcode_alb_4xx_message, var.message)
		severity = "Critical"
	}

}

resource "signalfx_detector" "ALB_httpcode_target_5xx" {
  count   = var.httpcode_target_5xx_enabled == "true" ? 1 : 0
  name    = "${var.prefix_slug == "" ? "" : "[${var.prefix_slug}]"}[${var.environment}] ALB target HTTP code 5xx {{#is_alert}}{{{comparator}}} {{threshold}}% ({{value}}%){{/is_alert}}{{#is_warning}}{{{comparator}}} {{warn_threshold}}% ({{value}}%){{/is_warning}}"

  /*query = <<EOQ
    ${var.httpcode_target_5xx_time_aggregator}(${var.httpcode_target_5xx_timeframe}):
      default(avg:aws.applicationelb.httpcode_target_5xx${module.filter-tags.query_alert} by {region,loadbalancer}.as_rate(), 0) / (
      default(avg:aws.applicationelb.request_count${module.filter-tags.query_alert} by {region,loadbalancer}.as_rate() + ${var.artificial_requests_count}, 1))
      * 100 > ${var.httpcode_target_5xx_threshold_critical}
  EOQ*/

  program_text = <<-EOF
      A = data('HTTPCode_Target_5XX_Count', rollup='mean').${var.httpcode_target_5xx_time_aggregator}.mean(by=['aws_region','LoadBalancerName'])
			B = data('RequestCount', rollup='mean').${var.httpcode_target_5xx_time_aggregator}.mean(by=['aws_region','LoadBalancerName'])

      signal = (A/B + ${var.artificial_requests_count}).scale(100)
			detect(when(signal > ${var.httpcode_target_5xx_threshold_critical}, max('${var.httpcode_target_5xx_timeframe}'))).publish('CRIT')

  EOF

	rule {
		description = coalesce(var.httpcode_target_5xx_message, var.message)
		severity = "Critical"
	}

}

resource "signalfx_detector" "ALB_httpcode_target_4xx" {
  count   = var.httpcode_target_4xx_enabled == "true" ? 1 : 0
  name    = "${var.prefix_slug == "" ? "" : "[${var.prefix_slug}]"}[${var.environment}] ALB target HTTP code 4xx {{#is_alert}}{{{comparator}}} {{threshold}}% ({{value}}%){{/is_alert}}{{#is_warning}}{{{comparator}}} {{warn_threshold}}% ({{value}}%){{/is_warning}}"

  /*query = <<EOQ
    ${var.httpcode_target_4xx_time_aggregator}(${var.httpcode_target_4xx_timeframe}):
      default(avg:aws.applicationelb.httpcode_target_4xx${module.filter-tags.query_alert} by {region,loadbalancer}.as_rate(), 0) / (
      default(avg:aws.applicationelb.request_count${module.filter-tags.query_alert} by {region,loadbalancer}.as_rate() + ${var.artificial_requests_count}, 1))
      * 100 > ${var.httpcode_target_4xx_threshold_critical}
  EOQ*/

  program_text = <<-EOF
      A = data('HTTPCode_Target_4XX_Count', rollup='mean').${var.httpcode_target_4xx_time_aggregator}.mean(by=['aws_region','LoadBalancerName'])
			B = data('RequestCount', rollup='mean').${var.httpcode_target_4xx_time_aggregator}.mean(by=['aws_region','LoadBalancerName'])

      signal = (A/B + ${var.artificial_requests_count}).scale(100)
			detect(when(signal > ${var.httpcode_target_4xx_threshold_critical}, max('${var.httpcode_target_4xx_timeframe}'))).publish('CRIT')

  EOF

	rule {
		description = coalesce(var.httpcode_target_4xx_message, var.message)
		severity = "Critical"
	}

}

