.EXPORT_ALL_VARIABLES:
NGINX_VERSIONS ?= stable
NGINX_MODULES ?= $(shell jq -r '. | keys | join(",")' nginx-modules.json)

it:
	docker buildx bake pkg-oss
	docker buildx bake --set="*.platform=" --print

build: alpine debian
.PHONY: alpine
alpine:
	docker buildx bake --set="*.platform=" --load alpine
.PHONY: debian
debian:
	docker buildx bake --set="*.platform=" --load debian
