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

for i in $(find ${TARGET} -type f -not -path ".terraform/*" -not -path "stack/*" -name "variables.tf"); do
    dir=$(dirname $i)
    cd $dir
    # Ignore common locals for "terraform_unused_declarations"
    for tflocal in $(grep '^[[:space:]]*[a-z0-9_]*[[:space:]]*=' common-locals.tf | awk '{print $1}'); do
        cat <<-EOF >> tmp-outputs.tf
        output "${tflocal}" {
          value = local.${tflocal}
        }

EOF
    done
    out=$(unbuffer tflint --disable-rule=terraform_module_pinned_source --enable-rule=terraform_unused_declarations --loglevel=info 2>&1)
    if [[ $? -ne 0 ]]; then
        ((ERRORS++))
        echo -e "\e[1m* module: \e[4m$dir\e[24m\e[21m\n"
        echo -e "$out\n"
    fi
    rm tmp-outputs.tf
    cd - > /dev/null
    exit
done

if [[ $ERRORS -eq 0 ]]; then
    echo -e "$out\n"
    echo "Compliance check \"tflint\": OK"
else
    echo "Compliance check \"tflint\": $ERRORS modules with issues"
fi

exit $ERRORS
