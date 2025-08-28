target ?=
platform ?=

buildx_bake_args :=
# If platform is set, build only for that platform
ifneq ($(platform),all)
	buildx_bake_args += --load --set="*.platform=$(platform)"
endif

it: pkg-oss
	time docker buildx bake --print $(target)

ifeq ($(target),)
build: alpine debian
else
build:
	docker buildx bake --print mod-$(target)
	time docker buildx bake $(buildx_bake_args) mod-$(target)
endif

.PHONY: pkg-oss
pkg-oss:
	time docker buildx bake $(buildx_bake_args) pkg-oss

.PHONY: alpine
alpine: pkg-oss builder-alpine
	time docker buildx bake $(buildx_bake_args) mod-alpine
.PHONY: debian
debian: pkg-oss builder-debian
	time docker buildx bake $(buildx_bake_args) mod-debian

.PHONY: builder
builder: builder-alpine builder-debian
.PHONY: builder-alpine
builder-alpine:
	time docker buildx bake $(buildx_bake_args) builder-alpine
.PHONY: builder-debian
builder-debian:
	time docker buildx bake $(buildx_bake_args) builder-debian
