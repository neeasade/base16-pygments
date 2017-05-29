#!/bin/sh

cd "$(dirname $([ -L $0  ] && readlink -f $0 || echo $0))"

. "./mustache.sh"


fill_templates() {
    IFS=$'\n'
    for template in "$(find templates -name "*.*")"; do
        target="./output/$(echo ${template#*/})"
        target="$(dirname $target)/${1}.$(basename "$target")"
        mkdir -p "$(dirname "$target")"
        mustache < "$template" > "$target"
    done
    IFS=
}

for scheme in $(find schemes -name "*.*"); do
    . "$scheme"
    fill_templates "$(basename "$scheme")"
done
