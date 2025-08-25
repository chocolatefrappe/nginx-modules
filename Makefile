target ?=

.EXPORT_ALL_VARIABLES:
NGINX_VERSIONS ?= $(shell jq -ecr 'join(",")' nginx-versions.json)
NGINX_MODULES ?= $(shell jq -r '. | keys | join(",")' nginx-modules.json)

it: pkg-oss
	docker buildx bake --set="*.platform=" --print $(target)

build: alpine debian

.PHONY: pkg-oss
pkg-oss:
	docker buildx bake pkg-oss

.PHONY: alpine
alpine: pkg-oss builder-alpine
	docker buildx bake --set="*.platform=" --load alpine
.PHONY: debian
debian: pkg-oss builder-debian
	docker buildx bake --set="*.platform=" --load debian

.PHONY: builder
builder: builder-alpine builder-debian
.PHONY: builder-alpine
builder-alpine:
	docker buildx bake  --set="*.platform=" --load nginx-modules-alpine-builder
.PHONY: builder-debian
builder-debian:
	docker buildx bake  --set="*.platform=" --load nginx-modules-debian-builder
