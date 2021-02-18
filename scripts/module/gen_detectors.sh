#!/bin/bash
set -ue -o pipefail

TARGET="${1:-}"
MODULE=${TARGET#"modules/"}

if ! compgen -G ${TARGET}/conf/[0-9][0-9]-*.yaml > /dev/null; then
    exit
fi
echo "Generate module detectors to \"${TARGET}/*-gen.tf\""
for dst in variables detectors; do
    > ${TARGET}/${dst}-gen.tf
done
for detector in ${TARGET}/conf/[0-9][0-9]-*.yaml; do
    for dst in variables detectors; do
        j2 ./scripts/templates/$(echo ${dst} | sed 's/detectors/detector/').tf.j2 ${detector} >> ${TARGET}/${dst}-gen.tf
        terraform fmt ${TARGET}/${dst}-gen.tf
    done
done
