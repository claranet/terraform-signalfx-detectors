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
- [Scripts](#scripts)
- [Change types](#change-types)
  - [TLDR](#tldr)
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

## Scripts

Now you have a ready dev env you can run `make` commands or directly use the underlying 
[scripts](./scripts.md) or even some tools available in the container like `doctoc` or `j2`.

Here are useful `make` commands for development purpose:

- `dev`: the default and optional target run the container ready to run other commands
- `clean` to clean directory and git diff related to `/modules`
- `doc`: generate modules readmes
- `detectors`: generate variables and resources terraform code for detectors
- `outputs`: generate outputs terraform code for detectors
- `module`: bootstrap a new, fresh, empty module directory where add detectors
- `lint`: run `tflint` command

Some alias exist to run multiple commands in once:

- `gen`: `detectors` && `output`
- `modules`: `gen` && `doc`
- `check`: `lint` (for now)

Most of the them can accept an argument:

- `module`: the name of the new, fresh, empty module directory to bootstrap.
- `modules`, `doc`, `gen`, `detectors`, `outputs`: the filter to target changes on a subset of module(s).

For example you can run `make modules *system*` to update doc, detectors and outputs for all modules 
matching `*system*` wildcard filter like `smart-agent_system-common`.

## Change types

There are different automation tasks to perform depending on the change done in this repository.

### TLDR

Documentation below will guide you to understand what command to run depending on your change to 
pass the related CI checks. If you prefer, you can run the `make modules` command which should 
cover any common contribution types.

### Documentation

__Label__: 
[documentation](https://github.com/claranet/terraform-signalfx-detectors/labels/documentation)

__Check__: 
[Documentation](#documentation-1)

* Table of contents of all readmes are automatically committed from the CI but you can run 
`make toc`. It uses [doctoc](https://github.com/thlorenz/doctoc) under the hood so you can 
also run `doctoc --github --title ':link: **Contents**' --maxlevel 3` on a specific module.

* To update readme(s) of detectors modules you have to edit its underlying configuration 
available in `conf/readme.yaml` of the module directory. Then you must run `make doc` 
to regenerate readmes. It uses the module [gen_doc.sh](../scripts/module/gen_doc.sh) script 
under the hood so you also use it to update only one module provided as parameter.

### Detectors

__Label__: 
[detectors](https://github.com/claranet/terraform-signalfx-detectors/labels/detectors)

__Check__: 
[Detectors](#detectors-1)

* To update an existing detector located in a `detectors-gen.tf` file so you have, as for readme, 
edit the right configuration file located `conf/[0-9][0-9]-*.yaml` in its module directory.
Then you will have to run `make detectors` to regenerate the code. It uses the module 
[gen_detectors.sh](../scripts/module/gen_detectors.sh) under the hood so you can 
also use it to update only one module provided as parameter.

* To update an existing detector not located in a `detectors-gen.tf` file so you can directly 
edit the terraform code in its tf file.

* To add a new detector to an existing module you can use the [j2 based 
generator](../scripts/templates/README.md) adding a new yaml configuration file in the module directory 
`conf/` with the prefix `[0-9][0-9]-` like `conf/00-my_first_detector.yaml` then run `make detectors`.

* In some cases you do not want use the generator or it does not provide all capabilities you need.
So you can implement it manually in another file than `detectors-gen.tf` reusing and improving 
the code generated by the generator. You can also create it from scratch but you must follow our 
[templating](https://github.com/claranet/terraform-signalfx-detectors/wiki/Templating) model (you 
can follow an existing detector).

* To remove an existing detector, first think if lower severity, changing thresholds or functions 
could not improve it enough. If it is still not relevant or generate too many alerts in some 
scenarios but remain useful in others may be disabling it by default is a good idea. Finally, if 
the detector simply does not make sens so you can remove it. If it is located in `detectors-gen.tf` 
file so simply `git rm conf/42-the_detector.yaml` and run `make detectors`. Else, you have to 
manually remove the resource code in `detectors-?.tf` file and all its related variables in 
`variables.tf`.

* To add a new module you should use `make module source_module` where `source` is one of known 
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
an example stack and importing all modules. It consists of `make stack && terraform apply examples/stack`.

* __compliance__: check and lint the terraform code. It consists of `make check` For example, 
`make lint` (one of `check` sub target) uses [tflint](https://github.com/terraform-linters/tflint/) 
tool to check common terraform errors that `validate` does not find like [unused 
declarations](https://github.com/terraform-linters/tflint/blob/master/docs/rules/terraform_unused_declarations.md).

* __outputs__: regenerates the detectors terraform outputs listing all resources in the modules 
to ensure outputs are up to date. It consists of `make outputs`.

* __gen__: regenerates the detectors terraform resources and variables from their preset yaml 
configuration using the jinja based generator to ensure the configuration and code are "sync". It 
consists of `make detectors`.

### Documentation

The [Documentation](../.github/workflows/doc.yml) workflow is dedicated to update table of contents 
and check that generated documentation. It contains different jobs:

* __toc__: runs [DocToc](https://github.com/thlorenz/doctoc) to generate table of contents on 
all readmes in the repository. It consists of `make toc` but this job automatically push commits 
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

* create a new "fake" module using `make module` in [/modules](../modules) directory.
* generate detectors resources and variables thanks to the generator using all available 
example configurations from [/scripts/templates/examples](../scripts/templates/examples) 
directory.
* import the "fake" module into the ready example stack 
[detectors.tf](../examples/stack/detectors.tf) next to the existing static import.
* deploy the [/examples/stack](../examples/stack) to validate full process of creating a 
new module and generating detectors.

