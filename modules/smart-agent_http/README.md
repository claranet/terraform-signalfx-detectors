# HTTP SignalFx detectors

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
:link: **Contents**

- [How to use this module?](#how-to-use-this-module)
- [What are the available detectors in this module?](#what-are-the-available-detectors-in-this-module)
- [How to collect required metrics?](#how-to-collect-required-metrics)
  - [Monitors](#monitors)
  - [Metrics](#metrics)
- [Notes](#notes)
- [Related documentation](#related-documentation)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## How to use this module?

This directory defines a [Terraform](https://www.terraform.io/) 
[module](https://www.terraform.io/docs/modules/usage.html) you can use in your
existing [stack](https://github.com/claranet/terraform-signalfx-detectors/wiki/Getting-started#stack) by adding a 
`module` configuration and setting its `source` parameter to URL of this folder:

```hcl
module "signalfx-detectors-smart-agent-http" {
  source = "github.com/claranet/terraform-signalfx-detectors.git//modules/smart-agent_http?ref={revision}"

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
  filters](https://github.com/claranet/terraform-signalfx-detectors/wiki/Guidance#filtering) based on our default 
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
[variables.tf](variables.tf).
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
|HTTP heartbeat|X|-|-|-|-|
|HTTP code|X|-|-|-|-|
|HTTP regex expression|X|-|-|-|-|
|HTTP response time|X|X|-|-|-|
|HTTP content length|-|-|-|X|-|
|TLS certificate expiry date|-|X|X|-|-|
|TLS certificate|X|-|-|-|-|

## How to collect required metrics?

This module uses metrics available from 
[monitors](https://docs.signalfx.com/en/latest/integrations/agent/monitors/_monitor-config.html)
available in the [SignalFx Smart 
Agent](https://github.com/signalfx/signalfx-agent). Check the [Related documentation](#related-documentation) section for more 
information including the official documentation of this monitor.


There is no SignalFx official integration for `http` but there is still a 
[monitor](https://docs.signalfx.com/en/latest/integrations/agent/monitors/http.html) to use.

### Monitors

This monitor is only available from agent version `>= 5.2.0` but it has evolved since and we 
recommend to use at least version `v5.5.6`.

Check the examples in the official monitor documentation and the Notes section below.


### Metrics


To filter only required metrics for the detectors of this module, add the 
[datapointsToExclude](https://docs.signalfx.com/en/latest/integrations/agent/filtering.html) parameter to 
the corresponding monitor configuration:

```yaml
    datapointsToExclude:
      - metricNames:
        - '*'
        - '!http.cert_expiry'
        - '!http.cert_valid'
        - '!http.code_matched'
        - '!http.content_length'
        - '!http.regex_matched'
        - '!http.response_time'
        - '!http.status_code'

```

## Notes

This module creates some detectors to check web urls and optionally their associated tls certificates.

* By default, `signalfx-agent` collection interval is `10s`. Depending of webservices 
checked this could dangerous or useless to requet them as often so you can change 
`intervalSeconds` monitor(s) parameter as you prefer.

* The transformation allows to adapt sensitivity applying its function on a timeframe
which will change the evaluated value. The alert will be raised as soon the conditions are
met but comapared to a transformed value not true to reality and obviously more favorable.
This also affect the chart which could be not desired especially for troubleshooting
(webchecks often require accuracy). I.e. `max(over='15m')` on `http_code_matched` will
always be OK (`1`) on alert (and so chart also) even if more than `50%` of checks done
on the timeframe are failed.

* The `lasting` function does not change the value. It could apply on an evaluated value
different from the orginal (i.e. if you set `transformation_function` explicitely).
The chart will show the exact real value and even alert condition itself will be met
strictly immediately but alert will be raised only at the end of lasting timeframe
if the conditions have always remained.

* The `http.code_matched` and `http.regex.matched` based detectors are the most critical
They have only one severity (`Critical`) and use `lasting` function in addition to usual
transformation function (by default, not set only for them) which could affect 
their "sensitivity".

* By default, this module will raise alerts these detectors with moderate sensitivity in 
combination with `10s` collection interval and `lasting('60s')`: `6` datapoints for 1m
so the webcheck could fail 5 consecutive times before raising alert.

* Feel free to use variables to adapt this sensitivity depending of your needs to make 
detectors more tolerant (increasing lasting timeframe or even adding transformation) or
more strict (decreasing lasting timeframe or changing transformation function from `max`
to `min`).

* If you have multiple webhecks which require different sensitivity level so you can add
common dimension using `addExtraDimensions` to set of similar monitors on agent. Then,
you can import as many times this module with different value for `filter_custom_*` variables 
to match these different dimension(s) value(s).

* The certificate metrics will be collected only if `useHTTPS: true` (or if using the
deprecated `urls`) monitor option AND if the website supports and redirects `https`.

* The `http_content_length` based detector is disabled by default because not considered
as generic purpose but `disabled` variables allow to change this.


## Related documentation

* [Terraform SignalFx provider](https://registry.terraform.io/providers/splunk-terraform/signalfx/latest/docs)
* [Terraform SignalFx detector](https://registry.terraform.io/providers/splunk-terraform/signalfx/latest/docs/resources/detector)
* [Smart Agent monitor](https://docs.signalfx.com/en/latest/integrations/agent/monitors/http.html)
