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

VARS_FILE="variables.tf"
GLOBIGNORE="$VARS_FILE"
CODE=0

for i in $(find ${TARGET} -type f -not -path ".terraform/*" -not -path "test/*" -name "$VARS_FILE"); do
    dir=$(dirname $i)
    cd $dir
    first=true
    for var in $(pcregrep -o1 'variable "(.*)" {' $VARS_FILE); do
        if ! grep -q $var *.tf ; then
            if $first; then
                echo "* $dir ->"
                first=false
            fi
            echo -e "\t- $var"
            ((CODE++))
        fi
    done
    cd - > /dev/null
done

unset GLOBIGNORE
exit $CODE
