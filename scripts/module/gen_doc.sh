#!/bin/bash
set -ue -o pipefail

TARGET="${1:-}"
MODULE=${TARGET#"modules/"}
CI_DOCTOC="${CI_DOCTOC:-0}"

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
detectors="$(sed -n 's/^.*name.*=.*detector_name_prefix.*"\(.*\)")$/* \1/p' ${TARGET}/detectors-*.tf)"
set +a
j2 --import-env= ./scripts/templates/readme.md.j2 ${TARGET}/conf/readme.yaml > ${TARGET}/README.md
if [ $CI_DOCTOC -eq 1 ]; then 
    doctoc --github --title ':link: **Contents**' --maxlevel 3 ${TARGET}/README.md
fi

