DOCKER_BUILDER_NAME=nginx-modules-builder
DOCKER_BUILDER_PLATFROM := $(shell uname -m)
DOCKER_BUILDX_BAKE_ARGS := --builder ${DOCKER_BUILDER_NAME}

.EXPORT_ALL_VARIABLES:
NGINX_MODULES := brotli

it:
	docker buildx bake --print

build:
	docker buildx bake

dev:
	docker buildx bake $(DOCKER_BUILDX_BAKE_ARGS) \
		--set="*.platform=linux/${DOCKER_BUILDER_PLATFROM}" \
		--load

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
