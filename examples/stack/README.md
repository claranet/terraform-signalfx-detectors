# SignalFx Detectors Example

Here is a possible 
[stack](https://github.com/claranet/terraform-signalfx-detectors/wiki/Getting-started#stack) 
implementation example to use and deploy detectors modules available in this repository.

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
:link: **Contents**

- [Step by step guide](#step-by-step-guide)
- [Notes](#notes)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## Step by step guide

1. `git clone` this repository to your computer.
1. Install [Terraform](https://www.terraform.io/).
1. Open `variables.tf`, and set the a default value for `environment` variable like `doc`.
1. Run `terraform init`.
1. Run `terraform apply`.

Now you can improve the default configuration of each module following the wiki 
[Guidance](https://github.com/claranet/terraform-signalfx-detectors/wiki/Guidance) to 
meet your own needs.

## Notes

In this example we deploy the `system-common` detectors to monitor metrics which are common to all 
operating systems. It could exist other "specific" versions usable in addition to this `common` module.

This configuration is very basic and only defines one email address `doc@signalfx.null` as notifications 
recipient for alerts of all detectors of the module, all their alerting rules, and all their severities.

In general, you want probably smarter notifications definition, you can even define multiple locals 
for different use cases (business hour only vs h24 alert) and assign the right local for each module 
you call depending on the importance for you.

