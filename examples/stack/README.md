# SignalFx Detectors Example

Here is a possible 
[stack](https://github.com/claranet/terraform-signalfx-detectors/wiki/Getting-started#stack) 
implementation example to use and deploy detectors modules available in this repository.

In this example we deploy the `system-common` detectors to monitor metrics which are common to all 
operating systems. It could exist other "specific" versions usable in addition to this `common` module.

This configuration is very basic and only defines one email address `doc@signalfx.null` as notifications 
recipient for alerts of all detectors of the module, all their alerting rules, and all their severities.

In general, you want probably smarter notifications definition, you can even define multiple locals 
for different use cases (business hour only vs h24 alert) and assign the right local for each module 
you call depending on the importance for you.

1. `git clone` this repo to your computer.
1. Install [Terraform](https://www.terraform.io/).
1. Open `variables.tf`, and set the a default value for `environment` variable like `doc`.
1. Run `terraform init`.
1. Run `terraform apply`.
