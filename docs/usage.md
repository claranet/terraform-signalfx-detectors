# User Guide

This user guide focus on automation capabilities using tooling in this repository.

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
:link: **Contents**

- [Requirements](#requirements)
- [Commands](#commands)
- [Stack](#stack)
  - [Example](#example)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## Requirements

First of all you have to [setup your environment](./environment.md) to have every required
dependencies available to run useful commands detailed below.

You should get a ready environment where you can run `make` commands or directly use the underlying
[scripts](./scripts.md) or even some tools available in the container like `doctoc` or `j2`.

## Commands

For a full list of available `make` targets please see [environment](./environment.md#Commands)
documentation. The most used commands for user are `dev`, `init-stack` and `clean`.

## Stack

If you want a high level level understanding of how to use detectors available in this
repository for your project you can check the wiki [Getting
Started](https://github.com/claranet/terraform-signalfx-detectors/wiki/Getting-started).

If you are familiar with terraform using modules so the most efficient way to "jump" is by
automatically bootstrap a terraform stack ready to use.

The `make init-stack` command allows to generate terraform files required for a basic configuration
importing all modules ready to deploy. It will update the [/examples/stack](../examples/stack)
directory to be available to `terraform apply` (or for copy in your existing terraform project).

This stack provides a [readme](../examples/stack/README.md) to explain how to deploy its
configuration. Follow it after initializing the stack to create all detectors from this
repository on your SignalFx organization easily.

Of course, this stack in only a basic template you have to customize according to your
needs:

- start by removing every modules you don't need from
[/examples/stack/detectors.tf](../examples/stack/detectors.tf)
- then follow the wiki
[Guidance](https://github.com/claranet/terraform-signalfx-detectors/wiki/Guidance) to
configure usual and common variables like notifications recipients for your alerts.
- finally check the `README.md` of the modules you kept to look for any specific
instructions to follow, requirements to meet or notes to know.

__Note__ The `make` commands are used by the CI on this repository to automatically
deploy all detectors and validate them with the SignalFx API. So it will always
generate a working terraform stack while you use the version for the imported modules
and the repository from where you run `make` command.

### Example

```bash
$ make init-stack
Bootstrap stack in "examples/stack"
./scripts/stack/bootstrap.sh
./scripts/module/loop_wrapper.sh ./scripts/stack/gen_module.sh "v1.0.0" > examples/stack/detectors.tf

$ terraform init examples/stack

Initializing modules...
#...
- signalfx-detectors-smart-agent-system-common in .terraform/modules/signalfx-detectors-smart-agent-system-common/modules/smart-agent_system-common
Downloading github.com/claranet/terraform-signalfx-detectors.git for signalfx-detectors-smart-agent-system-common.filtering...
- signalfx-detectors-smart-agent-system-common.filtering in .terraform/modules/signalfx-detectors-smart-agent-system-common.filtering/modules/internal_filtering
#...

Initializing the backend...

Initializing provider plugins...
- Finding splunk-terraform/signalfx versions matching ">= 4.26.4, >= 4.26.4, >= 4.26.4, >= 4.26.4, >= 4.26.4, >= 4.26.4, >= 4.26.4, >= 4.26.4, >= 4.26.4, >= 4.26.4, >= 4.26.4, >= 4.26.4, >= 4.26.4, >= 4.26.4, >= 4.26.4, >= 4.26.4, >= 4.26.4, >= 4.26.4, >= 4.26.4, >= 4.26.4, >= 4.26.4, >= 4.26.4, >= 4.26.4, >= 4.26.4, >= 4.26.4, >= 4.26.4, >= 4.26.4, >= 4.26.4, >= 4.26.4, >= 4.26.4, >= 4.26.4, >= 4.26.4, >= 4.26.4, >= 4.26.4, >= 4.26.4, >= 4.26.4, >= 4.26.4, >= 4.26.4, >= 4.26.4, >= 4.26.4, >= 4.26.4, >= 4.26.4, >= 4.26.4, >= 4.26.4, >= 4.26.4, >= 4.26.4, >= 4.26.4, >= 4.26.4, >= 4.26.4, >= 4.26.4, >= 4.26.4, >= 4.26.4, >= 4.26.4, >= 4.26.4, >= 4.26.4, >= 4.26.4, >= 4.26.4, >= 4.26.4, >= 4.26.4, >= 4.26.4, >= 4.26.4, >= 4.26.4, >= 4.26.4, >= 4.26.4, >= 4.26.4, >= 4.26.4, >= 4.26.4, >= 4.26.4, >= 4.26.4, >= 4.26.4, >= 4.26.4, >= 4.26.4, >= 4.26.4, >= 4.26.4, >= 4.26.4, >= 4.26.4, >= 4.26.4, >= 4.26.4, >= 4.26.4"...
- Installing splunk-terraform/signalfx v6.1.0...
- Installed splunk-terraform/signalfx v6.1.0 (signed by a HashiCorp partner, key ID xxx)

Partner and community providers are signed by their developers.
If you'd like to know more about provider signing, you can read about it here:
https://www.terraform.io/docs/plugins/signing.html

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.

$ SFX_AUTH_TOKEN=xxx TF_VAR_environment=doc terraform apply -target=module.signalfx-detectors-smart-agent-system-common.signalfx_detector.cpu examples/stack

An execution plan has been generated and is shown below.
Resource actions are indicated with the following symbols:
  + create

Terraform will perform the following actions:

  # module.signalfx-detectors-smart-agent-system-common.signalfx_detector.cpu will be created
  + resource "signalfx_detector" "cpu" {
      + id                = (known after apply)
      + max_delay         = 0
      + name              = "[doc] System cpu utilization"
      + program_text      = <<~EOT
            signal = data('cpu.utilization', filter=filter('env', 'doc') and filter('sfx_monitored', 'true'), extrapolation='zero').min(over='1h').publish('signal')
            detect(when(signal > 90)).publish('CRIT')
            detect(when(signal > 85) and when(signal <= 90)).publish('MAJOR')
        EOT
      + show_data_markers = true
      + time_range        = 3600
      + url               = (known after apply)

      + rule {
          + description           = "is too high > 85"
          + detect_label          = "MAJOR"
          + disabled              = false
          + notifications         = [
              + "Email,doc@signalfx.null",
            ]
          + parameterized_body    = <<~EOT
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
            EOT
          + parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
          + severity              = "Major"
        }
      + rule {
          + description           = "is too high > 90"
          + detect_label          = "CRIT"
          + disabled              = false
          + notifications         = [
              + "Email,doc@signalfx.null",
            ]
          + parameterized_body    = <<~EOT
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
            EOT
          + parameterized_subject = "[{{ruleSeverity}}]{{{detectorName}}} {{{readableRule}}} ({{inputs.signal.value}}) on {{{dimensions}}}"
          + severity              = "Critical"
        }
    }

Plan: 1 to add, 0 to change, 0 to destroy.


Warning: Resource targeting is in effect

You are creating a plan with the -target option, which means that the result
of this plan may not represent all of the changes requested by the current
configuration.

The -target option is not for routine use, and is provided only for
exceptional situations such as recovering from errors or mistakes, or when
Terraform specifically suggests to use it as part of an error message.

Do you want to perform these actions?
  Terraform will perform the actions described above.
  Only 'yes' will be accepted to approve.

  Enter a value: yes

module.signalfx-detectors-smart-agent-system-common.signalfx_detector.cpu: Creating...
module.signalfx-detectors-smart-agent-system-common.signalfx_detector.cpu: Creation complete after 2s [id=xxx]

Warning: Applied changes may be incomplete

The plan was created with the -target option in effect, so some changes
requested in the configuration may have been ignored and the output values may
not be fully updated. Run the following command to verify that no other
changes are pending:
    terraform plan

Note that the -target option is not suitable for routine use, and is provided
only for exceptional situations such as recovering from errors or mistakes, or
when Terraform specifically suggests to use it as part of an error message.


Apply complete! Resources: 1 added, 0 changed, 0 destroyed.
```

