# Terraform SignalFx Detectors
[![Maintainer](https://img.shields.io/badge/maintained%20by-claranet-red?style=flat-square)](https://www.claranet.fr/)
[![License](https://img.shields.io/github/license/claranet/terraform-signalfx-detectors?style=flat-square)](LICENSE)
[![Release](https://img.shields.io/github/v/release/claranet/terraform-signalfx-detectors?style=flat-square)](https://github.com/claranet/terraform-signalfx-detectors/releases)
[![Status](https://img.shields.io/github/workflow/status/claranet/terraform-signalfx-detectors/Detectors?style=flat-square&label=tests)](https://github.com/claranet/terraform-signalfx-detectors/actions?query=workflow%3ADetectors)
[![Terraform version](https://img.shields.io/badge/terraform-%3E%3D0.12.26-623CE4.svg?style=flat-square&logo=terraform)](https://github.com/hashicorp/terraform)
[![Terraform registry](https://img.shields.io/badge/terraform-registry-623CE4.svg?style=flat-square&logo=terraform)](https://registry.terraform.io/modules/claranet/detectors/signalfx)

> Many detectors alert could be common. Here is a place to "rule" them all! 🤘

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
:link: **Contents**

- [🥅 Goal](#-goal)
- [📦 Modules](#-modules)
- [🚀 Usage](#-usage)
- [🤝 Contributing](#-contributing)
- [🚧 Roadmap](#-roadmap)
- [🚨 Changelog](#-changelog)
- [📝 License](#-license)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## 🥅 Goal

This project aims to speed up alerting deployment and apply infrastructure as code 
process to your monitoring. It could also be a place to collect, share and improve 
alerting rules on popular services and environments through SignalFx and Terraform.

__Note__: These templates implementation is opinionated and enforce best practices 
which ensure homogeneity but it will also restrict the usage and capabilities even 
if it tries to provide as much flexibility as possible.

## 📦 Modules

This repository consists in a collection of generic pre-built detectors for SignalFx 
broken down into multiple terraform modules in [modules](./modules/README.md) directory.

Each module is fully independent and it is dedicated to monitor one service 
thanks to the metrics and information it provides. It contains:

- Terraform source code to be use as module
- Readme file containing instructions and specific notes to work with the module.
- Source, dependencies and sample configuration for metrics collection.

## 🚀 Usage

A module is a collection of [detectors 
resource](https://registry.terraform.io/providers/splunk-terraform/signalfx/latest/docs/resources/detector) 
with global and per-detector variables available to adapt the default alerting 
behavior to suit your requirements changing the underlying detectors configuration 
at deployment thanks to Terraform.

[Instructions in Wiki](https://github.com/claranet/terraform-signalfx-detectors/wiki).

## 🤝 Contributing

Contributions from the community are most welcome!

There are many ways to contribute: writing code, add or improve detectors, 
documentation, reporting issues, discussing better error tracking...

[Instructions in CONTRIBUTING.md](CONTRIBUTING.md).

## 🚧 Roadmap

You can go to [github 
milestones](https://github.com/claranet/terraform-signalfx-detectors/milestones) 
to know what is planned in future versions browsing [available 
issues](https://github.com/claranet/terraform-signalfx-detectors/issues).

## 🚨 Changelog

Read carefully release notes of each [github 
release](https://github.com/claranet/terraform-signalfx-detectors/releases) 
before upgrading to a new version.

## 📝 License

[Mozilla Public License](https://www.mozilla.org/en-US/MPL/)
