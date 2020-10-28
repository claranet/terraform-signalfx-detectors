# AWS ECS CLUSTER SignalFx detectors

## How to use this module

```hcl
module "signalfx-detectors-middleware-nginx" {
  source      = "github.com/claranet/terraform-signalfx-detectors.git//middleware/nginx?ref={revision}"

  environment = var.environment
  notifications = var.notifications
}

```

## Notes

This module applies only on AWS ECS of type `EC2` (not `Fargate`). The difference compared to [Fargate 
module](../service/README.md) lies in the dimension filtering out `ServiceName`. See the [official cloudwatch 
documentation](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/cloudwatch-metrics.html#available_cloudwatch_metrics)
for more information.
