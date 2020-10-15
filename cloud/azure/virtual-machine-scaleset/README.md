# CLOUD AZURE VirtualMachineScaleSet SignalFx detectors

Not like the VirtualMachines module, we decided to not monitor CPU on ScaleSet because it's a non sense on something which should autoscale automatically.

For this first version we will only check if the ScaleSet is running with at least one node (Percent CPU heartbeat).
Next step will be to use signalFx outlier to, for example, check if all VMs in the ScaleSet use the same percent of CPU.

## How to use this module

```hcl
module "signalfx-detectors-cloud-azure-virtual-machine-scaleset" {
  source = "github.com/claranet/terraform-signalfx-detectors.git//cloud/azure/virtual-machine-scaleset?ref={revision}"

  environment   = var.environment
  notifications = local.notifications

}
```

## Purpose

Creates SignalFx detectors with the following checks:

* Azure Virtual Machine ScaleSet heartbeat


## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| detectors\_disabled | Disable all detectors in this module | `bool` | `false` | no |
| environment | Infrastructure environment | `string` | n/a | yes |
| filter\_custom\_excludes | List of tags to exclude when custom filtering is used | `list` | `[]` | no |
| filter\_custom\_includes | List of tags to include when custom filtering is used | `list` | `[]` | no |
| heartbeat\_aggregation\_function | Aggregation function and group by for heartbeat detector (i.e. ".mean(by=['host'])") | `string` | `".mean(by=['azure_resource_id'])"` | no |
| heartbeat\_disabled | Disable all alerting rules for heartbeat detector | `bool` | `null` | no |
| heartbeat\_notifications | Notification recipients list per severity overridden for heartbeat detector | `map(list(string))` | `{}` | no |
| heartbeat\_timeframe | Timeframe for heartbeat detector (i.e. "10m") | `string` | `"20m"` | no |
| notifications | Default notification recipients list per severity | <pre>object({<br>    critical = list(string)<br>    major    = list(string)<br>    minor    = list(string)<br>    warning  = list(string)<br>    info     = list(string)<br>  })</pre> | n/a | yes |
| prefixes | Prefixes list to prepend between brackets on every monitors names before environment | `list` | `[]` | no |

## Outputs

| Name | Description |
|------|-------------|
| heartbeat | Detector resource for heartbeat |