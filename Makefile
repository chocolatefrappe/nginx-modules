NGINX_VERSION := stable
ENABLED_MODULES := brotli

test:
	@echo "Buildind Alpine test image echo-nginx-module:latest..."
	@docker build \
	-t echo-nginx-module:latest \
	-f alpine/Dockerfile \
		--build-arg NGINX_VERSION=$(NGINX_VERSION) \
		--build-arg ENABLED_MODULES=$(ENABLED_MODULES) \
	.
