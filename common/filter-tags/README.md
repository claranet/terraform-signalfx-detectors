# FILTER TAGS SignalFx Generator

## How to use this module

This module usage should be transparent because it should be used inside each detectors modules directly.
Here is a simple example but it is advisable to see how are created other existing detectors modules:

```hcl
module "filter-tags" {
  source                 = "github.com/claranet/terraform-signalfx-detectors.git//common/filter-tags?ref={revision}"

  filter_defaults        = "filter('env', '${var.environment}') and filter('claranet_monitored', 'true')"
  filter_custom_includes = var.filter_custom_includes # should be `[]` to follow default tagging convention
  filter_custom_excludes = var.filter_custom_excludes # should be `[]` to follow default tagging convention
}

resource "signalfx_detector" "disk" {
  name = "My awesome disk detector"

  program_text = <<-EOF
        signal = data('disk.utilization', filter=filter('myKey', 'myValue') and ${module.filter-tags.filter_custom}).max(over='5m').publish('signal')
        detect(when(signal > 80)).publish('disk space too high')
    EOF
  #...
}

```

## Purpose

Use dedicated module to generate right filters queries on detectors SignalFlow.

It will allow to:

* either use default tagging convention as filters
* or use a custom filters if default tagging is not possible
* in both cases preserving any required filters specific to each detector

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| filter\_custom\_excludes | List of tags to exclude when custom filtering is used | `list` | `[]` | no |
| filter\_custom\_includes | List of tags to include when custom filtering is used | `list` | `[]` | no |
| filter\_defaults | Filters as SignalFlow string to use when using default filtering convention | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| filter\_custom | The full filtering pattern to use in detectors |

## Related documentation

[SignalFlow filters API documentation](https://developers.signalfx.com/signalflow_analytics/signalflow_overview.html#_filters)
