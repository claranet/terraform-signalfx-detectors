SUPPORTED_COMMANDS := init-module update-module update-module-doc update-module-readme update-module-tf update-module-detectors update-module-outputs check-module init-stack init-stack-modules
SUPPORTS_MAKE_ARGS := $(findstring $(firstword $(MAKECMDGOALS)), $(SUPPORTED_COMMANDS))
ifneq "$(SUPPORTS_MAKE_ARGS)" ""
  COMMAND_ARGS := $(wordlist 2,$(words $(MAKECMDGOALS)),$(MAKECMDGOALS))
  $(eval $(COMMAND_ARGS):;@:)
endif

COMMIT := $(shell git rev-list --no-merges -n 1 HEAD)
BRANCH := $(shell git branch --show-current)
LAST_TAG := $(shell git describe --tags --abbrev=0)
LAST_TAG_COMMIT := $(shell git rev-list -n 1 $(LAST_TAG))

REV := $(COMMIT)
ifndef CI
	ifeq ($(COMMIT), $(LAST_TAG_COMMIT))
		REV := $(LAST_TAG)
	else ifneq ($(BRANCH),)
		REV := $(BRANCH)
	endif
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

.PHONY: update-module
update-module: update-module-tf check-module update-module-readme update-severity-doc

.PHONY: update-module-doc
update-module-doc: update-module-readme update-toc

.PHONY: update-module-readme
update-module-readme: 
	./scripts/module/loop_wrapper.sh ./scripts/module/gen_doc.sh

sev_dst = docs/severity.md
.PHONY: update-severity
update-severity:
	@echo -e "# Severity per detector\n" > $(sev_dst)
	@echo "<!-- START doctoc generated TOC please keep comment here to allow auto update -->" >> ${sev_dst}
	@echo "<!-- DON'T EDIT THIS SECTION, INSTEAD RE-RUN doctoc TO UPDATE -->" >> ${sev_dst}
	@echo -e "<!-- END doctoc generated TOC please keep comment here to allow auto update -->\n" >> ${sev_dst}
	FILTER=* SEV_GLOBAL=true ./scripts/module/loop_wrapper.sh ./scripts/module/gen_severity.sh >> ${sev_dst}

.PHONY: update-severity-doc
update-severity-doc: update-severity update-toc

.PHONY: update-toc
update-toc: 
	doctoc --github --title ':link: **Contents**' --maxlevel 3 .

.PHONY: check-module
check-module:
	./scripts/module/loop_wrapper.sh ./scripts/module/lint.sh

.PHONY: check-spell
check-spell:
	pyspelling -c .spellcheck.yaml

.PHONY: check-deadlinks
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
init-stack: init-stack-common init-stack-modules

.PHONY: init-stack-common
init-stack-common: 
	@echo 'Bootstrap stack in "examples/stack"'
	./scripts/stack/bootstrap.sh
	> examples/stack/detectors.tf

.PHONY: init-stack-modules
init-stack-modules: 
	./scripts/module/loop_wrapper.sh ./scripts/stack/gen_module.sh "$(REV)" >> examples/stack/detectors.tf

.PHONY: init-module
init-module: 
	./scripts/module/bootstrap.sh $(COMMAND_ARGS)
