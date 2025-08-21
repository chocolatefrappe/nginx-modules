target ?=

.EXPORT_ALL_VARIABLES:
NGINX_VERSIONS ?= $(shell jq -ecr 'join(",")' nginx-versions.json)
NGINX_MODULES ?= $(shell jq -r '. | keys | join(",")' nginx-modules.json)

it:
	docker buildx bake pkg-oss
	docker buildx bake --set="*.platform=" --print $(target)

build: nginx-modules-builder alpine debian
.PHONY: alpine
alpine: pkg-oss
	docker buildx bake --set="*.platform=" --load --no-cache alpine
.PHONY: debian
debian: pkg-oss
	docker buildx bake --set="*.platform=" --load --no-cache debian
.PHONY: builder
nginx-modules-builder:
	docker buildx bake  --set="*.platform=" --load --no-cache nginx-modules-builder
.PHONY: pkg-oss
pkg-oss:
	docker buildx bake pkg-oss
