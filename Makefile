it:
	./configure

build: alpine debian

.PHONY: alpine
alpine:
	NGINX_VARIANT=alpine docker buildx bake -f nginx-modules.hcl nginx-modules-alpine

.PHONY: debian
debian:
	NGINX_VARIANT=debian docker buildx bake -f nginx-modules.hcl nginx-modules-debian
