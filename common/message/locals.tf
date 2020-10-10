locals {
  heartbeat_filters_gcp = "(not filter('gcp_status', '{Code=3, Name=STOPPING}', '{Code=4, Name=TERMINATED}'))"
  heartbeat_filters_aws = "(not filter('aws_state', '{Code: 32,Name: shutting-down', '{Code: 48,Name: terminated}', '{Code: 62,Name: stopping}', '{Code: 80,Name: stopped}'))"
  heartbeat_filters_azure = "(not filter('azure_power_state', 'PowerState/stopping', 'PowerState/stopped', 'PowerState/deallocating', 'PowerState/deallocated'))"
  heartbeat_filters = format(
    "%s and %s and %s",
    local.heartbeat_filters_aws,
    local.heartbeat_filters_gcp,
    local.heartbeat_filters_azure
  )
  name_start      = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}]"
  subject_start   = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}}"
  subject_end     = "on {{{dimensions}}}"
  subject         = format("%s ({{inputs.signal.value}}) %s", local.subject_start, local.subject_end)
  subject_novalue = format("%s %s", local.subject_start, local.subject_end)
  body            = <<-EOF
    **Alert**:
    *[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}})*
    {{#if anomalous}}
    **Triggered at**:
    *{{timestamp}}*
    {{else}}
    **Cleared at**:
    *{{timestamp}}*
    {{/if}}

    {{#notEmpty dimensions}}
    **Dimensions**:
    *{{{dimensions}}}*
    {{/notEmpty}}

    {{#if anomalous}}
    {{#if runbookUrl}}**Runbook**:
    Go to [this page]({{{runbookUrl}}}) for help and analysis.
    {{/if}}

    {{#if tip}}**Tip**:
    {{{tip}}}
    {{/if}}
    {{/if}}
EOF
}
