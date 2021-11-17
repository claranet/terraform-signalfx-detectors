# Templates

A list of [Jinja2](https://jinja.palletsprojects.com/)
based templates to render content in this repository.
Like the terraform code from [SignalFx
provider](https://github.com/splunk-terraform/terraform-provider-signalfx)
or the modules readmes.

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
:link: **Contents**

- [Requirements](#requirements)
- [Structure](#structure)
- [Generators](#generators)
- [Detector](#detector)
  - [Goal](#goal)
  - [Limits](#limits)
  - [Usage](#usage)
- [Readme](#readme)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## Requirements

Before being able to use the j2 based generator(s) you have to [setup your
environment](../../docs/environment.md).

Then, you can either run `make` to enter in the docker container and use all
available commands like `j2` or run the container as a "one shot" command like:
```bash
$ docker run --rm -ti -v "${PWD}:/work" claranet/terraform-ci:latest j2 scripts/templates/detector.tf.j2 scripts/templates/examples/heartbeat-simple.yaml
resource "signalfx_detector" "heartbeat" {
  name      = format("%s %s", local.detector_name_prefix, "Webcheck heartbeat")
  max_delay = 900

  program_text = <<-EOF
    from signalfx.detectors.not_reporting import not_reporting
    signal = data('webcheck_status_code', filter=${module.filtering.signalflow})${var.heartbeat_aggregation_function}.publish('signal')
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

You should be able to use those templates with any compatible Jinja2 renderer.
This environment and next sections of this documentation uses the
[j2cli](https://github.com/kolypto/j2cli#installation) with yaml dependency enabled.

```

## Structure

At the root of this directory there are:

* all available templates files `*.j2` like [the detector resource](./detector.tf.j2)
and [the variables declaration](./variables.tf.j2) templates to use with the [detector
generator](#detector) or the [readme template](./readme.md.j2) for
the [readme generator](#readme) used internally.

* [values.yaml](./values.yaml) with all configuration options available for the
[detector](#detector) generator. Copy it to create your own preset configuration.

* [examples](examples) directory containing fake preset configurations to test the
detector generator.

## Generators

A generator always consist in:

* a configuration file in `yaml` format
* a template file in `jinja2` format

In combination they allow to generate code thanks to a jinja renderer like `j2cli`.

There are different generators detailed in the next sections.

## Detector

### Goal

The first goal is to help and make it easier to contribute:

* it aims to reduce the effort to bootstrap detector taking care of redundant tasks.
* it could allows someone without terraform knowledge to add content.
* it will enforce homogeneity and best practices across every modules
which should improve reliability and understanding.

### Limits

This generator follows our [Templating
model](https://github.com/claranet/terraform-signalfx-detectors/wiki/Templating) are
which is opinionated and implement its common "rules" only.

* it is not useful outside the context of this repository
* it aims to only support the basic and usual "kinds" of detectors (threshold, heartbeat..)
* any specific implementation or advanced features must be manually added in tf file

This is an helper, it should not be fully trusted and could be not up to date so:

* it could allow to fully generate a detector followed by its yaml configuration like
[those of the system module](../../modules/smart-agent_system-common/conf) producing
detectors in the [detectors-gen.tf](../../modules/smart-agent_system-common/detectors-gen.tf)
file.
* it could be used as base to implement most advanced needs, not followed by a yaml
configuration file but helping developer to bootstrap a "skeleton" of code like for the
detectors in [detectors-system.tf](../../modules/smart-agent_system-common/detectors-system.tf)
file.

The code will be generated (only in first case) and detectors deployed to ensure it
"works" to give you the time to __test__ properly the detector itself.

### Usage

1. (Optional) Crete a new module if you do not work on an existing one.
`make module {source}_{module}` replacing `{source}` and `{module}` appropriately.
1. Create your new yaml configuration file following [values.yaml](./values.yaml)
You can take examples on existing ones like [those of the system
module](../../modules/smart-agent_system-common/conf)
1. Put in the module `conf` directory prefixed with `[0-9][0-9]-` numbering to
set the order code generated in the `detectors-gen.tf` file like
`modules/source_module/conf/00-heartbeat.yaml`.
1. Generate terraform code from this configuration file `make detectors`.
1. Git add, commit and push!

If you want to use it "manually" you can run the following command:

```bash
# generate the signalfx detector resource terraform code
$ j2 ./scripts/templates/detector.tf.j2 {yaml_file}
# generate the signalfx detector variables declaration terraform code
$ j2 ./scripts/templates/variables.tf.j2 {yaml_file}
```

If you do not need to split both (variables and resource codes) into different
destination you can generate both of them in one command:

```bash
j2 <(cat scripts/templates/variables.tf.j2 scripts/templates/detector.tf.j2) {yaml_file}
```

## Readme

The modules readmes are generated from their yaml configuration located inside
the module in `conf` directory.

This template is used internally and it does not aims to be run manually.
If you want to update modules readmes please use `make doc`.

