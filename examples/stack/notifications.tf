variable "global_recipient" {
  description = "Recipient assigned globally to every notifications severity rules"
  type = object({
    type = string
    args = string
  })
  default = {
    type = "Email"
    args = "doc@signalfx.null"
  }
}

locals {
  notification_global = format("%s,%s", var.global_recipient.type, var.global_recipient.args)
  notifications = {
    critical = [local.notification_global]
    major    = [local.notification_global]
    minor    = [local.notification_global]
    warning  = [local.notification_global]
    info     = [local.notification_global]
  }
}

