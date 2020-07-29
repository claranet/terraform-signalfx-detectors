#!/bin/bash
set -u

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

ERRORS=0

for i in $(find ${TARGET} -type f -not -path ".terraform/*" -not -path "test/*" -name "variables.tf"); do
    dir=$(dirname $i)
    cd $dir
    out=$(unbuffer tflint --disable-rule=terraform_module_pinned_source --enable-rule=terraform_unused_declarations 2>&1)
    if [[ $? -ne 0 ]]; then
        ((ERRORS++))
        echo -e "\e[1m* module: \e[4m$dir\e[24m\e[21m\n"
        echo -e "$out\n"
    fi
    cd - > /dev/null
done

exit $ERRORS
