locals {
  parameterized_body = <<-EOF
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
