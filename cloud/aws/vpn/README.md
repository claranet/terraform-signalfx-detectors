# AWS VPN SignalFx detectors

## How to use this module

```hcl
module "signalfx-detectors-aws-vpn" {
  source      = "github.com/claranet/terraform-signalfx-detectors.git//cloud/aws/vpn?ref=master"

  prefixes      = [var.vpn_id]
  environment   = var.env
  filter_custom_includes =  [format("VpnId:%s", var.vpn_id)]
  notifications = var.notifications 
}
```

**Note :** for now, SignalFx does not sync AWS VPN tags so the default filtering with the `env` tag is not working. The best way to use this module is to filter for each VPN connections with its id. You will need to instantiate this module for each VPN connections.
