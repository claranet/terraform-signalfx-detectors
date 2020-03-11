# FILTER TAGS SignalFx Generator

## How to use this module

This module usage should be transparent because it should be used inside each detectors modules directly.
Here is a simple example but it is advisable to see how are created other existing detectors modules:

```hcl
module "filter-tags" {
  source                 = "github.com/claranet/terraform-signalfx-detectors.git//common/filter-tags?ref={revision}"

  filter_defaults        = "filter('env', '${var.environment}') and filter('claranet_monitored', 'true')"
  filter_use_defaults    = var.filter_use_defaults
  filter_custom_includes = var.filter_custom_includes
  filter_custom_excludes = var.filter_custom_excludes
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
| filter\_custom\_excludes | Semicolon separated string of filters to exclude when custom filtering is used (i.e "ex1:clude1;tag2:val2") | `string` | `""` | no |
| filter\_custom\_includes | Semicolon separated string of filters to include when custom filtering is used (i.e "in1:clude1;tag2:val2") | `string` | `""` | no |
| filter\_defaults | List of tags tu use as filters when using default filtering convention | `string` | `""` | no |
| filter\_use\_defaults | Use default filtering convention | `bool` | `true` | no |

## Outputs

| Name | Description |
|------|-------------|
| filter\_custom | The full filtering pattern to use in detectors |

## Related documentation

[SignalFlow filters API documentation](https://developers.signalfx.com/signalflow_analytics/signalflow_overview.html#_filters)
