## Scripts

This repository contains multiple scripts to automate some tasks performed by the CI, 
the developer or even the user.

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
:link: **Contents**

- [Module](#module)
- [Stack](#stack)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

All scripts are split into different directories. The [/Makefile](../Makefile) 
and the CI both use these scripts to automate automation over changes depending 
on its type.

### Module

The scripts in [/scripts/module](../scripts/module) are related to automation on 
detectors modules in the repository and so often used for development purpose. 

One special script is the 
[loop_wrapper.sh](../scripts/module/loop_wrapper.sh) script used in combination with 
another "atomic" script to apply it on all modules (often used for `make` commands).

### Stack

The scripts in [/scripts/stack](../scripts/stack) are related to automation on 
terraform stacks to use this repository for its project. They allow generate code 
in [/examples/](../examples) directory. 

They are often used by the end user to work with this repository and generate a pre 
configured stack. The `make stack` command for example used in the CI to deploy 
all monitors allow to generate a fresh stack with all modules configured in 
[/examples/stack](../examples/stack).it.

