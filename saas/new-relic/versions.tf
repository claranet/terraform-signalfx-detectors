terraform {
  required_providers {
    signalfx = {
      source  = "splunk-terraform/signalfx"
      version = ">= 4.26.4"
    }
  }
  required_version = ">= 0.12.26"
}
