it:
	./configure

build: alpine debian

.PHONY: alpine
alpine:
	docker buildx bake nginx-modules-alpine

.PHONY: debian
debian:
	docker buildx bake nginx-modules-debian
