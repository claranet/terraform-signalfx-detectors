#!/bin/bash
set -ue -o pipefail
if ! [ -v FILTER ]; then
    FILTER="*"
fi

if [ $# -eq 0 ]; then
    echo "Needs to provide a script to run for each module as parameter"
    exit 1
fi

if ! [ -f $1 ]; then
    echo "The provided script as parameter does not exist"
    exit 2
fi

MODULES=modules
SCRIPT=$1
shift

shopt -s nullglob
for module in ${MODULES}/${FILTER}/; do
    if ! [ -d "${module}" ]; then
        continue
    fi
    if [[ $(basename ${module}) == internal_* ]]; then
        continue
    fi
    $SCRIPT ${module%"/"} $@
done
