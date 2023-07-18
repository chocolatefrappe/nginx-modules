NGINX_VERSION := stable-alpine
ENABLED_MODULES := brotli

build:
	@echo "Buildind Alpine test image nginx-module:latest..."
	@docker build \
	-t nginx-module:latest \
	-f alpine/Dockerfile \
		--build-arg NGINX_VERSION=$(NGINX_VERSION) \
		--build-arg ENABLED_MODULES=$(ENABLED_MODULES) \
	.

.PHONY: test
test:
	@echo "Buildind test image nginx-module-test:latest..."
	@docker build \
	-t nginx-module-test:latest \
	-f test/Dockerfile \
		--build-arg NGINX_VERSION=$(NGINX_VERSION) \
	.
