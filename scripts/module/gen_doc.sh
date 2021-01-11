#!/bin/bash
set -ue -o pipefail

TARGET="${1:-}"
MODULE=${TARGET#"modules/"}
# this variable could be set either by Makefile or Github Actions

# Cancel if not readme configuration found for this module
if ! [ -f ${TARGET}/conf/readme.yaml ]; then
    exit
fi

# export all following assignation to be usable with `j2 --import-env=`
set -a
# the source type corresponds to the first part of the directory name
source_type=$(echo ${MODULE} | cut -d'_' -f 1)
if [[ ${source_type} == "integration" ]]; then
    source_type=$(echo ${MODULE} | cut -d'-' -f 1)
fi
# the module is the second part of the directory name
module=$(echo ${MODULE} | cut -d'_' -f 2)
# use the existing stack script to generate a HCL import sample config
tf="$(./scripts/stack/gen_module.sh ${TARGET})"
detectors=""
metrics=""
# if there is at least one detector in the module (avoid error on new fresh module)
if compgen -G "${TARGET}/detectors-*.tf" > /dev/null; then 
    # generate markdown matrix with severity per detector
    detectors="$(./scripts/module/gen_severity.sh ${TARGET})"
    # list all metrics used in `data()` signalflow function (grep "data()", sed pick only metric name, sort then replace newline by comma)
    metrics=$(grep "data('" ${TARGET}/detectors-*.tf | sed -E "s/^.*data\('([^']*).*$/\1/g" | sort -fdbiu | uniq | sed ':a;N;$!ba;s/\n/,/g')
fi
vars=
# variables could be declared either in handmade file, autogen file or both
if [ -f ${TARGET}/variables.tf ]; then
    vars="${vars},variables.tf"
fi
if [ -f ${TARGET}/variables-gen.tf ]; then
    vars="${vars},variables-gen.tf"
fi
vars="${vars:1}"
# stop exporting of declaration
set +a
echo "Generate module readme \"${TARGET}/README.md\" from \"${TARGET}/conf/readme.yaml\""
# Run j2 using yaml config but overrides with env var
j2 --import-env= ./scripts/templates/readme.md.j2 ${TARGET}/conf/readme.yaml > ${TARGET}/README.md

