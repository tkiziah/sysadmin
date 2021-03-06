#!/bin/bash

pushd $(dirname $0) > /dev/null

cd $(pwd -P)/..

doc_count=0
missing_count=0

function check_index {
    line=$(grep "$1" ./doc/mkdocs/mkdocs.yml | grep -v "#")

    if [ -f "$1" ] && [ -z "$line" ]; then
        [[ 0 -eq $missing_count ]] && echo "Docs missing from the mkdocs.yml index:"
        ((missing_count+=1))
        echo "$missing_count: '$1'"
    fi
}

docs=$(find {scripts,doc} \( -path 'doc/mkdocs' -o -path 'applications/*/doc/ref' \) -prune -o -type f -regex ".+\.md$")
for doc in $docs; do
    ((doc_count+=1))
    check_index $doc
done

# if [[ $missing ]]; then
    ratio=$((100 * $missing_count / $doc_count))
    echo "Missing $missing_count / $doc_count: $ratio%"
# fi

popd > /dev/null
