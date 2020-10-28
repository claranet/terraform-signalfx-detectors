# AWS ECS ( EC2 ) SignalFx detectors

## How to use this module

```hcl
# ECS / cluster
module "signalfx-detectors-cloud-aws-cloud-ecs-cluster" {
  source = "github.com/claranet/terraform-signalfx-detectors.git//cloud/aws/ecs/cluster?ref=master"

  prefixes      = [var.app_name]
  environment   = var.env
  filter_custom_includes =  [format("EnvironmentName:%s", var.app_name)]
  notifications = var.notifications 
}
```

**Note :** take care that this module apply only for AWS EC2 ECS not Fargate. For an explanation, please look at https://docs.aws.amazon.com/AmazonECS/latest/developerguide/cloudwatch-metrics.html#available_cloudwatch_metrics
