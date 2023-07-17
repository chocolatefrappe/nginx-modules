#!/usr/bin/env bash

README_FILE=README.md
TEMPLATE_FILE=README.template.md

md_modules="\n"
versions=(`jq -cr '. | join(" ")' ./nginx-modules.json`)
for ver in "${versions[@]}"; do
    md_modules+="\n- \`$ver\`"
done

echo "Generating $README_FILE from $TEMPLATE_FILE..."
sed  "s,<!--modules-->,$md_modules," $TEMPLATE_FILE > $README_FILE
