# SignalFx Detectors Example

Here is a possible 
[stack](https://github.com/claranet/terraform-signalfx-detectors/wiki/Getting-started#stack) 
implementation example to use and deploy detectors modules available in this repository.

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
:link: **Contents**

  - [Step by step guide](#step-by-step-guide)
  - [Notes](#notes)
- [Tips](#tips)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## Step by step guide

1. Install [Terraform](https://www.terraform.io/).
1. `git clone` this repository to your computer.
1. Define the environment variable required for all detectors modules:
   `export TF_VAR_environment=doc`
   You can also edit the `variables.tf` to make it persistent.
1. Define your SignalFx organization token with:
   `export SFX_AUTH_TOKEN=fillme`
   You can also edit the [providers.tf](providers.tf) and assign value
   to the `auth_token` provider argument.
1. Run `terraform init`.
1. Run `terraform apply`.
1. You can optionally customize the configuration of the example module
   imported in [detectors.tf](detectors.tf) following the wiki
   [Guidance](https://github.com/claranet/terraform-signalfx-detectors/wiki/Guidance)
   to meet your own needs and adjust the default behavior which could
   not be always optimal depending on your context.

## Notes

In this example we only configured one module in [detectors.tf](detectors.tf), 
the goal is to show you a common simple structure and configuration example
for your terraform stack.

But from now you can add as many modules you want depending on the resources
you would like to monitor. Go to [/modules](../../modules/README.md) to see the full
list of available modules.

This configuration is very basic and only defines one email address `doc@signalfx.null` as notifications 
recipient for alerts of all detectors of the module, all their alerting rules, and all their severities.

In general, you want probably smarter notifications definition, you can even define multiple locals 
for different use cases (business hour only vs h24 alert) and assign the right local for each module 
you call depending on the importance for you.

To go further, please check the [usage](../usage/README.md) to learn by examples
how to configure your new stack.

# Tips

- If something you want monitor is not available in the modules list, 
  so you can ask it with issue or add it yourself with a Pull Request.
  See [/CONTRIBUTING.md](../../CONTRIBUTING.md) for more information.
- You can easily import ALL existing modules (depending on your current
  git revision) by running `cd ../../ && make init-stack`.
  It will update the [detectors.tf](detectors.tf) here with all modules
  pre-configured.
- In this example we use the `smart-agent_system-common` module which 
  monitor common operating systems metrics from the [signalfx 
  agent](https://github.com/signalfx/signalfx-agent/) but it could exist
  other "specific" versions usable in addition to this. Their names will
  be the same but with a different suffix than `common` describing its
  purpose or difference (e.g. `smart-agent_system-windows`)
