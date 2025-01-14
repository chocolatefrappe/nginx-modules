DOCKER_BUILDER_NAME=nginx-modules-builder

it:
	./configure

build: alpine debian

.PHONY: alpine
alpine:
	docker buildx bake \
		--builder ${DOCKER_BUILDER_NAME} \
		nginx-modules-alpine

.PHONY: debian
debian:
	docker buildx bake \
		--builder ${DOCKER_BUILDER_NAME} \
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
