# nginx-modules
A pre-built NGINX packages and modules for container

[Source](https://github.com/chocolatefrappe/nginx-modules) | [Docker Hub](https://hub.docker.com/r/chocolatefrappe/nginx-modules)

## Usage

The module is shipped using `scratch` as base image and contains the following structure:

- `/module-available.d`: Represent the available modules
- `/packages`: The content of the modules as os specific package

```Dockerfile
# Use `{version}` for debian variant and `{version}-alpine` for alpine variant
ARG NGINX_VERSION=stable-alpine 
# or
# NGINX_VERSION=1.25-alpine (Not available yet)
# NGINX_VERSION=1.25.0-alpine
FROM chocolatefrappe/nginx-modules:${NGINX_VERSION}-brotli
```

**Example**:

This is an example of how to use the pre-built NGINX packages and modules for container.

```Dockerfile
# Use `{version}` for debian variant and `{version}-alpine` for alpine variant
ARG NGINX_VERSION=stable-alpine

# Modules
FROM chocolatefrappe/nginx-modules:${NGINX_VERSION}-brotli  AS mod-brotli
FROM chocolatefrappe/nginx-modules:${NGINX_VERSION}-echo    AS mod-echo

# NGINX
FROM nginx:${NGINX_VERSION}

COPY --from=mod-brotli  / /tmp/nginx-modules
COPY --from=mod-echo    / /tmp/nginx-modules

# Alpine
RUN set -ex && \
    cd /tmp/nginx-modules && \
    for mod in module-available.d/*; do \
        _module=$(basename $mod); \
        echo "Installing $_module...";  \
        apk add --no-cache --allow-untrusted packages/nginx-module-$_module-${NGINX_VERSION}*.apk; \
    done \
    && rm -rf /tmp/nginx-modules

# Debian
RUN set -ex && \
    cd /tmp/nginx-modules && \
    for mod in module-available.d/*; do \
        _module=$(basename $mod); \
        echo "Installing $_module...";  \
        apk add --no-cache --allow-untrusted packages/nginx-module-$_module-${NGINX_VERSION}*.deb; \
    done \
    && rm -rf /tmp/nginx-modules
```

## Supported releases

The following releases are available:

- `mainline`, `mainline-alpine`
- `stable`, `stable-alpine`

**Versioning releases**:<!--releases-->

## Modules

The following modules are available:<!--modules-->

## Tags

The following tags are available:<!--tags-->

## License
Licensed under the [MIT License](LICENSE).
