terraform {
  required_providers {
    signalfx = {
      source  = "terraform-providers/signalfx"
      version = ">= 4.26.4"
    }
  }
  required_version = ">= 0.12.24"
}
