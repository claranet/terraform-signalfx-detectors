#!/bin/bash
set -ue -o pipefail

TARGET="${1:-}"
MODULE=${TARGET#"modules/"}
CI="${CI:-false}"

if ! [ -f ${TARGET}/conf/readme.yaml ]; then
    exit
fi
set -a
source_type=$(echo ${MODULE} | cut -d'_' -f 1)
if [[ ${source_type} == "integration" ]]; then
    source_type=$(echo ${MODULE} | cut -d'-' -f 1)
fi
module=$(echo ${MODULE} | cut -d'_' -f 2)
tf="$(./scripts/stack/gen_module.sh ${TARGET})"
detectors=""
if compgen -G "${TARGET}/detectors-*.tf" > /dev/null; then 
    detectors="$(sed -n 's/^.*name.*=.*detector_name_prefix.*"\(.*\)")$/* \1/p' ${TARGET}/detectors-*.tf | sort -fdbiu)"
fi
vars=
if [ -f ${TARGET}/variables.tf ]; then
    vars="${vars},variables.tf"
fi
if [ -f ${TARGET}/variables-gen.tf ]; then
    vars="${vars},variables-gen.tf"
fi
vars="${vars:1}"
set +a
echo "Generate module readme \"${TARGET}/README.md\" from \"${TARGET}/conf/readme.yaml\""
j2 --import-env= ./scripts/templates/readme.md.j2 ${TARGET}/conf/readme.yaml > ${TARGET}/README.md
if [ $CI == "true" ]; then 
    doctoc --github --title ':link: **Contents**' --maxlevel 3 ${TARGET}/README.md
fi

