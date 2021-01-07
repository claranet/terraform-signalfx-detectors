SUPPORTED_COMMANDS := module modules doc gen detectors outputs
SUPPORTS_MAKE_ARGS := $(findstring $(firstword $(MAKECMDGOALS)), $(SUPPORTED_COMMANDS))
ifneq "$(SUPPORTS_MAKE_ARGS)" ""
  COMMAND_ARGS := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
  $(eval $(COMMAND_ARGS):;@:)
endif

COMMIT := $(shell git rev-parse HEAD)
TAG := $(shell git describe --tags --abbrev=0)

ifdef CI
	REV := $(COMMIT)
else
	REV := $(TAG)
endif

ifeq ($(COMMAND_ARGS),)
	export FILTER := *
else
	export FILTER := $(COMMAND_ARGS)
endif

.PHONY: dev
dev:
	docker exec -ti terraform-signalfx-detectors bash -i || \
		docker run --rm -ti -v "$(CURDIR):/work" \
			--name terraform-signalfx-detectors \
			claranet/terraform-ci:latest bash -i

.PHONY: clean
clean:
	git checkout -- examples/stack/detectors.tf
	git clean -df modules/

.PHONY: modules
modules: gen doc

.PHONY: doc
doc: 
	CI=true	./scripts/module/loop_wrapper.sh ./scripts/module/gen_doc.sh

.PHONY: toc
toc: 
	doctoc --github --title ':link: **Contents**' --maxlevel 3 .

.PHONY: check
check: lint

.PHONY: lint
lint: 
	./scripts/module/loop_wrapper.sh ./scripts/module/lint.sh

.PHONY: gen
gen: detectors outputs

.PHONY: outputs
outputs: 
	./scripts/module/loop_wrapper.sh ./scripts/module/gen_outputs.sh

.PHONY: detectors
detectors: 
	./scripts/module/loop_wrapper.sh ./scripts/module/gen_detectors.sh
	
.PHONY: stack
stack: 
	@echo 'Bootstrap stack in "examples/stack"'
	./scripts/stack/bootstrap.sh
	./scripts/module/loop_wrapper.sh ./scripts/stack/gen_module.sh "$(REV)" > examples/stack/detectors.tf

.PHONY: module
module: 
	./scripts/module/bootstrap.sh $(COMMAND_ARGS)
