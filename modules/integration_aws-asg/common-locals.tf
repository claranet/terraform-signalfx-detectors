locals {
  heartbeat_auto_resolve_after = "1s"
  detector_name_prefix = "${join("", formatlist("[%s]", var.prefixes))}[${var.environment}]"
  common_tags          = concat(["terraform", var.environment], var.teams)
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
