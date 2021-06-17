# MDADM SignalFx detectors

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
:link: **Contents**

- [How to use this module?](#how-to-use-this-module)
- [What are the available detectors in this module?](#what-are-the-available-detectors-in-this-module)
- [How to collect required metrics?](#how-to-collect-required-metrics)
  - [Monitors](#monitors)
  - [Examples](#examples)
  - [Metrics](#metrics)
- [Notes](#notes)
  - [About `Disk failed` detector](#about-disk-failed-detector)
  - [About `Disk missing` detector](#about-disk-missing-detector)
- [Related documentation](#related-documentation)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## How to use this module?

This directory defines a [Terraform](https://www.terraform.io/) 
[module](https://www.terraform.io/docs/modules/usage.html) you can use in your
existing [stack](https://github.com/claranet/terraform-signalfx-detectors/wiki/Getting-started#stack) by adding a 
`module` configuration and setting its `source` parameter to URL of this folder:

```hcl
module "signalfx-detectors-smart-agent-mdadm" {
  source = "github.com/claranet/terraform-signalfx-detectors.git//modules/smart-agent_mdadm?ref={revision}"

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
  In general, it will also be used in the `filtering` internal sub-module to [apply
  [filters](https://github.com/claranet/terraform-signalfx-detectors/wiki/Guidance#filtering) based on our default 
  [tagging convention](https://github.com/claranet/terraform-signalfx-detectors/wiki/Tagging-convention) by default.

* `notifications`: Use this parameter to define where alerts should be sent depending on their severity. It consists 
  of a Terraform [object](https://www.terraform.io/docs/configuration/types.html#object-) where each key represents an 
  available [detector rule severity](https://docs.signalfx.com/en/latest/detect-alert/set-up-detectors.html#severity) 
  and its value is a list of recipients. Every recipients must respect the [detector notification 
  format](https://registry.terraform.io/providers/splunk-terraform/signalfx/latest/docs/resources/detector#notification-format).
  Check the [notification binding](https://github.com/claranet/terraform-signalfx-detectors/wiki/Notifications-binding) 
  documentation to understand the recommended role of each severity.

These 3 parameters alongs with all variables defined in [common-variables.tf](common-variables.tf) are common to all 
[modules](../) in this repository. Other variables, specific to this module, are available in 
[variables-gen.tf](variables-gen.tf).
In general, the default configuration "works" but all of these Terraform 
[variables](https://www.terraform.io/docs/configuration/variables.html) make it possible to 
customize the detectors behavior to better fit your needs.

Most of them represent usual tips and rules detailled in the 
[guidance](https://github.com/claranet/terraform-signalfx-detectors/wiki/Guidance) documentation and listed in the 
common [variables](https://github.com/claranet/terraform-signalfx-detectors/wiki/Variables) dedicated documentation.

Feel free to explore the [wiki](https://github.com/claranet/terraform-signalfx-detectors/wiki) for more information about 
general usage of this repository.

## What are the available detectors in this module?

This module creates the following SignalFx detectors which could contain one or multiple alerting rules:

|Detector|Critical|Major|Minor|Warning|Info|
|---|---|---|---|---|---|
|Mdadm disk failed|X|X|-|-|-|
|Mdadm disk missing|X|X|-|-|-|

## How to collect required metrics?

This module uses metrics available from 
[monitors](https://docs.signalfx.com/en/latest/integrations/agent/monitors/_monitor-config.html)
available in the [SignalFx Smart 
Agent](https://github.com/signalfx/signalfx-agent). Check the "Related documentation" section for more 
information including the official documentation of this monitor.


There is no SignalFx official integration nor a monitor for `mdadm` but we use the 
[collectd/custom monitor](https://docs.signalfx.com/en/latest/integrations/agent/monitors/collectd-custom.html)
with bundled `md` collectd plugin.

### Monitors

The Collectd plugin requires access on MD devices owned by user `root` and group `disk`.  
So you have to allow the user running signalfx-agent to run `mdadm` on these devices by adding it to `disk` group:

```bash
usermod -a -G disk signalfx-agent
```

### Examples

Here is a sample configuration fragment for the SignalFx agent monitors:

```yaml
monitors:
- type: collectd/custom
  template: |
    LoadPLugin md
```


### Metrics


To filter only required metrics for the detectors of this module, add the 
[datapointsToExclude](https://docs.signalfx.com/en/latest/integrations/agent/filtering.html) parameter to 
the corresponding monitor configuration:

```yaml
    datapointsToExclude:
      - metricNames:
        - '*'
        - '!md_disks.failed'
        - '!md_disks.missing'

```

## Notes

### About `Disk failed` detector

The detector triggers:
  - a `major` alert rule when metric `md_disks.failed > 0`
  - a `critical` alert rule when metric `md_disks.failed > 1`

### About `Disk missing` detector
  - a `major` alert rule when metric `md_disks.missing > 0`
  - a `critical` alert rule when metric `md_disks.missing > 1`


## Related documentation

* [Terraform SignalFx provider](https://registry.terraform.io/providers/splunk-terraform/signalfx/latest/docs)
* [Terraform SignalFx detector](https://registry.terraform.io/providers/splunk-terraform/signalfx/latest/docs/resources/detector)
* [Smart Agent monitor](https://docs.signalfx.com/en/latest/integrations/agent/monitors/collectd-php-fpm.html)
* [Collectd plugin](https://collectd.org/wiki/index.php/Plugin:MD)
