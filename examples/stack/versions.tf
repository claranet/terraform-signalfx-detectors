terraform {
  required_providers {
    signalfx = {
      source  = "splunk-terraform/signalfx"
      version = ">= 6.7.3"
    }
  }
  required_version = ">= 0.12.26"
}
