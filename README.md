## About
A pre-built NGINX packages and modules for container.

[Source](https://github.com/chocolatefrappe/nginx-modules) | [Docker Hub](https://hub.docker.com/r/chocolatefrappe/nginx-modules)

> **Note**
> 
> This repository will operate autonomously via GitHub scheduled workflow.
>
> Due to limitations of GitHub Actions, in a public repository, scheduled workflows are automatically disabled when no repository activity has occurred in 60 days.
> 
> If you are expecting a new builds for new NGINX releases and it is not available, feel free to submit a ticket.
>
> See https://docs.github.com/en/actions/learn-github-actions/usage-limits-billing-and-administration#disabling-and-enabling-workflows

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
RUN set -ex \
    && cd /tmp/nginx-modules \
    && for mod in module-available.d/*; do \
            module=$(basename $mod); \
            apk add --no-cache --allow-untrusted packages/nginx-module-${module}-${NGINX_VERSION}*.apk; \
        done \
    && rm -rf /tmp/nginx-modules

# Debian
RUN set -ex \
    && apt update \
    && cd /tmp/nginx-modules \
    && for mod in module-available.d/*; do \
            module=$(basename $mod); \
            apt install --no-install-suggests --no-install-recommends -y /tmp/nginx-modules/packages/nginx-module-${module}_${NGINX_VERSION}*.deb; \
        done \
    && rm -rf /tmp/nginx-modules \
    && rm -rf /var/lib/apt/lists/
```

## Supported releases

The supported releases are available in the following format:

[![Release](https://github.com/chocolatefrappe/nginx-modules/actions/workflows/release.yml/badge.svg)](https://github.com/chocolatefrappe/nginx-modules/actions/workflows/release.yml)

- `{version}`, `{version}-alpine`
- `{major}.{minor}`, `{major}.{minor}-alpine`

See [tags](#tags) section below for more information.

### Releases

The following releases are available:

**Channel releases**:
- `mainline`, `mainline-alpine`
- `stable`, `stable-alpine`

**Versioned releases**:

- `1.23.4`
- `1.24.0`
- `1.25.0`
- `1.25.1`

## Modules

All modules are shipped using `scratch` as base image to reduce the size of the image and avoid unnecessary dependencies.

> **Note**
>
> This repository will automatically continue to build modules and releases if any changes made to the NGINX `oss-pkg` repository.
>
> See https://hg.nginx.org/pkg-oss/
> 
> Also see https://www.nginx.com/resources/wiki/modules/

The following modules are available:

- [`auth-spnego`](https://github.com/stnoonan/spnego-http-auth-nginx-module): 3rd-party kerberos authentication dynamic module
- [`brotli`](https://github.com/google/ngx_brotli): 3rd-party brotli compression dynamic modules
- [`echo`](https://github.com/openresty/echo-nginx-module): Brings 'echo', 'sleep', 'time', 'exec' and more shell-style goodies to Nginx config file
- [`encrypted-session`](https://github.com/openresty/encrypted-session-nginx-module): 3rd-party encrypted session dynamic module
- [`fips-check`](https://github.com/ogarrett/nginx-fips-check-module): 3rd-party FIPS status check dynamic module
- [`geoip`](https://nginx.org/en/docs/stream/ngx_stream_geoip_module.html): GeoIP dynamic modules
- [`geoip2`](https://github.com/leev/ngx_http_geoip2_module): 3rd-party GeoIP2 dynamic modules
- [`headers-more`](https://github.com/openresty/headers-more-nginx-module): 3rd-party headers-more dynamic module
- [`image-filter`](https://nginx.org/en/docs/http/ngx_http_image_filter_module.htm): image filter dynamic module
- [`lua`](https://github.com/openresty/lua-nginx-module): 3rd-party Lua dynamic modules
- [`ndk`](https://github.com/vision5/ngx_devel_kit): 3rd-party NDK dynamic module
- [`njs`](https://nginx.org/en/docs/njs/): njs dynamic modules
- [`opentracing`](https://github.com/opentracing-contrib/nginx-opentracing): 3rd-party OpenTracing dynamic module
- [`passenger`](https://www.phusionpassenger.com/library/config/nginx/intro.html): 3rd-party Passenger dynamic module
- [`perl`](http://nginx.org/en/docs/http/ngx_http_perl_module.html): Perl dynamic module
- [`rtmp`](https://github.com/arut/nginx-rtmp-module): 3rd-party RTMP dynamic module
- [`set-misc`](https://github.com/openresty/set-misc-nginx-module): 3rd-party set-misc dynamic module
- [`subs-filter`](https://www.nginx.com/resources/wiki/modules/substitutions/): 3rd-party substitution dynamic module
- [`otel`](https://github.com/nginxinc/nginx-otel): NGINX Native OpenTelemetry (OTel) Module
- [`vts`](https://github.com/vozlt/nginx-module-vts): 3rd-party virtual host traffic status dynamic module
- [`xslt`](https://nginx.org/en/docs/http/ngx_http_xslt_module.html): xslt dynamic module
- [`zip`](https://github.com/evanmiller/mod_zip): 3rd-party zip dynamic module

## Tags

The following tags are available:

- `mainline-auth-spnego`, `mainline-alpine-auth-spnego`
- `mainline-brotli`, `mainline-alpine-brotli`
- `mainline-echo`, `mainline-alpine-echo`
- `mainline-encrypted-session`, `mainline-alpine-encrypted-session`
- `mainline-fips-check`, `mainline-alpine-fips-check`
- `mainline-geoip`, `mainline-alpine-geoip`
- `mainline-geoip2`, `mainline-alpine-geoip2`
- `mainline-headers-more`, `mainline-alpine-headers-more`
- `mainline-image-filter`, `mainline-alpine-image-filter`
- `mainline-lua`, `mainline-alpine-lua`
- `mainline-ndk`, `mainline-alpine-ndk`
- `mainline-njs`, `mainline-alpine-njs`
- `mainline-opentracing`, `mainline-alpine-opentracing`
- `mainline-passenger`, `mainline-alpine-passenger`
- `mainline-perl`, `mainline-alpine-perl`
- `mainline-rtmp`, `mainline-alpine-rtmp`
- `mainline-set-misc`, `mainline-alpine-set-misc`
- `mainline-subs-filter`, `mainline-alpine-subs-filter`
- `mainline-otel`, `mainline-alpine-otel`
- `mainline-vts`, `mainline-alpine-vts`
- `mainline-xslt`, `mainline-alpine-xslt`
- `mainline-zip`, `mainline-alpine-zip`
- `stable-auth-spnego`, `stable-alpine-auth-spnego`
- `stable-brotli`, `stable-alpine-brotli`
- `stable-echo`, `stable-alpine-echo`
- `stable-encrypted-session`, `stable-alpine-encrypted-session`
- `stable-fips-check`, `stable-alpine-fips-check`
- `stable-geoip`, `stable-alpine-geoip`
- `stable-geoip2`, `stable-alpine-geoip2`
- `stable-headers-more`, `stable-alpine-headers-more`
- `stable-image-filter`, `stable-alpine-image-filter`
- `stable-lua`, `stable-alpine-lua`
- `stable-ndk`, `stable-alpine-ndk`
- `stable-njs`, `stable-alpine-njs`
- `stable-opentracing`, `stable-alpine-opentracing`
- `stable-passenger`, `stable-alpine-passenger`
- `stable-perl`, `stable-alpine-perl`
- `stable-rtmp`, `stable-alpine-rtmp`
- `stable-set-misc`, `stable-alpine-set-misc`
- `stable-subs-filter`, `stable-alpine-subs-filter`
- `stable-otel`, `stable-alpine-otel`
- `stable-vts`, `stable-alpine-vts`
- `stable-xslt`, `stable-alpine-xslt`
- `stable-zip`, `stable-alpine-zip`

**Versioning releases**:

- `1.23.4-auth-spnego`, `1.23.4-alpine-auth-spnego`
- `1.23.4-brotli`, `1.23.4-alpine-brotli`
- `1.23.4-echo`, `1.23.4-alpine-echo`
- `1.23.4-encrypted-session`, `1.23.4-alpine-encrypted-session`
- `1.23.4-fips-check`, `1.23.4-alpine-fips-check`
- `1.23.4-geoip`, `1.23.4-alpine-geoip`
- `1.23.4-geoip2`, `1.23.4-alpine-geoip2`
- `1.23.4-headers-more`, `1.23.4-alpine-headers-more`
- `1.23.4-image-filter`, `1.23.4-alpine-image-filter`
- `1.23.4-lua`, `1.23.4-alpine-lua`
- `1.23.4-ndk`, `1.23.4-alpine-ndk`
- `1.23.4-njs`, `1.23.4-alpine-njs`
- `1.23.4-opentracing`, `1.23.4-alpine-opentracing`
- `1.23.4-passenger`, `1.23.4-alpine-passenger`
- `1.23.4-perl`, `1.23.4-alpine-perl`
- `1.23.4-rtmp`, `1.23.4-alpine-rtmp`
- `1.23.4-set-misc`, `1.23.4-alpine-set-misc`
- `1.23.4-subs-filter`, `1.23.4-alpine-subs-filter`
- `1.23.4-otel`, `1.23.4-alpine-otel`
- `1.23.4-vts`, `1.23.4-alpine-vts`
- `1.23.4-xslt`, `1.23.4-alpine-xslt`
- `1.23.4-zip`, `1.23.4-alpine-zip`
- `1.24.0-auth-spnego`, `1.24.0-alpine-auth-spnego`
- `1.24.0-brotli`, `1.24.0-alpine-brotli`
- `1.24.0-echo`, `1.24.0-alpine-echo`
- `1.24.0-encrypted-session`, `1.24.0-alpine-encrypted-session`
- `1.24.0-fips-check`, `1.24.0-alpine-fips-check`
- `1.24.0-geoip`, `1.24.0-alpine-geoip`
- `1.24.0-geoip2`, `1.24.0-alpine-geoip2`
- `1.24.0-headers-more`, `1.24.0-alpine-headers-more`
- `1.24.0-image-filter`, `1.24.0-alpine-image-filter`
- `1.24.0-lua`, `1.24.0-alpine-lua`
- `1.24.0-ndk`, `1.24.0-alpine-ndk`
- `1.24.0-njs`, `1.24.0-alpine-njs`
- `1.24.0-opentracing`, `1.24.0-alpine-opentracing`
- `1.24.0-passenger`, `1.24.0-alpine-passenger`
- `1.24.0-perl`, `1.24.0-alpine-perl`
- `1.24.0-rtmp`, `1.24.0-alpine-rtmp`
- `1.24.0-set-misc`, `1.24.0-alpine-set-misc`
- `1.24.0-subs-filter`, `1.24.0-alpine-subs-filter`
- `1.24.0-otel`, `1.24.0-alpine-otel`
- `1.24.0-vts`, `1.24.0-alpine-vts`
- `1.24.0-xslt`, `1.24.0-alpine-xslt`
- `1.24.0-zip`, `1.24.0-alpine-zip`
- `1.25.0-auth-spnego`, `1.25.0-alpine-auth-spnego`
- `1.25.0-brotli`, `1.25.0-alpine-brotli`
- `1.25.0-echo`, `1.25.0-alpine-echo`
- `1.25.0-encrypted-session`, `1.25.0-alpine-encrypted-session`
- `1.25.0-fips-check`, `1.25.0-alpine-fips-check`
- `1.25.0-geoip`, `1.25.0-alpine-geoip`
- `1.25.0-geoip2`, `1.25.0-alpine-geoip2`
- `1.25.0-headers-more`, `1.25.0-alpine-headers-more`
- `1.25.0-image-filter`, `1.25.0-alpine-image-filter`
- `1.25.0-lua`, `1.25.0-alpine-lua`
- `1.25.0-ndk`, `1.25.0-alpine-ndk`
- `1.25.0-njs`, `1.25.0-alpine-njs`
- `1.25.0-opentracing`, `1.25.0-alpine-opentracing`
- `1.25.0-passenger`, `1.25.0-alpine-passenger`
- `1.25.0-perl`, `1.25.0-alpine-perl`
- `1.25.0-rtmp`, `1.25.0-alpine-rtmp`
- `1.25.0-set-misc`, `1.25.0-alpine-set-misc`
- `1.25.0-subs-filter`, `1.25.0-alpine-subs-filter`
- `1.25.0-otel`, `1.25.0-alpine-otel`
- `1.25.0-vts`, `1.25.0-alpine-vts`
- `1.25.0-xslt`, `1.25.0-alpine-xslt`
- `1.25.0-zip`, `1.25.0-alpine-zip`
- `1.25.1-auth-spnego`, `1.25.1-alpine-auth-spnego`
- `1.25.1-brotli`, `1.25.1-alpine-brotli`
- `1.25.1-echo`, `1.25.1-alpine-echo`
- `1.25.1-encrypted-session`, `1.25.1-alpine-encrypted-session`
- `1.25.1-fips-check`, `1.25.1-alpine-fips-check`
- `1.25.1-geoip`, `1.25.1-alpine-geoip`
- `1.25.1-geoip2`, `1.25.1-alpine-geoip2`
- `1.25.1-headers-more`, `1.25.1-alpine-headers-more`
- `1.25.1-image-filter`, `1.25.1-alpine-image-filter`
- `1.25.1-lua`, `1.25.1-alpine-lua`
- `1.25.1-ndk`, `1.25.1-alpine-ndk`
- `1.25.1-njs`, `1.25.1-alpine-njs`
- `1.25.1-opentracing`, `1.25.1-alpine-opentracing`
- `1.25.1-passenger`, `1.25.1-alpine-passenger`
- `1.25.1-perl`, `1.25.1-alpine-perl`
- `1.25.1-rtmp`, `1.25.1-alpine-rtmp`
- `1.25.1-set-misc`, `1.25.1-alpine-set-misc`
- `1.25.1-subs-filter`, `1.25.1-alpine-subs-filter`
- `1.25.1-otel`, `1.25.1-alpine-otel`
- `1.25.1-vts`, `1.25.1-alpine-vts`
- `1.25.1-xslt`, `1.25.1-alpine-xslt`
- `1.25.1-zip`, `1.25.1-alpine-zip`

## Contributing

Contributions are welcome!

See [CONTRIBUTING.md](CONTRIBUTING.md) for more information.

## License
Licensed under the [MIT License](LICENSE).
