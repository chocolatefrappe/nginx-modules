#!/usr/bin/env bash

README_FILE=README.md
TEMPLATE_FILE=README.template.md

md_modules="\n"

modules=(`jq -cr '. | join(" ")' ./nginx-modules.json`)
for mod in "${modules[@]}"; do
    desc=$(jq -cr ".[\"${mod}\"].desc" nginx-modules-info.json)
    homepage=$(jq -cr ".[\"${mod}\"].homepage" nginx-modules-info.json)

    md_modules+="\n- [\`$mod\`](${homepage}): ${desc}"
done

echo "Generating $README_FILE from $TEMPLATE_FILE..."
sed  "s|<!--modules-->|$md_modules|" $TEMPLATE_FILE > $README_FILE
