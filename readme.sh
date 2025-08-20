#!/usr/bin/env bash

README_FILE=${README_FILE:-"README.md"}
TEMPLATE_FILE=${TEMPLATE_FILE:-"README.template.md"}
NGINX_VERSIONS_FILE=${NGINX_VERSIONS_FILE:-"nginx-versions.json"}

# Inject value into README.md
function readme() {
    local key=$1
    local value=$2
    
    if [[ "$OSTYPE" == "darwin"* ]]; then
        sed -i '' -e "s|<!--$key-->|$value|" $README_FILE
    else
        sed -i -e "s|<!--$key-->|$value|" $README_FILE
    fi
}

if [ ! -f "${NGINX_VERSIONS_FILE}" ]; then
    echo "The file nginx-versions.json does not exist."
    exit 1
fi

echo "Generating $README_FILE from $TEMPLATE_FILE..."

echo "- Removing old $README_FILE"
if [ -f "$README_FILE" ]; then 
    rm -f $README_FILE
fi
cp $TEMPLATE_FILE $README_FILE

echo "- Generate supported releases list..."
md_releases="\n"
releases=(`jq -cr '. | join(" ")' ${NGINX_VERSIONS_FILE}`)
for release in "${releases[@]}"; do
    md_releases+="\n- \`$release\`"
done
readme releases "$md_releases"

echo "- Generate modules list..."
md_modules="\n"
modules=(`jq -cr 'keys_unsorted | join(" ")' ./nginx-modules.json`)
for mod in "${modules[@]}"; do
    desc=$(jq -cr ".[\"${mod}\"].description" nginx-modules.json)
    homepage=$(jq -cr ".[\"${mod}\"].url" nginx-modules.json)

    md_modules+="\n- [\`$mod\`](${homepage}): ${desc}"
done
readme modules "$md_modules"

echo "- Generate tags list..."
md_tags="\n"

# mainline, stable
releases=(mainline stable)
for release in "${releases[@]}"; do
    for mod in "${modules[@]}"; do
        # [Note] Set alpine release inline
        md_tags+="\n- \`$release-$mod\`, \`$release-alpine-$mod\`"
    done
done

# Versioned
md_tags+="\n"
md_tags+="\n**Versioning releases**:"
md_tags+="\n"
releases=(`jq -cr '. | join(" ")' ${NGINX_VERSIONS_FILE}`)
for release in "${releases[@]}"; do
    for mod in "${modules[@]}"; do
        # [Note] Set alpine release inline
        md_tags+="\n- \`$release-$mod\`, \`$release-alpine-$mod\`"
    done
done
readme tags "$md_tags"
