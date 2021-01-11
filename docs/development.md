# Developer's Guide

In most cases you will have to run scripts to automatically update existing files in this 
repository after a change to apply all these dependencies and pass the CI.

For example, to update the readme of one detectors module you will have to:
* edit its corresponding yaml configuration file
* generate the markdown readme file from the jinja template

The CI will always try to regenerate code from current configurations so if one of them 
is no longer "sync" it will trigger an error.

The environment used by the CI should be used by the developer to take advantage of a common 
automation processes producing the same consistent result and allow us to apply global 
rules and templates homogeneous to all modules.

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
:link: **Contents**

- [Requirements](#requirements)
- [TLDR](#tldr)
  - [Bootstrap a new module](#bootstrap-a-new-module)
- [Commands](#commands)
  - [Examples](#examples)
- [Change types](#change-types)
  - [Documentation](#documentation)
  - [Detectors](#detectors)
  - [Templating](#templating)
- [Checks](#checks)
  - [Detectors](#detectors-1)
  - [Documentation](#documentation-1)
  - [Generator](#generator)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## Requirements

First of all you have to [setup your environment](./environment.md) to have every required 
dependencies available to run useful commands detailed below.

You should get a ready environment where you can run `make` commands or directly use the underlying 
[scripts](./scripts.md) or even some tools available in the container like `doctoc` or `j2`.

## TLDR

This documentation tries to be exhaustive and describe each:

* atomic `make` targets (which use helper scripts to automate)
* check done by the CI which should be success
* common type of change possible on this repository

It allows to understand and link what type of change requires what `make` target to pass 
the corresponding CI check.

Most of contributions are related to [detectors change type](#detectors) and do no require 
to fully understand and know all possible targets, scripts and check.

The essential things to know are:

* that lot of the files are auto generated and checked by the CI so you have to respect this
* to never edit a `*-gen*` file or the `README.md` in modules, update its underlying yaml 
configuration files in `conf/` directory of the module.
* as soon as you make any change on a module, run `make update-module` command to update every 
generated files

### Bootstrap a new module

A common contribution which cover most of detectors related changes is the creation of a 
new module of detectors.

```bash
$ echo "Set required input information as environment variables"
$
$ SOURCE_TYPE="smart-agent" # or "internal", "integration", "organization", "otel-collector"
$ MODULE_NAME="my-new-module" # use dash separated word to name your module
$ MODULE_DIR="${SOURCE_TYPE}_${MODULE_NAME}" # the directory is source+name underscore separated
$ METRIC_NAME="my_metric_used_for_heartbeat_detector"
$
$ echo "Init a new module creating ready directory to welcome detectors"
$ make init-module ${MODULE_DIR} # same as "make init-module ${SOURCE_TYPE} ${MODULE_NAME}"
$
$ echo "Create a new detector using the heartbeat sample configuration and updating module and metric"
$ cp scripts/templates/examples/heartbeat-simple.yaml modules/${MODULE_DIR}/conf/00-heartbeat.yaml
$ sed -i "s/^\(module:\).*$/\1 ${MODULE_NAME}/" modules/${MODULE_DIR}/conf/00-heartbeat.yaml
$ sed -i "s/^\([[:space:]]*metric:\).*$/\1 \"${METRIC_NAME}\"/" modules/${MODULE_DIR}/conf/00-heartbeat.yaml
$ 
$ echo "Full update the module (doc, terraform code, add/remove/change detectors...)"
$ make update-module ${MODULE_DIR}
```

That is all! and from now you will have to run `make update-module` before to push any change, it 
will take care of regenerating code, documentation and even check and validate the module to pass the CI.

If this is not enough for your change or if you want to fully understand all capabilities and dependencies 
you will have to read the rest of this documentation.

## Commands

You have seen above the `update-module` and `init-module` `make` targets which should be enough 
in most of the cases.

For a full list of available `make` targets please see [environment](./environment.md#Commands) 
documentation. The most used commands for developer are `dev`, `init-module`, `update-module` and 
`clean`.

### Examples

- `make update-module *system*` to full update only matching modules like `smart-agent_system-common`
- `make update-module` to full update all modules
- `make update-module-doc *system*` to only update the doc of the modules matching `*system*` pattern

## Change types

There are different automation tasks to perform depending on the change done in this repository.

### Documentation

__Label__: 
[documentation](https://github.com/claranet/terraform-signalfx-detectors/labels/documentation)

__Check__: 
[Documentation](#documentation-1)

* Table of contents of all readmes are automatically committed from the CI but you can run 
`make update-toc`. It uses [doctoc](https://github.com/thlorenz/doctoc) under the hood so you can 
also run `doctoc --github --title ':link: **Contents**' --maxlevel 3` on a specific module.

* To update readme(s) of detectors modules you have to edit its underlying configuration 
available in `conf/readme.yaml` of the module directory. Then you must run `make update-module-doc` 
to regenerate readmes. It uses the module [gen_doc.sh](../scripts/module/gen_doc.sh) script 
under the hood so you also use it to update only one module provided as parameter.

### Detectors

__Label__: 
[detectors](https://github.com/claranet/terraform-signalfx-detectors/labels/detectors)

__Check__: 
[Detectors](#detectors-1)

* To update an existing detector located in a `detectors-gen.tf` file so you have, as for readme, 
to edit the right configuration file located `conf/[0-9][0-9]-*.yaml` in its module directory.
Then you will have to run `make update-module-detectors` to regenerate the code. It uses the module 
[gen_detectors.sh](../scripts/module/gen_detectors.sh) under the hood so you can 
also use it to update only one module provided as parameter.

* To update an existing detector not located in a `detectors-gen.tf` file so you can directly 
edit the terraform code in its tf file.

* To add a new detector to an existing module you can use the [j2 based 
generator](../scripts/templates/README.md) adding a new yaml configuration file in the module directory 
`conf/` with the prefix `[0-9][0-9]-` like `conf/00-my_first_detector.yaml` then run `make update-module` 
because this change should affect all tf files (outputs included) and the module documentation.

* In some cases you do not want use the generator or it does not provide all capabilities you need.
So you can implement it manually in another file than `detectors-gen.tf` reusing and improving 
the code generated by the generator. You can also create it from scratch but you must follow our 
[templating](https://github.com/claranet/terraform-signalfx-detectors/wiki/Templating) model (you 
can follow an existing detector). In this case no need to update the tf code but you still need to 
update the documentation of the module `make update-module-doc`.

* To remove an existing detector, first think if lower severity, changing thresholds or functions 
could not improve it enough. If it is still not relevant or generate too many alerts in some 
scenarios but remain useful in others may be disabling it by default is a good idea. Finally, if 
the detector simply does not make sens so you can remove it. If it is located in `detectors-gen.tf` 
file so simply `git rm conf/42-the_detector.yaml` and run `make update-module`. Else, you have to 
manually remove the resource code in `detectors-?.tf` file and all its related variables in 
`variables.tf`.

* To add a new module you should use `make init-module source_module` where `source` is one of known 
sources (`internal`, `organization`, `smart-agent`, `otel-collector`, `integration`) and `module` 
is the name of your module like `mysql` or `nginx`. It will create a new directory 
`[source]_[module]` in [/modules](../modules) directory. The you can add new detector (see above) inside.
For `integration` sources, we prefix its name in `module` like `aws-alb` or `gcp-cloud-sql` and 
it is often needed to remove the `common-modules.tf` to not use the default [filtering 
convention](https://github.com/claranet/terraform-signalfx-detectors/wiki/Tagging-convention) 
which is often not possible (i.e. `aws` integration prefix all dimensions with `aws_tag_` the `env` 
becomes `aws_tag_env`.

### Templating

__Label__: 
[templating](https://github.com/claranet/terraform-signalfx-detectors/labels/templating)

__Check__: 
[Generator](#generator)

If you evolution on our [templating](https://github.com/claranet/terraform-signalfx-detectors/wiki/Templating) 
model or the modules [structure](https://github.com/claranet/terraform-signalfx-detectors/wiki/Structure) 
you will have to update existing documentation in markdown files of this repository starting by 
this one but also any relevant [wiki](https://github.com/claranet/terraform-signalfx-detectors/wiki) pages.

You will also have to apply the evolution on the full existing code base so if you want to add a feature 
implemented everywhere.

Every single and tiny change in these templating rules must be spread to the entire repository on 
all modules and their detectors. This could be difficult to automate, source of mistakes and have 
undesired side effects.

If you want to implement a special feature for a specific module this is [detectors](#detectors) change 
type you can go ahead.

But for feature common to all modules you will also probably need to update the [j2 based 
generator](../scripts/templates/README.md) to 
support this new "rule".

Also in some cases it is recommended to add a new [checks](#checks) / job to the CI if relevant.

## Checks

The CI is broken down into 3 workflows. Each one run different jobs and all of them will 
failed for any error meet (i.e. change detected). All are required and must pass to merge.

### Detectors

The [Detectors](../.github/workflows/main.yml) workflow is dedicated to test terraform code related to 
detectors in modules. It contains different jobs:

* __deployment__: terraform `fmt`, `validate` and `apply all` detectors from all modules bootstrapping 
an example stack and importing all modules. It consists of `make init-stack && terraform apply examples/stack`.

* __compliance__: check and lint the terraform code. It consists of `make module-check` which use 
[tflint](https://github.com/terraform-linters/tflint/) tool to check common terraform errors that 
`validate` does not find like [unused 
declarations](https://github.com/terraform-linters/tflint/blob/master/docs/rules/terraform_unused_declarations.md).

* __outputs__: regenerates the detectors terraform outputs listing all resources in the modules 
to ensure outputs are up to date. It consists of `make update-module-outputs`.

* __gen__: regenerates the detectors terraform resources and variables from their preset yaml 
configuration using the jinja based generator to ensure the configuration and code are "sync". It 
consists of `make update-module-detectors`.

### Documentation

The [Documentation](../.github/workflows/doc.yml) workflow is dedicated to update table of contents 
and check that generated documentation. It contains different jobs:

* __toc__: runs [DocToc](https://github.com/thlorenz/doctoc) to generate table of contents on 
all readmes in the repository. It consists of `make update-toc` but this job automatically push commits 
over your changes to update toc so it is not required to run this command manually.

* __spellcheck__: runs [PySpelling](https://facelessuser.github.io/pyspelling/) to find any typos 
in markdown files.

* __dead-links__: uses [markdown-link-check](https://github.com/marketplace/actions/markdown-link-check) 
to find any broken links in markdown files.

### Generator

The [Generator](../.github/workflows/generator.yml) workflow is dedicated to test the j2 based 
detectors generator which help the developer to create new detectors. 

This generator is also used in the `gen` job of the `Detectors` workflow to regenerate 
all pre-configured detectors code.

There is only one job `test` which:

* create a new "fake" module using `make init-module` in [/modules](../modules) directory.
* generate detectors resources and variables thanks to the generator using all available 
example configurations from [/scripts/templates/examples](../scripts/templates/examples) 
directory.
* import the "fake" module into the ready example stack 
[detectors.tf](../examples/stack/detectors.tf) next to the existing static import.
* deploy the [/examples/stack](../examples/stack) to validate full process of creating a 
new module and generating detectors.
