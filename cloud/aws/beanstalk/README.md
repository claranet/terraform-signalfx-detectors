# AWS Beanstalk SignalFx detectors

## How to use this module

```hcl
module "signalfx-detectors-aws-beanstalk" {
  source      = "github.com/claranet/terraform-signalfx-detectors.git//cloud/aws/beanstalk?ref=master"

  prefixes      = [var.app_name]
  environment   = var.env
  filter_custom_includes =  [format("EnvironmentName:%s", var.app_name)]
  notifications = var.notifications 
}
```

**Note :** for now, SignalFx does not sync AWS Beanstalk tags so the default filtering with the `env` tag is not working. The best way to use this module is to filter with your AWS Beanstalk environment name. You will need to instantiate this module for each Beanstalk environment.
