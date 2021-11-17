# FILTERING

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
:link: **Contents**

- [How to use this module?](#how-to-use-this-module)
- [Why?](#why)
- [Related documentation](#related-documentation)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## How to use this module?

This directory defines a classic [Terraform](https://www.terraform.io/)
[module](https://www.terraform.io/docs/modules/usage.html) which can be used by everyone by adding `module`
configuration and setting its `source` parameter to URL of this folder:

```hcl
variable "environment" {
  type    = string
  default = "doc"
}

module "filtering" {
  source = "github.com/claranet/terraform-signalfx-detectors.git//modules/internal_filtering?ref={revision}"

  filtering_default = "filter('env', '${var.environment}') and filter('sfx_monitored', 'true')"
  filtering_custom  = "filter('foo', 'bar)"
  append_mode       = true
}

resource "signalfx_detector" "disk" {
  name = "My awesome disk detector"

  program_text = <<-EOF
        signal = data('disk.utilization', filter=filter('myKey', 'myValue') and ${module.filtering.signalflow}).max(over='5m').publish('signal')
        detect(when(signal > 80)).publish('disk space too high')
    EOF
  # ...
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

* `filtering_default`: Use this parameter to specify the **default** filters as a pure
  [signalflow](https://dev.splunk.com/observability/docs/signalflow/functions/filter_function/) string. If you do not
  define next parameters it will output this so it is basically useless. Nevertheless, it could
  be useful to generate a dynamic value from terraform capabilities like variables from your own code.

* `filtering_custom`: Use this parameter to specify the **custom** filters as a pure signalflow string again.
  By default, as soon as you define this so you will replace the **default** filtering policy by your own useful
  if you do not want to follow the default tagging convention enforced in this repository.

* `append_mode`: if set to `true`, so the `filtering_custom` will be appended to the `filtering_default` with a `and`
  logical operator instead of entirely replace it. It is useful if you still want to respect the default tagging
  convention enforced by this repository adding your own logic (like a new dimensions as `team`) or to handle
  some special cases where advanced [filtering](https://dev.splunk.com/observability/docs/signalflow/functions/filter_function/)
  is required.

## Why?

This module has only one goal: provide a conditional output so it can save code repetition,
enforcing a default filtering with the ability to override it by the user intputs.

It was created for detectors modules which forward user inputs to this one and allow to either:

- enforce a default filtering policy from this repository following our [tagging
convention](https://github.com/claranet/terraform-signalfx-detectors/wiki/Tagging-convention).
- allow the user to override this filtering by a custom one either by replace the default one or append to it.

In this way we can use the `signalflow` output as a "constant" in terraform code but its value could change depending
on its parent module configuration.

It is useful for example to [multi
instance](https://github.com/claranet/terraform-signalfx-detectors/wiki/Guidance#Multiple-instances) the same detectors
module to make an exception or deploy monitoring per resource.

## Related documentation

* [SignalFlow filters](https://developers.signalfx.com/signalflow_analytics/signalflow_overview.html#_filters)
