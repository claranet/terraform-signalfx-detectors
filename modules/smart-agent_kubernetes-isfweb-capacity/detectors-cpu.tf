resource "signalfx_detector" "k8s_capacity_cpu_requests" {
  name        = format("%s %s", local.detector_name_prefix, "Kubernetes Cluster CPU Requests")
  description = "Kubernetes Cluster CPU requests/allocatable"

  program_text = <<-EOF
      A = data('kubernetes.node_allocatable_cpu', filter=${module.filter-tags.filter_custom}).sum(by=['kubernetes_cluster']).publish(label='A', enable=False)
      B = data('kubernetes.container_cpu_request', filter=${module.filter-tags.filter_custom}).sum(by=['kubernetes_cluster']).publish(label='B', enable=False)
      C = ((B/A)*100).publish(label='C')
      detect(when(C > threshold(85), lasting='1h')).publish('Compute Warning')
    EOF

  rule {
    description        = "The value of (B/A)*100 is above 85."
    detect_label       = "Compute Warning"
    disabled           = false
    notifications       = var.notifications.warning
    parameterized_body = <<-EOT
        {{#if anomalous}}
          Rule "{{{ruleName}}}" in detector "{{{detectorName}}}" triggered at {{dateTimeFormat timestamp format="full"}}.
        {{else}}
          Rule "{{{ruleName}}}" in detector "{{{detectorName}}}" cleared at {{dateTimeFormat timestamp format="full"}}.
        {{/if}}

        {{#if anomalous}}
        Triggering condition: {{{readableRule}}}
        {{/if}}

        {{#if anomalous}}Signal value for B/A: {{inputs.C.value}}
        {{else}}Current signal value for B/A: {{inputs.C.value}}
        {{/if}}

        {{#notEmpty dimensions}}
        Signal details:
        {{{dimensions}}}
        {{/notEmpty}}

        {{#if anomalous}}
        {{#if runbookUrl}}Runbook: {{{runbookUrl}}}{{/if}}
        {{#if tip}}Tip: {{{tip}}}{{/if}}
        {{/if}}
    EOT
    severity           = "Warning"
  }

  viz_options {
    display_name = "(B/A)*100"
    label        = "C"
    value_suffix = "%"
  }
  viz_options {
    display_name = "kubernetes.container_cpu_request - Sum by kubernetes_cluster"
    label        = "B"
  }
  viz_options {
    display_name = "kubernetes.node_allocatable_cpu - Sum by kubernetes_cluster"
    label        = "A"
  }

}

resource "signalfx_detector" "k8s_capacity_cpu_usage" {
  name        = format("%s %s", local.detector_name_prefix, "Kubernetes Cluster CPU Usage")
  description = "Kubernetes Cluster CPU Usage"

  program_text = <<-EOF
      A = data('cpu.utilization', filter=${module.filter-tags.filter_custom}).sum(by=['kubernetes_cluster']).publish(label='A', enable=False)
      B = data('kubernetes.node_allocatable_cpu', filter=${module.filter-tags.filter_custom}).sum(by=['kubernetes_cluster']).publish(label='B', enable=False)
      C = data('cpu.num_processors', filter=${module.filter-tags.filter_custom}).sum(by=['kubernetes_cluster']).publish(label='C', enable=False)
      D = ((A/100)/(1/C)).sum(by=['kubernetes_cluster']).publish(label='D', enable=False)
      E = ((D/B)*100).publish(label='E')
      detect(when(E > threshold(85), lasting='15m')).publish('CPU Usage is over 85%')
      detect(when(E > threshold(90), lasting='15m')).publish('CPU Usage is over 90%')
    EOF

  rule {
    description        = "The value of % CPU Usage/Allocatable is above 85."
    detect_label       = "CPU Usage is over 85%"
    disabled           = false
    notifications      = var.notifications.major
    parameterized_body = <<-EOT
          {{#if anomalous}}
            Rule "{{{ruleName}}}" in detector "{{{detectorName}}}" triggered at {{dateTimeFormat timestamp format="full"}}.
          {{else}}
            Rule "{{{ruleName}}}" in detector "{{{detectorName}}}" cleared at {{dateTimeFormat timestamp format="full"}}.
          {{/if}}

          {{#if anomalous}}
          Triggering condition: {{{readableRule}}}
          {{/if}}

          {{#if anomalous}}Signal value for D/B: {{inputs.E.value}}
          {{else}}Current signal value for D/B: {{inputs.E.value}}
          {{/if}}

          {{#notEmpty dimensions}}
          Signal details:
          {{{dimensions}}}
          {{/notEmpty}}

          {{#if anomalous}}
          {{#if runbookUrl}}Runbook: {{{runbookUrl}}}{{/if}}
          {{#if tip}}Tip: {{{tip}}}{{/if}}
          {{/if}}
      EOT
    severity           = "Major"
  }
  rule {
    description        = "The value of % CPU Usage/Allocatable is above 90."
    detect_label       = "CPU Usage is over 90%"
    disabled           = false
    notifications      = var.notifications.critical
    parameterized_body = <<-EOT
          {{#if anomalous}}
            Rule "{{{ruleName}}}" in detector "{{{detectorName}}}" triggered at {{dateTimeFormat timestamp format="full"}}.
          {{else}}
            Rule "{{{ruleName}}}" in detector "{{{detectorName}}}" cleared at {{dateTimeFormat timestamp format="full"}}.
          {{/if}}

          {{#if anomalous}}
          Triggering condition: {{{readableRule}}}
          {{/if}}

          {{#if anomalous}}Signal value for D/B: {{inputs.E.value}}
          {{else}}Current signal value for D/B: {{inputs.E.value}}
          {{/if}}

          {{#notEmpty dimensions}}
          Signal details:
          {{{dimensions}}}
          {{/notEmpty}}

          {{#if anomalous}}
          {{#if runbookUrl}}Runbook: {{{runbookUrl}}}{{/if}}
          {{#if tip}}Tip: {{{tip}}}{{/if}}
          {{/if}}
      EOT
    severity           = "Critical"
  }

  viz_options {
    display_name = "% CPU Usage/Allocatable"
    label        = "E"
  }
  viz_options {
    display_name = "(A/100)/(1/C) - Sum by kubernetes_cluster"
    label        = "D"
  }
  viz_options {
    display_name = "cpu.num_processors - Sum by kubernetes_cluster"
    label        = "C"
  }
  viz_options {
    display_name = "cpu.utilization - Sum by kubernetes_cluster"
    label        = "A"
  }
  viz_options {
    display_name = "kubernetes.node_allocatable_cpu - Sum by kubernetes_cluster"
    label        = "B"
  }

}