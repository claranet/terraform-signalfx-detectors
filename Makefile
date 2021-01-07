SUPPORTED_COMMANDS := init-module update-module update-module-doc update-module-tf update-module-detectors update-module-outputs check-module
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
	git clean -df init-modules/

.PHONY: update-module
update-module: update-module-tf check-module update-module-doc

.PHONY: update-module-doc
update-module-doc: 
	CI=true	./scripts/module/loop_wrapper.sh ./scripts/module/gen_doc.sh

.PHONY: update-toc
update-toc: 
	doctoc --github --title ':link: **Contents**' --maxlevel 3 .

.PHONY: check-module
check-module:
	./scripts/module/loop_wrapper.sh ./scripts/module/lint.sh

.PHONY: check-spell
check-spell:
	pyspelling -c .spellcheck.yaml

.PHONY: check-spell
check-deadlinks:
	find . -name \*.md -exec markdown-link-check -c .mlc_config.json -p -q -v {} \;

.PHONY: update-module-tf
update-module-tf: update-module-detectors update-module-outputs

.PHONY: update-module-outputs
update-module-outputs: 
	./scripts/module/loop_wrapper.sh ./scripts/module/gen_outputs.sh

.PHONY: update-module-detectors
update-module-detectors: 
	./scripts/module/loop_wrapper.sh ./scripts/module/gen_detectors.sh
	
.PHONY: init-stack
init-stack: 
	@echo 'Bootstrap stack in "examples/stack"'
	./scripts/stack/bootstrap.sh
	./scripts/module/loop_wrapper.sh ./scripts/stack/gen_module.sh "$(REV)" > examples/stack/detectors.tf

.PHONY: init-module
init-module: 
	./scripts/module/bootstrap.sh $(COMMAND_ARGS)
