locals {
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
