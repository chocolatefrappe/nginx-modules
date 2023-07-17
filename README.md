# nginx-packages
A pre-built NGINX packages and modules for container

## Usage

This is an example of how to use the pre-built NGINX packages and modules for container.

```Dockerfile
ARG NGINX_VERSION=stable
FROM chocolatefrappe/nginx-modules:${NGINX_VERSION}-alpine-brotli AS mod-brotli

FROM nginx:${NGINX_VERSION}-alpine
COPY --from=mod-brotli  /nginx-modules /nginx-modules

RUN for module in /nginx-modules/nginx-module-*-${NGINX_VERSION}*.apk; do \
        apk add --no-cache --allow-untrusted $module; \
    done
```
