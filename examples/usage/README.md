# Usage examples

Here are configurations of common possible usage of the detectors modules in this repository.

See the [wiki](https://github.com/claranet/terraform-signalfx-detectors/wiki/Getting-started#stack)
and the [examples/stack](../stack) for instructions how to run [terraform](https://terraform.io/)
command to `init` and `apply` detectors.

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
:link: **Contents**

  - [Step by step guide](#step-by-step-guide)
  - [Notes](#notes)
- [Tips](#tips)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## Basic

The [basic.tf](basic.tf) file contains the minimal configuration to import the
[smart-agent_system-common](../../modules/smart-agent_system-common/README.md)
with its default configuration:

1. Define the [source](https://www.terraform.io/docs/language/modules/sources.html#generic-git-repository)
argument using either git or [the Terraform Registry](https://registry.terraform.io/modules/claranet/detectors/signalfx/latest).
1. Set the few common required variables for all sub-modules of this repository

These [common global variables](https://github.com/claranet/terraform-signalfx-detectors/wiki/Structure#common-global)
are the result of an opinionated implementation choice detailed below.

## Environment

The `environment` variable is used as:

- as slug prefix to the names of all deployed detectors like `[myEnv] detector name`
- as value for filter `env` in the SignalFlow program for all detectors

Indeed, all modules propose a default filtering policy following the [tagging
convention](https://github.com/claranet/terraform-signalfx-detectors/wiki/Tagging-convention)
when it is possible and it is based on the environment.

This makes the modules "environment oriented" and require to deploy the same module for each
environment you have. That said, it is possible to override the filtering policy to not
use the environment as filter and make any value you want as prefix replacing the environment.

## Notifications

Every detector has, at least, one alerting rule which has a `severity`.
The `notifications` variable is a map allowing the user to map any alert of deployed detectors
to one or multiple destinations depending on their severity.
The value of this variable will apply the [notification
binding](https://github.com/claranet/terraform-signalfx-detectors/wiki/Notifications-binding)
to all detectors except for those which have its own `my_detector_notification` variable set.

The map contains a key for each severity:

- critical
- major
- minor
- warning
- info

and their value is a list following the [notification
format](https://registry.terraform.io/providers/splunk-terraform/signalfx/latest/docs/resources/detector#notification-format).

## Advanced

The other variables are often optional and have default values which should apply a configuration
roughly suitable for everyone even if some modules can have specific variables or common variables
specifically required.

The [common variables](https://github.com/claranet/terraform-signalfx-detectors/wiki/Variables) allows to:

- assign values to the underlying [detector
resource](https://registry.terraform.io/providers/splunk-terraform/signalfx/latest/docs/resources/detector) arguments
- override the "upper" variable per detector or per rule (like for `notifications`)
- use Terraform synthax to customize the configuration and the behavior of the detectors to meet your requirements

Indeed, if the default configuration should work fine in general it is highly recommended to use
these variables to adapat the configuration to your use case (change thresholds and timeframes to make the alerting
more strict or tolerant) or simply to enjoy all features of the module (enabling detectors which are disabled by default).

The [advanced.tf](advanced.tf) file imports the same module than before but with common configurations changes.

## Notifications

As seen before you have to define the `notifications` variable as a map of destinations list for each severity.
Each key represents a severity and its value, a list of destinations following the [notification
format](https://registry.terraform.io/providers/splunk-terraform/signalfx/latest/docs/resources/detector#notification-format).

The detectors present in the modules of this repository try to defines one or multiple severity rules
adequately with our [notification binding](https://github.com/claranet/terraform-signalfx-detectors/wiki/Notifications-binding)
principle. It allows the user to only define the global `notifications` vairable which will apply
to all detectors of the module.

However, an alert which can seem `critical` (requiring to wake up an oncall agent) for some could not
be the case for others. You cannot change the severity of a rule because it is defined in the module
but you are free to override your global notifications binding per detector, for example, to assign
a lower priority destination for `critical` severity if it seems not crucial for you.

The [notifications.tf](notifications.tf) file shows examples of notifications binding (gloablly and
overriding it per detector) and using alerting services destinations also managed by Terraform (see
[this repository](https://github.com/claranet/terraform-signalfx-integrations/tree/master/alerting).

## Filtering

As seen before, each module defines its own filtering policy used by default and which follow the [tagging
convention](https://github.com/claranet/terraform-signalfx-detectors/wiki/Tagging-convention) when possible.
If not possible, so it will still defines a default policy in a `filters.tf` file instead of using a symlink
to the `common-filters.tf` file and it should be documented in its README.md.

Nevertheless, this is possible to not follow this tagging convention, for example, if you do not want to
add dimensions to your agent or tags to your cloud managed services by defining the `filtering_custom`
variable to string following the [SignalFlow syntax](https://dev.splunk.com/observability/docs/signalflow/functions/filter_function/).
It is even possible to define it the empty string `""` if you do not want filters at all. In this case,
the detectors will apply to all MTS.

Finally, it is also possible to combine these 2 approachs by also set the `filtering_append` to `true`.
From this way both default filtering policy defined in the module and your own custom filtering policy
defined by `filtering_custom` will be combined with the `and` logical operator.

See the [filtering.tf](filtering.tf) file for examples.

In any cases, the `environment` is still required and will be added a slug prefix to detector's names
even if you define your custom filtering policy which does not use it. That said, you can set it to
any value even if it is not an environment to add a minimal context to your detector's names and
avoid to have multiple detectors with the same name in case of multi instantiation of the same module.

## Multi instantiation

TODO
