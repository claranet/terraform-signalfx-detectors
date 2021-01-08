# User Guide

If you want a high level level understanding of how to create a new terraform stack 
for your project and use detectors modules inside you can check the wiki [Getting 
Started](https://github.com/claranet/terraform-signalfx-detectors/wiki/Getting-started).

This user guide the automatic way to automatically bootstrap a stack with all modules 
already imported ready to deploy but used as base to configure it to your needs 
following the wiki 
[Guidance](https://github.com/claranet/terraform-signalfx-detectors/wiki/Guidance).

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
:link: **Contents**

- [Requirements](#requirements)
- [Make targets](#make-targets)
- [Stack](#stack)
- [Example](#example)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## Requirements

First of all you have to [setup your environment](./environment.md) to have every required 
dependencies available to run useful commands detailed below.

You should get a ready env where you can run `make` commands or directly use the underlying 
[scripts](./scripts.md) or even some tools available in the container like `doctoc` or `j2`.

## Make targets

You seen above the `update-module` and `init-module` `make` targets which are very common 
for a developer no matter what type of change he would do but there are other possibilities.

Here are atomic `make` targets useful for for usage purpose:

- `dev`: the default and optional target, it requires docker to run container ready for other commands
- `init-stack` to generate a usable stack with all detectors imported in `examples/stack`.
- `clean` to clean directory and git diff related to `make init-stack`.

## Stack

To bootstrap a new stack usable for your project with all modules pre-imported and configured,
you can use `make init-stack` command. It will update the [/examples/stack](../examples/stack) 
directory which is ready terraform stack you can `terraform apply`.

In general you have to remove every modules you don't need from 
[/examples/stack/detectors.tf](../examples/stack/detectors.tf) and configure those kept 
following its own readme (available in its directory `/modules/xxx`.

Now you can follow the its [readme](../examples/stack/README.md) to deploy the stack.

## Example

```bash
$ make init-stack
Bootstrap stack in "examples/stack"
./scripts/stack/bootstrap.sh
./scripts/module/loop_wrapper.sh ./scripts/stack/gen_module.sh "v1.0.0" > examples/stack/detectors.tf

$ terraform init examples/stack

Initializing modules...
#...
- signalfx-detectors-smart-agent-system-common in .terraform/modules/signalfx-detectors-smart-agent-system-common/modules/smart-agent_system-common
Downloading github.com/claranet/terraform-signalfx-detectors.git for signalfx-detectors-smart-agent-system-common.filter-tags...
- signalfx-detectors-smart-agent-system-common.filter-tags in .terraform/modules/signalfx-detectors-smart-agent-system-common.filter-tags/common/filter-tags
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

