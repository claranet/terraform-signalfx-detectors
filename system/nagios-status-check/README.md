# NAGIOS-STATUS-CHECK SignalFx detectors

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
:link: **Contents**

- [How to use this module?](#how-to-use-this-module)
- [What are the available detectors in this module?](#what-are-the-available-detectors-in-this-module)
- [How to collect required metrics?](#how-to-collect-required-metrics)
  - [Monitors](#monitors)
  - [Examples](#examples)
- [Notes](#notes)
- [Related documentation](#related-documentation)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## How to use this module?

This directory defines a [Terraform](https://www.terraform.io/) 
[module](https://www.terraform.io/docs/modules/usage.html) you can use in your
existing [stack](https://github.com/claranet/terraform-signalfx-detectors/wiki/Getting-started#stack) by adding a 
`module` configuration and setting its `source` parameter to URL of this folder:

```hcl
module "signalfx-detectors-system-nagios-status-check" {
  source = "github.com/claranet/terraform-signalfx-detectors.git//system/nagios-status-check?ref={revision}"

  environment   = var.environment
  notifications = local.notifications
}
```

Note the following parameters:

* `source`: Use this parameter to specify the URL of the module. The double slash (`//`) is intentional  and required. 
  Terraform uses it to specify subfolders within a Git repo (see [module
  sources](https://www.terraform.io/docs/modules/sources.html)). The `ref` parameter specifies a specific Git tag in
  this repository. It is recommended to use the latest "pinned" version in place of `{revision}`. Avoid using a branch 
  like `master` except for testing purpose. Note that every modules in this repository are available on the Terraform 
  [registry](https://registry.terraform.io/modules/claranet/detectors/signalfx) and we recommend using it as source 
  instead of `git` which is more flexible but less future-proof.

* `environment`: Use this parameter to specify the 
  [environment](https://github.com/claranet/terraform-signalfx-detectors/wiki/Getting-started#environment) used by this 
  instance of the module.
  Its value will be added to the `prefixes` list at the start of the [detector 
  name](https://github.com/claranet/terraform-signalfx-detectors/wiki/Templating#example).
  In general, it will also be used in `filter-tags` sub-module to apply a
  [filtering](https://github.com/claranet/terraform-signalfx-detectors/wiki/Guidance#filtering) based on our default 
  [tagging convention](https://github.com/claranet/terraform-signalfx-detectors/wiki/Tagging-convention) by default.

* `notifications`: Use this parameter to define where alerts should be sent depending on their severity. It consists 
  of a Terraform [object](https://www.terraform.io/docs/configuration/types.html#object-) where each key represents an 
  available [detector rule severity](https://docs.signalfx.com/en/latest/detect-alert/set-up-detectors.html#severity) 
  and its value is a list of recipients. Every recipients must respect the [detector notification 
  format](https://registry.terraform.io/providers/splunk-terraform/signalfx/latest/docs/resources/detector#notification-format).
  Check the [notification binding](https://github.com/claranet/terraform-signalfx-detectors/wiki/Notifications-binding) 
  documentation to understand the recommended role of each severity.

There are other Terraform [variables](https://www.terraform.io/docs/configuration/variables.html) in 
[variables.tf](variables.tf) so check their description to customize the detectors behavior to fit your needs. Most of them are 
common [variables](https://github.com/claranet/terraform-signalfx-detectors/wiki/Variables).
The [guidance](https://github.com/claranet/terraform-signalfx-detectors/wiki/Guidance) documentation will help you to use 
common mechanims provided by the modules like [multi 
instances](https://github.com/claranet/terraform-signalfx-detectors/wiki/Guidance#Multiple-instances).

Feel free to explore the [wiki](https://github.com/claranet/terraform-signalfx-detectors/wiki) for more information about 
general usage of this repository.

## What are the available detectors in this module?

This module creates the following SignalFx detectors which could contain one or multiple alerting rules:

* Nagios check status

## How to collect required metrics?

This module uses metrics available from 
[monitors](https://docs.signalfx.com/en/latest/integrations/agent/monitors/_monitor-config.html)
available in the [SignalFx Smart 
Agent](https://github.com/signalfx/signalfx-agent). Check the "Related documentation" section for more 
information including the official documentation of this monitor.


There is no SignalFx official integration for `Nagios` but there is still a 
[monitor](https://docs.signalfx.com/en/latest/integrations/agent/monitors/telegraf-exec.html) to use.

### Monitors

You have to configure your existing Nagios script into the `telegraf/exec` monitor.

You can configure as many monitors as you have nagios checks to reuse but you have to define for each 
one at least:

* the `dataFormat: nagios` in `telegrafParser` parameter to parse status from script exit code.
* at least one dimension like `script` in `extraDimensions` to identify your check. If you do not 
define `aggregation_function` and let empty as by default it will work for all dimensions you choose.

Also it could be useful to adapt the `intervalSeconds` for each script.

### Examples

```yaml
- type: telegraf/exec
  intervalSeconds: 180
  command: /usr/local/bin/scripts/check-ipmitool.pl
  extraDimensions:
    script: check_ipmitool
  telegrafParser:
    dataFormat: nagios
- type: telegraf/exec
  intervalSeconds: 900  
  command: /usr/local/bin/scripts/check-megaraidsas
  extraDimensions:
    script: check_megaraidsas
  telegrafParser:
    dataFormat: nagios
```


## Notes

This module has been designed to alert with the same behavior as 
[Nagios](https://nagios-plugins.org/doc/guidelines.html#AEN78), basically a gauge equal to 1, 2 and 3 
respectively triggering `WARNING`, `CRITICAL` and `UNKNOWN` alert.

While SignalFx does not provide `Unknown` severity this module uses the `Major` severity for unknown alerts.

The metric is named `nagios_state.state`, you need to add an `extraDimensions` to your monitor in order to be 
able to differantiate multiple script states.


## Related documentation

* [Terraform SignalFx provider](https://registry.terraform.io/providers/splunk-terraform/signalfx/latest/docs)
* [Terraform SignalFx detector](https://registry.terraform.io/providers/splunk-terraform/signalfx/latest/docs/resources/detector)
* [Smart Agent monitor](https://docs.signalfx.com/en/latest/integrations/agent/monitors/telegraf-exec.html)
* [Nagios checks guidelines](https://nagios-plugins.org/doc/guidelines.html#AEN78)
* [Telegraf plugin exec](https://github.com/influxdata/telegraf/tree/master/plugins/inputs/exec)
* [Telegraf parser nagios](https://github.com/influxdata/telegraf/tree/master/plugins/parsers/nagios)
