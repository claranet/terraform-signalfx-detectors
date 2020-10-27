---
name: Bug report on templating
about: Modules templating, config or deployment bugs
title: "[BUG][TEMPLATE]"
labels: bug, templating
assignees: ''

---

**Describe the bug**
A clear and concise description of what the bug is, what module, templating, deployment or terraform feature it concerns.

**Code sample**
Terraform code snippet with minimal config to test:
```hcl
variable "environment" {
  default = "testing"
  type    = string
}

locals {
  recipients = [ "dev@null.com" ]
  notifications = {
    critical = local.recipients
    major    = local.recipients
    minor    = local.recipients
    warning  = local.recipients
    info     = local.recipients
  }
}

module "signalfx-detectors-system-generic" {
  source = "github.com/claranet/terraform-signalfx-detectors.git//system/generic?ref=master"

  environment   = var.environment
  notifications = local.notifications
  // additional config
}
``` 

**To Reproduce**
Steps to reproduce the behavior:
1. Init 'terraform init'
2. Deploy terraform apply
3. See error / unexpected result
```
Error or Output
```

**Expected behavior**
A clear and concise description of what you expected to happen and difference compared to previous section.

**Additional context**
Add any other context about the problem here or any clue, idea or suggestion you could have in mind.
