# Setup environment

To work with this repository, especially for developers, you will have to setup
an environment based on [docker](https://www.docker.com/) to make available all
dependencies and tools to perform usual automation to generate or update files in
the repository.

The environment uses the same [docker
image](https://hub.docker.com/r/claranet/terraform-ci) as the CI. You still can install
all dependencies listed in the
[Dockerfile](https://github.com/claranet/dockerfiles/tree/master/terraform) directly on
your host but it should be easier and less platform dependent with `docker`.

<!-- START doctoc generated TOC please keep comment here to allow auto update -->
<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->
:link: **Contents**

- [Requirements](#requirements)
  - [Windows](#windows)
  - [MacOS](#macos)
- [Usage](#usage)
- [Commands](#commands)

<!-- END doctoc generated TOC please keep comment here to allow auto update -->

## Requirements

* [Docker](https://docs.docker.com/engine/install/) `17.06+` to run dev environment
* `make` gnu command to use Makefile

### Windows

For Windows users, you must install:

* [WSL2](https://docs.microsoft.com/en-us/windows/wsl/install-win10)
* [Docker Desktop for Windows](https://docs.docker.com/docker-for-windows/install/)
* [Docker Desktop WSL 2 backend](https://docs.docker.com/docker-for-windows/wsl/)

WSL2 will bring an unix environment including `make` but its backend requires
[Docker Desktop Community
v2.5.0+](https://docs.docker.com/docker-for-windows/release-notes/#docker-desktop-community-2500).

### MacOS

For macOS and users, you must install:

* Run `xcode-select --install` if `make` is not available
* [Docker Desktop for Mac](https://docs.docker.com/docker-for-mac/install/)

## Usage

Just have to run `make` (equals `make dev`). Before to run the environment,
be sure `Docker` is running (i.e. `systemctl start docker.service` on linux).

```bash
$ make
docker exec -ti terraform-signalfx-detectors bash -i || \
        docker run --rm -ti -v "${PWD}:/work" \
                --name terraform-signalfx-detectors \
                claranet/terraform-ci:latest bash -i
Error: No such container: terraform-signalfx-detectors
[root@xxx work]# make
check      clean      detectors  dev        doc        gen        lint       module     outputs    readmes    stack      toc
```

Now you can run every scripts directly or from `make` targets and enjoying automation.

You also can run "one shot" command directly using the docker image yourself to use a dependency
not available on your host like `j2`:
```bash
$ docker run --rm -ti -v "${PWD}:/work" claranet/terraform-ci:latest make clean
git checkout -- examples/stack/detectors.tf
git clean -df modules/
```

CI and [Makefile](../Makefile) uses the `latest` tag which is not a good practice but
avoid to update all references in case of "transparent" update (i.e. only update
terraform to a newer minor version). The drawback is you could have to manually
pull the latest image if your local one is too old:
```bash
$ docker pull docker pull claranet/terraform-ci
```

The best will be to use `--pull=always` policy directly in `docker run` command but
this option is only available since docker version `>= 19.09` so we will wait before
to use it in the `Makefile` but you can still use for "one shot" usage:
```bash
$ docker run --pull=always --rm -ti -v "${PWD}:/work" claranet/terraform-ci:latest make clean
```

## Commands

The [Makefile](../Makefile) provides multiple targets. They are used by the CI for validation
checks, by the user to help to deploy detectors and by the developer to contribute automating
common tasks.

|Command|Description|
|---|---|
|__`clean`__|to clean directory and git diff related to `/modules` and `examples/stack`|
|__`dev`__|the default and optional target, it requires docker to run container ready for other commands|
|__`init-module`__|bootstrap a new, fresh and empty module where to create detectors|
|__`init-stack`__|bootstrap stack ready to use with all modules imported|
|__`update-module`__|to fully update modules and their dependencies|
|`check-deadlinks`|to run dead links check in all markdown files|
|`check-module`|to check and lint module(s)|
|`check-spell`|to run spell check on global markdown files|
|`update-module-detectors`|to update detectors (resources + variables) terraform files only|
|`update-module-doc`|to fully update documentation files only (README.md)|
|`update-module-outputs`|to update outputs terraform files only|
|`update-module-readme`|to update documentation files only (`README.md`) excluding global changes like TOC|
|`update-module-tf`|to update all terraform files (resources, variables and outputs|
|`update-severity-doc`|to fully update the global [severity documentation](./severity.md)|
|`update-severity`|to update the global [severity documentation](./severity.md) without global changes like TOC|
|`update-toc`|to update Table Of Contents for all markdown files|

Most of the them can accept an argument:

- `init-module`: the required directory name of the new, fresh, empty module to bootstrap
- `update-module-*` and `check-module`: the optional filter to target changes on a subset of module(s)

