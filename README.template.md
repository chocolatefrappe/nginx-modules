# nginx-modules
A pre-built NGINX packages and modules for container

[Source](https://github.com/chocolatefrappe/nginx-modules) | [Docker Hub](https://hub.docker.com/r/chocolatefrappe/nginx-modules)

## Usage

```Dockerfile
ARG NGINX_VERSION=stable-alpine 
# or
# NGINX_VERSION=1.25-alpine (Not available yet)
# NGINX_VERSION=1.25.0-alpine
FROM chocolatefrappe/nginx-modules:${NGINX_VERSION}-brotli
```

**Example**:

This is an example of how to use the pre-built NGINX packages and modules for container.

```Dockerfile
ARG NGINX_VERSION=stable
FROM chocolatefrappe/nginx-modules:${NGINX_VERSION}-alpine-brotli AS mod-brotli
FROM chocolatefrappe/nginx-modules:${NGINX_VERSION}-alpine-echo AS mod-echo

FROM nginx:${NGINX_VERSION}-alpine
COPY --from=mod-brotli  / /tmp/nginx-modules
COPY --from=mod-echo    / /tmp/nginx-modules

RUN for module in /tmp/nginx-modules/packages/nginx-module-*-${NGINX_VERSION}*.apk; do \
        apk add --no-cache --allow-untrusted $module; \
    done \
    && rm -rf /tmp/nginx-modules
```

## Modules

The following modules are available:<!--modules-->

## License
Licensed under the [MIT License](LICENSE).
