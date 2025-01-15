DOCKER_BUILDER_NAME=nginx-modules-builder
DOCKER_BUILDER_PLATFROM := $(shell uname -m)

DOCKER_BUILDX_BAKE_ARGS := --builder ${DOCKER_BUILDER_NAME}

it:
	./configure
	docker buildx bake nginx-modules-{alpine,debian} --print

build: alpine debian
.PHONY: alpine
alpine:
	docker buildx bake $(DOCKER_BUILDX_BAKE_ARGS) \
		--push \
		nginx-modules-alpine
.PHONY: debian
debian:
	docker buildx bake $(DOCKER_BUILDX_BAKE_ARGS) \
		--push \
		nginx-modules-debian

dev: alpine-dev debian-dev
.PHONY: alpine-dev
alpine-dev:
	docker buildx bake $(DOCKER_BUILDX_BAKE_ARGS) \
		--set="*.platform=linux/${DOCKER_BUILDER_PLATFROM}" \
		--load \
		nginx-modules-alpine
.PHONY: debian-dev
debian-dev:
	docker buildx bake $(DOCKER_BUILDX_BAKE_ARGS) \
		--set="*.platform=linux/${DOCKER_BUILDER_PLATFROM}" \
		--load \
		nginx-modules-debian

builder:
	docker buildx rm ${DOCKER_BUILDER_NAME} || true
	docker run --rm \
		--privileged tonistiigi/binfmt:latest \
		--install all
	docker buildx create \
		--name ${DOCKER_BUILDER_NAME} \
		--driver docker-container \
		--buildkitd-flags '--allow-insecure-entitlement security.insecure --allow-insecure-entitlement network.host'
	docker buildx inspect --builder ${DOCKER_BUILDER_NAME} --bootstrap

clean:
	docker buildx rm ${DOCKER_BUILDER_NAME}
