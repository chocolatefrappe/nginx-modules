target ?=
platform ?=

it: pkg-oss
	time docker buildx bake --set="*.platform=$(platform)" --print $(target)

build: alpine debian

.PHONY: pkg-oss
pkg-oss:
	time docker buildx bake pkg-oss

.PHONY: alpine
alpine: pkg-oss builder-alpine
	time docker buildx bake mod-alpine
.PHONY: debian
debian: pkg-oss builder-debian
	time docker buildx bake mod-debian

.PHONY: builder
builder: builder-alpine builder-debian
.PHONY: builder-alpine
builder-alpine:
	time docker buildx bake builder-alpine
.PHONY: builder-debian
builder-debian:
	time docker buildx bake builder-debian
