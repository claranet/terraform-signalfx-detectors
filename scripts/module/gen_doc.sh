#!/bin/bash
set -ue -o pipefail

if ! [ -v CI_DOCTOC ]; then
    CI_DOCTOC=0
fi

case $# in
    0)
        TARGET="*"
        ;;
    1)
        TARGET=${1#"./"}
        ;;
    *)
        shift
        TARGET=$(echo "${@#"./"}" | sed 's/[[:space:]]*\.\// /g')
        ;;
esac

for i in $(find ${TARGET} -type f -not -path ".terraform/*" -name "detectors-*.tf"); do
    dir=$(dirname $i)
    echo $dir
    if ! [ -f ${dir}/conf/readme.yaml ]; then
        continue
    fi
    # @TODO delete when all modules will follow naming convention in modules/
    module=${dir##*/}
    source_type="smart-agent"
    if [[ $dir == *"/"* ]]; then
        if [[ $dir == "cloud/"* ]] || [[ $dir == "saas/"* ]]; then
            source_type="integration"
            module=$(basename $dir)
            if [[ $dir == "cloud/aws/"* ]]; then
                source_type="${source_type}-aws"
            elif [[ $dir == "cloud/azure/"* ]]; then
                source_type="${source_type}-azure"
            elif [[ $dir == "cloud/gcp/"* ]]; then
                source_type="${source_type}-gcp"
            elif [[ $dir == "saas/new-relic"* ]]; then
                source_type="${source_type}-newrelic"
            fi
        elif [[ $dir == "organization/"* ]]; then
            source_type="internal"
        fi
    else 
        echo @TODO
    fi
    export source_type="$source_type"
    export module="$module"
    export tf="$(./scripts/stack/gen_module.sh {revision} ${dir})"
    export detectors="$(sed -n 's/^.*name.*=.*detector_name_prefix.*"\(.*\)")$/* \1/p' ${dir}/detectors-*.tf)"
    j2 --import-env= ./scripts/templates/readme.md.j2 ${dir}/conf/readme.yaml > ${dir}/README.md
    if [ $CI_DOCTOC -eq 1 ]; then 
        doctoc --github --title ':link: **Contents**' --maxlevel 3 ${dir}/README.md
    fi
done

