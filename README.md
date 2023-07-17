# nginx-packages
A pre-built NGINX packages and modules for container

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

FROM nginx:${NGINX_VERSION}-alpine
COPY --from=mod-brotli  /nginx-modules /nginx-modules

RUN for module in /nginx-modules/nginx-module-*-${NGINX_VERSION}*.apk; do \
        apk add --no-cache --allow-untrusted $module; \
    done
```

## Modules

The following modules are available:

- `auth-spnego`
- `brotli`
- `encrypted-session`
- `fips-check`
- `geoip`
- `geoip2`
- `headers-more`
- `image-filter`
- `lua`
- `ndk`
- `njs`
- `opentracing`
- `passenger`
- `perl`
- `rtmp`
- `set-misc`
- `subs-filter`
- `xslt`
- `echo`
