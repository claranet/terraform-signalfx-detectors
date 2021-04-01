resource "signalfx_detector" "k8s_capacity_memory_requests" {
  name        = format("%s %s", local.detector_name_prefix, "Kubernetes Cluster Memory Requests")
  description = "Kubernetes Cluster Memory Requests"

  # detect(when(C > threshold(70), lasting='1h')).publish('Memory Warning')
  program_text = <<-EOF
      A = data('kubernetes.node_allocatable_memory').sum(by=['kubernetes_cluster']).publish(label='A', enable=False)
      B = data('kubernetes.container_memory_request').sum(by=['kubernetes_cluster']).publish(label='B', enable=False)
      C = ((B/A)*100).publish(label='C')
      detect(when(C > threshold(70))).publish('Memory Warning')
    EOF

  rule {
    description        = "The value of % Ratio Memory allocatable/requests is above 70."
    detect_label       = "Memory Warning"
    disabled           = false
    notifications      = var.notifications.warning
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
    display_name = "% Ratio Memory allocatable/requests"
    label        = "C"
    value_suffix = "%"
  }
  viz_options {
    display_name = "kubernetes.container_memory_request - Sum by kubernetes_cluster"
    label        = "B"
  }
  viz_options {
    display_name = "kubernetes.node_allocatable_memory - Sum by kubernetes_cluster"
    label        = "A"
  }

}

resource "signalfx_detector" "k8s_capacity_memory_usage" {
  name        = format("%s %s", local.detector_name_prefix, "Kubernetes Cluster Memory Usage")
  description = "Kubernetes Cluster Memory Usage"

  # detect(when(C > threshold(70), lasting='1h')).publish('Memory Warning')
  program_text = <<-EOF
      A = data('kubernetes.node_allocatable_memory').sum(by=['kubernetes_cluster']).publish(label='A', enable=False)
      B = data('container_memory_usage_bytes').sum(by=['kubernetes_cluster']).publish(label='B', enable=False)
      C = ((B/A)*100).publish(label='C')
      detect(when(C > threshold(70))).publish('Memory Major')
      detect(when(C > threshold(90))).publish('Memory Critical')
    EOF

  rule {
    description        = "The value of % Ratio Memory allocatable/usage is above 70."
    detect_label       = "Memory Major"
    disabled           = false
    notifications      = var.notifications.warning
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
  rule {
    description        = "The value of % Ratio Memory allocatable/usage is above 90."
    detect_label       = "Memory Critical"
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

        {{#if anomalous}}Signal value for % Ratio Memory allocatable/usage: {{inputs.C.value}}
        {{else}}Current signal value for % Ratio Memory allocatable/usage: {{inputs.C.value}}
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
    display_name = "% Ratio Memory allocatable/usage"
    label        = "C"
    value_suffix = "%"
  }
  viz_options {
    display_name = "container_memory_usage_bytes - Sum by kubernetes_cluster"
    label        = "B"
  }
  viz_options {
    display_name = "kubernetes.node_allocatable_memory - Sum by kubernetes_cluster"
    label        = "A"
  }

}