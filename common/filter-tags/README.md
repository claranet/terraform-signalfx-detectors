# FILTER TAGS SignalFx

__DEPRECATION WARNING__: this module is kept only for retro compatibility of versions prior to `v1.7.0` that referenced it without specifying a tag.
Since this version, the [../../modules/internal_filtering/](../../modules/internal_filtering/) module
replaces it and is imported using a relative path source which will ensure each version has its own
dependency and will avoid undesired breaking changes. This module will be dropped in a future major version.

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
:link: **Contents**

- [How to use this module?](#how-to-use-this-module)
- [Why?](#why)
- [Related documentation](#related-documentation)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## How to use this module?

This module usage should be transparent because it should be used inside each detectors modules directly.
Here is a simple example but it is advisable to see how are created other existing detectors modules:

This directory defines a [Terraform](https://www.terraform.io/) 
[module](https://www.terraform.io/docs/modules/usage.html). It is a "common" used internally by modules of 
detectors. That said it could be used by everyone by adding `module` configuration and setting its `source` 
parameter to URL of this folder:

```hcl
variable "environment" {
  type    = string
  default = "doc"
}

module "filter-tags" {
  source = "github.com/claranet/terraform-signalfx-detectors.git//common/filter-tags?ref={revision}"

  filter_defaults        = "filter('env', '${var.environment}') and filter('sfx_monitored', 'true')"
  filter_custom_includes = ["signalfx:dimensions", "to:match]
  filter_custom_excludes = ["another:to", "not:match"]
}

resource "signalfx_detector" "disk" {
  name = "My awesome disk detector"

  program_text = <<-EOF
        signal = data('disk.utilization', filter=filter('myKey', 'myValue') and ${module.filter-tags.filter_custom}).max(over='5m').publish('signal')
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

* `filter_defaults`: Use this parameter to specify the `default` filters as a pure 
  [signalflow](https://dev.splunk.com/observability/docs/signalflow/functions/filter_function/) string. If you do not 
  define next parameters it will output this so it is basically useless if for a static value. nevertheless, it could 
  be useful to generate a dynamic value from terraform capabilities from your own code.

* `filter_custom_includes` and `filter_custom_excludes`: Use these parameters to specify the `custom` filters as a 
  list of strings `"key:value"` formatted. If you define at least one of them the `filter_defaults` value will not be 
  used anymore and the output will be composed from the list of dimensions to include or exclude respectively.

## Why?

This module has only one goal: provide a conditional outputs from user inputs.
It should never be useful in your terraform stack but in another module only. 

It was created for detectors modules which forward user inputs to this one and allow to either:

* use the default filtering signalflow string defined in the detectors module calling this one
* or define a custom filtering string using user inputs from their stacks calling the detectors module

This enfore a filtering that follows the [tagging 
convention](https://github.com/claranet/terraform-signalfx-detectors/wiki/Tagging-convention) by default but allow 
users to define custom one based on simple inclusion / exclusion lists.

In this way we can use the `filter_custom` output as a "constant" in terraform code but its value could change depending 
on its parent module configuration.

It is useful for example to [multi 
instance](https://github.com/claranet/terraform-signalfx-detectors/wiki/Guidance#Multiple-instances) the same detectors 
module to make an exception or deploy monitoring per resource.

## Related documentation

* [SignalFlow filters](https://developers.signalfx.com/signalflow_analytics/signalflow_overview.html#_filters)
