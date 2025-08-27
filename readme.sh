#!/usr/bin/env bash

README_FILE=${README_FILE:-"README.md"}
TEMPLATE_FILE=${TEMPLATE_FILE:-"README.template.md"}

# Inject value into README.md
function readme() {
    local key=$1
    local value=$2
    
    if [[ "$OSTYPE" == "darwin"* ]]; then
        sed -i '' -e "s|<!--${key}-->|${value}|" $README_FILE
    else
        sed -i -e "s|<!--${key}-->|${value}|" $README_FILE
    fi
}

echo "Generating $README_FILE from $TEMPLATE_FILE..."

echo "- Removing old $README_FILE"
if [ -f "$README_FILE" ]; then 
    rm -f $README_FILE
fi
cp $TEMPLATE_FILE $README_FILE

echo "- Generate supported releases list..."
{
    BAKE_DEFINITION=`docker buildx bake readme-versions 2>/dev/null --print`
    echo -n "\n"
    (jq -ecr '.target[].args.TEXT' <<< "${BAKE_DEFINITION}") | xargs -I{} echo -n "\n- {}"
} > _releases.md
readme releases "$(cat _releases.md)" && rm _releases.md

echo "- Generate modules list..."
{
    BAKE_DEFINITION=`docker buildx bake readme-modules 2>/dev/null --print`
    echo -n "\n"
    (jq -ecr '.target[].args.TEXT' <<< "${BAKE_DEFINITION}") | xargs -I{} echo -n "\n- {}"
} > _modules.md
readme modules "$(cat _modules.md)" && rm _modules.md


echo "- Generate tags list..."
{
    BAKE_DEFINITION=`docker buildx bake readme-tags 2>/dev/null --print`
    echo -n "\n"
    (jq -ecr '.target[].args.TEXT' <<< "${BAKE_DEFINITION}") | grep stable | xargs -I{} echo -n "\n- {}"
    (jq -ecr '.target[].args.TEXT' <<< "${BAKE_DEFINITION}") | grep mainline | xargs -I{} echo -n "\n- {}"
    echo -n "\n"
    echo -n "\n**Versioning releases**:"
    echo -n "\n"
    (jq -ecr '.target[].args.TEXT' <<< "${BAKE_DEFINITION}") | grep -v stable | grep -v mainline | xargs -I{} echo -n "\n- {}"
} > _tags.md
readme tags "$(cat _tags.md)" && rm _tags.md
