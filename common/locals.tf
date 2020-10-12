locals {
  not_running_vm_filters_gcp   = "(not filter('gcp_status', '{Code=3, Name=STOPPING}', '{Code=4, Name=TERMINATED}'))"
  not_running_vm_filters_aws   = "(not filter('aws_state', '{Code: 32,Name: shutting-down', '{Code: 48,Name: terminated}', '{Code: 62,Name: stopping}', '{Code: 80,Name: stopped}'))"
  not_running_vm_filters_azure = "(not filter('azure_power_state', 'PowerState/stopping', 'PowerState/stopped', 'PowerState/deallocating', 'PowerState/deallocated'))"
  not_running_vm_filters = format(
    "%s and %s and %s",
    local.not_running_vm_filters_aws,
    local.not_running_vm_filters_gcp,
    local.not_running_vm_filters_azure
  )
  detector_name_prefix = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}]"
  rule_subject_prefix  = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}}"
  rule_subject_suffix  = "on {{{dimensions}}}"
  rule_subject         = format("%s ({{inputs.signal.value}}) %s", local.rule_subject_prefix, local.rule_subject_suffix)
  rule_subject_novalue = format("%s %s", local.rule_subject_prefix, local.rule_subject_suffix)
  rule_body            = <<-EOF
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
