# Templates

A list of [jinja](https://jinja.palletsprojects.com/) 
based templates rendering terraform code from [SignalFx 
provider](https://github.com/splunk-terraform/terraform-provider-signalfx).

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
:link: **Contents**

- [Requirements](#requirements)
- [Generator](#generator)
  - [Goal](#goal)
  - [Limit](#limit)
  - [Requirements](#requirements-1)
  - [Structure](#structure)
  - [Usage](#usage)
  - [Examples](#examples)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## Requirements

Before being able to use the j2 based generator(s) you have to [setup your 
environment](/docs/environment.md).

Then, you can either run `make` to enter in the docker container and use all 
available commands like `j2` or run the container as a "oneshot" command like:
```bash
$ docker run --rm -ti -v "${PWD}:/work" claranet/terraform-ci:latest j2 scripts/templates/detector.tf.j2 scripts/templates/examples/heartbeat-simple.yaml
resource "signalfx_detector" "heartbeat" {
  name      = format("%s %s", local.detector_name_prefix, "Webcheck heartbeat")
  max_delay = 900

  program_text = <<-EOF
    from signalfx.detectors.not_reporting import not_reporting
    signal = data('webcheck_status_code', filter=${module.filter-tags.filter_custom})${var.heartbeat_aggregation_function}.publish('signal')
    not_reporting.detector(stream=signal, resource_identifier=None, duration='${var.heartbeat_timeframe}').publish('CRIT')
EOF

  rule {
    description           = "has not reported in ${var.heartbeat_timeframe}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.heartbeat_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.heartbeat_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = local.rule_subject_novalue
    parameterized_body    = local.rule_body
  }
}
```

## Generator

Templates could be used to generate code from preset configurations or
custom scripts.

### Goal

The first goal is to help and make it easier to contribute:

* it aims to reduce the effort to bootstrap detector taking care of redundant tasks.
* it could allows someone without terraform knowledge to add content.
* it will enforce homogeneity and best practices across every modules
which should improve reliability and understanding.

Nevertheless, it could bring other possibilities:

* the CI could auto generate terraform code based on preset config files.
* this could cover majority of detectors and use cases maitaining simple yaml and 
allow easy update of them when we change guideline.
* this will allow to focus on few complex implementations to manage manually.
* this is always recommended to implement more specific detectors in addition to the
generic purpose of this repository. it could be used to implement specific detectors 
in your terraform stack following our best practices.

### Limit

Templates and configuration model are opiniated. They follow the guideline, 
implementation and choices done for this repository:

* not generic or usable outside the context of this project.
* aims to support the basic and usual "kinds" of detectors (threshold, heartbeat..).
* for less common implementation it will require additional manual updates.

This is an helper, it should not be fully trusted and could be not up to date:

* focus on monitoring, generate code, push it, if CI pass so deploy detector and test it 
with real data. It could have errors from your config or the templates, tests remain crucial.
* it does not aim to replace terraform "templating". we still ideally want to create a 
common submodule used by every detectors modules (see [this 
issue](https://github.com/claranet/terraform-signalfx-detectors/issues/105).
* it is complementary waiting to implement this issue or to update existing base to use it
when it will be available. It still could be useful to decorrelate some policies from the
"deliverable" and compensate for terraform lacks like [this 
feature](https://github.com/hashicorp/terraform/issues/19898).

### Requirements

* Jinja2 compatible renderer. Next sections will use 
[j2cli](https://github.com/kolypto/j2cli#installation) with yaml deps enabled.

### Structure

At the root of this directory there are:

* [values.yaml](./values.yaml) with all configuration options available.
Copy it to create your own preset config.
* jinja templates files `*.j2` like [the detector resource](./detector.tf.j2).
* Sub-directories containing preset configs to generate common detectors on this repo.

The templates files are splitted into different files depending on the destination
where to append code:

* `variables.tf` file from [./variables.tf.j2](./variables.tf.j2).
* `detectors-{mymodule}.tf` file from [./detector.tf.j2](./detector.tf.j2).

### Usage

Use `j2cli` with template file and your config file created from [values.yaml](./values.yaml):

```bash
$ j2 ./scripts/templates/detector-{template}.tf.j2 {path_to_config_file.yaml}
```

You can redirect the output in the destination file on the repo:

```bash
$ j2 ./scripts/templates/variables.tf.j2 ./scripts/templates/example/nginx.yaml >> ./middleware/nginx/variables.tf
```

__Note__: you can duplicate another existing module and empty `variables.tf` and 
`detectors-{module}.tf` files if it does not exist yet.

### Examples

To create a new detector use each required templates:

```bash
$ j2 ./scripts/templates/detector_res.tf.j2 scripts/templates/threshold/simple.yaml
```

this will generate [detector terraform 
resource](https://registry.terraform.io/providers/splunk-terraform/signalfx/latest/docs/resources/detector):

```hcl
resource "signalfx_detector" "real_time_requests_latency" {
  name = format("%s %s", local.detector_name_prefix, "Database Real time requests latency")

  program_text = <<-EOF
    signal = data('read_latency_ns_p99', filter=${module.filter-tags.filter_custom})${var.real_time_requests_latency_transformation_function}
    detect(when(signal > ${var.real_time_requests_latency_threshold_critical})).publish('CRIT')
EOF

  rule {
    description           = "is too high > ${var.real_time_requests_latency_threshold_critical}"
    severity              = "Critical"
    detect_label          = "CRIT"
    disabled              = coalesce(var.real_time_requests_latency_disabled_critical, var.real_time_requests_latency_disabled, var.detectors_disabled)
    notifications         = coalescelist(lookup(var.real_time_requests_latency_notifications, "critical", []), var.notifications.critical)
    parameterized_subject = local.rule_subject
    parameterized_body    = local.rule_body
  }
}

```

and same to generate its corresponding variables:

```bash
j2 ./scripts/templates/detector_vars.tf.j2 scripts/templates/threshold/simple.yaml
```

with the output:

```hcl
# real_time_requests_latency detector

variable "real_time_requests_latency_notifications" {
  description = "Notification recipients list per severity overridden for real_time_requests_latency detector"
  type        = map(list(string))
  default     = {}
}

variable "real_time_requests_latency_transformation_function" {
  description = "Transformation function for real_time_requests_latency detector (i.e. \".mean(over='5m')\")"
  type        = string
  default     = ""
}

variable "real_time_requests_latency_disabled" {
  description = "Disable all alerting rules for real_time_requests_latency detector"
  type        = bool
  default     = null
}

variable "real_time_requests_latency_disabled_critical" {
  description = "Disable critical alerting rule for real_time_requests_latency detector"
  type        = bool
  default     = null
}

variable "real_time_requests_latency_threshold_critical" {
  description = "Critical threshold for real_time_requests_latency detector"
  type        = number
  default     = 1000
}

```
