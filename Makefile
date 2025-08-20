target := default

.EXPORT_ALL_VARIABLES:
NGINX_VERSIONS ?= $(shell jq -ecr 'join(",")' nginx-versions.json)
NGINX_MODULES ?= $(shell jq -r '. | keys | join(",")' nginx-modules.json)

it:
	docker buildx bake pkg-oss
	docker buildx bake --set="*.platform=" --print $(target)

build: alpine debian
.PHONY: alpine
alpine:
	docker buildx bake --set="*.platform=" --load alpine
.PHONY: debian
debian:
	docker buildx bake --set="*.platform=" --load debian
