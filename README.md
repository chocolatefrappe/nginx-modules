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

<details>
<summary>Alpine example</summary>

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
```

</details>

<details>
<summary>Debian example</summary>

```Dockerfile
# Use `{version}` for debian variant and `{version}-alpine` for alpine variant
ARG NGINX_VERSION=stable

# Modules
FROM chocolatefrappe/nginx-modules:${NGINX_VERSION}-brotli  AS mod-brotli
FROM chocolatefrappe/nginx-modules:${NGINX_VERSION}-echo    AS mod-echo

# NGINX
FROM nginx:${NGINX_VERSION}

COPY --from=mod-brotli  / /tmp/nginx-modules
COPY --from=mod-echo    / /tmp/nginx-modules

RUN set -ex \
    && chmod 1777 /tmp \
    && apt update \
    && cd /tmp/nginx-modules \
    && for mod in module-available.d/*; do \
            module=$(basename $mod); \
            apt install --no-install-suggests --no-install-recommends -y /tmp/nginx-modules/packages/nginx-module-${module}_${NGINX_VERSION}*.deb; \
        done \
    && rm -rf /tmp/nginx-modules \
    && rm -rf /var/lib/apt/lists/
```

</details>

## Supported releases

The supported releases are available in the following format:

[![Release](https://github.com/chocolatefrappe/nginx-modules/actions/workflows/release.yml/badge.svg)](https://github.com/chocolatefrappe/nginx-modules/actions/workflows/release.yml)
[![README.md](https://github.com/chocolatefrappe/nginx-modules/actions/workflows/use-readme.yml/badge.svg)](https://github.com/chocolatefrappe/nginx-modules/actions/workflows/use-readme.yml)

- `{version}`, `{version}-alpine`
- `{major}.{minor}`, `{major}.{minor}-alpine`

See [tags](#tags) section below for more information.

### Releases

The following releases are available:

**Channel releases**:
- `mainline`, `mainline-alpine`
- `stable`, `stable-alpine`

**Versioned releases**:

- `1.28`
- `1.28.0`
- `1.29`
- `1.29.0`
- `1.29.1`
- `mainline`
- `stable`

## Modules

All modules are shipped using `scratch` as base image to reduce the size of the image and avoid unnecessary dependencies.

> **Note**
>
> This repository will automatically continue to build modules and releases if any changes made to the NGINX `oss-pkg` repository.
>
> See https://github.com/nginx/pkg-oss/

The following modules are available:

- [`acme`](https://github.com/nginx/nginx-acme): An NGINX module with the implementation of the automatic certificate management (ACMEv2) protocol
- [`auth-spnego`](https://github.com/stnoonan/spnego-http-auth-nginx-module): 3rd-party kerberos authentication dynamic module
- [`brotli`](https://github.com/google/ngx_brotli): 3rd-party brotli compression dynamic modules
- [`echo`](https://github.com/openresty/echo-nginx-module): Brings echo, sleep, time, exec and more shell-style goodies to Nginx config file
- [`encrypted-session`](https://github.com/openresty/encrypted-session-nginx-module): 3rd-party encrypted session dynamic module
- [`fips-check`](https://github.com/ogarrett/nginx-fips-check-module): 3rd-party FIPS status check dynamic module
- [`geoip`](https://nginx.org/en/docs/stream/ngx_stream_geoip_module.html): GeoIP dynamic modules
- [`geoip2`](https://github.com/leev/ngx_http_geoip2_module): 3rd-party GeoIP2 dynamic modules
- [`headers-more`](https://github.com/openresty/headers-more-nginx-module): 3rd-party headers-more dynamic module
- [`image-filter`](https://nginx.org/en/docs/http/ngx_http_image_filter_module.htm): image filter dynamic module
- [`lua`](https://github.com/openresty/lua-nginx-module): 3rd-party Lua dynamic modules
- [`ndk`](https://github.com/vision5/ngx_devel_kit): 3rd-party NDK dynamic module
- [`njs`](https://nginx.org/en/docs/njs/): njs dynamic modules
- [`otel`](https://github.com/nginxinc/nginx-otel): NGINX Native OpenTelemetry (OTel) Module
- [`passenger`](https://www.phusionpassenger.com/library/config/nginx/intro.html): 3rd-party Passenger dynamic module
- [`perl`](http://nginx.org/en/docs/http/ngx_http_perl_module.html): Perl dynamic module
- [`rtmp`](https://github.com/arut/nginx-rtmp-module): 3rd-party RTMP dynamic module
- [`set-misc`](https://github.com/openresty/set-misc-nginx-module): 3rd-party set-misc dynamic module
- [`subs-filter`](https://www.nginx.com/resources/wiki/modules/substitutions/): 3rd-party substitution dynamic module
- [`vts`](https://github.com/vozlt/nginx-mod-vts): 3rd-party virtual host traffic status dynamic module
- [`xslt`](https://nginx.org/en/docs/http/ngx_http_xslt_module.html): xslt dynamic module
- [`zip`](https://github.com/evanmiller/mod_zip): 3rd-party zip dynamic module

## Tags

The following tags are available:

- `stable-acme`, `stable-alpine-acme`
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
- `stable-otel`, `stable-alpine-otel`
- `stable-passenger`, `stable-alpine-passenger`
- `stable-perl`, `stable-alpine-perl`
- `stable-rtmp`, `stable-alpine-rtmp`
- `stable-set-misc`, `stable-alpine-set-misc`
- `stable-subs-filter`, `stable-alpine-subs-filter`
- `stable-vts`, `stable-alpine-vts`
- `stable-xslt`, `stable-alpine-xslt`
- `stable-zip`, `stable-alpine-zip`
- `mainline-acme`, `mainline-alpine-acme`
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
- `mainline-otel`, `mainline-alpine-otel`
- `mainline-passenger`, `mainline-alpine-passenger`
- `mainline-perl`, `mainline-alpine-perl`
- `mainline-rtmp`, `mainline-alpine-rtmp`
- `mainline-set-misc`, `mainline-alpine-set-misc`
- `mainline-subs-filter`, `mainline-alpine-subs-filter`
- `mainline-vts`, `mainline-alpine-vts`
- `mainline-xslt`, `mainline-alpine-xslt`
- `mainline-zip`, `mainline-alpine-zip`

**Versioning releases**:

- `1.28-acme`, `1.28-alpine-acme`
- `1.28-auth-spnego`, `1.28-alpine-auth-spnego`
- `1.28-brotli`, `1.28-alpine-brotli`
- `1.28-echo`, `1.28-alpine-echo`
- `1.28-encrypted-session`, `1.28-alpine-encrypted-session`
- `1.28-fips-check`, `1.28-alpine-fips-check`
- `1.28-geoip`, `1.28-alpine-geoip`
- `1.28-geoip2`, `1.28-alpine-geoip2`
- `1.28-headers-more`, `1.28-alpine-headers-more`
- `1.28-image-filter`, `1.28-alpine-image-filter`
- `1.28-lua`, `1.28-alpine-lua`
- `1.28-ndk`, `1.28-alpine-ndk`
- `1.28-njs`, `1.28-alpine-njs`
- `1.28-otel`, `1.28-alpine-otel`
- `1.28-passenger`, `1.28-alpine-passenger`
- `1.28-perl`, `1.28-alpine-perl`
- `1.28-rtmp`, `1.28-alpine-rtmp`
- `1.28-set-misc`, `1.28-alpine-set-misc`
- `1.28-subs-filter`, `1.28-alpine-subs-filter`
- `1.28-vts`, `1.28-alpine-vts`
- `1.28-xslt`, `1.28-alpine-xslt`
- `1.28-zip`, `1.28-alpine-zip`
- `1.28.0-acme`, `1.28.0-alpine-acme`
- `1.28.0-auth-spnego`, `1.28.0-alpine-auth-spnego`
- `1.28.0-brotli`, `1.28.0-alpine-brotli`
- `1.28.0-echo`, `1.28.0-alpine-echo`
- `1.28.0-encrypted-session`, `1.28.0-alpine-encrypted-session`
- `1.28.0-fips-check`, `1.28.0-alpine-fips-check`
- `1.28.0-geoip`, `1.28.0-alpine-geoip`
- `1.28.0-geoip2`, `1.28.0-alpine-geoip2`
- `1.28.0-headers-more`, `1.28.0-alpine-headers-more`
- `1.28.0-image-filter`, `1.28.0-alpine-image-filter`
- `1.28.0-lua`, `1.28.0-alpine-lua`
- `1.28.0-ndk`, `1.28.0-alpine-ndk`
- `1.28.0-njs`, `1.28.0-alpine-njs`
- `1.28.0-otel`, `1.28.0-alpine-otel`
- `1.28.0-passenger`, `1.28.0-alpine-passenger`
- `1.28.0-perl`, `1.28.0-alpine-perl`
- `1.28.0-rtmp`, `1.28.0-alpine-rtmp`
- `1.28.0-set-misc`, `1.28.0-alpine-set-misc`
- `1.28.0-subs-filter`, `1.28.0-alpine-subs-filter`
- `1.28.0-vts`, `1.28.0-alpine-vts`
- `1.28.0-xslt`, `1.28.0-alpine-xslt`
- `1.28.0-zip`, `1.28.0-alpine-zip`
- `1.29-acme`, `1.29-alpine-acme`
- `1.29-auth-spnego`, `1.29-alpine-auth-spnego`
- `1.29-brotli`, `1.29-alpine-brotli`
- `1.29-echo`, `1.29-alpine-echo`
- `1.29-encrypted-session`, `1.29-alpine-encrypted-session`
- `1.29-fips-check`, `1.29-alpine-fips-check`
- `1.29-geoip`, `1.29-alpine-geoip`
- `1.29-geoip2`, `1.29-alpine-geoip2`
- `1.29-headers-more`, `1.29-alpine-headers-more`
- `1.29-image-filter`, `1.29-alpine-image-filter`
- `1.29-lua`, `1.29-alpine-lua`
- `1.29-ndk`, `1.29-alpine-ndk`
- `1.29-njs`, `1.29-alpine-njs`
- `1.29-otel`, `1.29-alpine-otel`
- `1.29-passenger`, `1.29-alpine-passenger`
- `1.29-perl`, `1.29-alpine-perl`
- `1.29-rtmp`, `1.29-alpine-rtmp`
- `1.29-set-misc`, `1.29-alpine-set-misc`
- `1.29-subs-filter`, `1.29-alpine-subs-filter`
- `1.29-vts`, `1.29-alpine-vts`
- `1.29-xslt`, `1.29-alpine-xslt`
- `1.29-zip`, `1.29-alpine-zip`
- `1.29.0-acme`, `1.29.0-alpine-acme`
- `1.29.0-auth-spnego`, `1.29.0-alpine-auth-spnego`
- `1.29.0-brotli`, `1.29.0-alpine-brotli`
- `1.29.0-echo`, `1.29.0-alpine-echo`
- `1.29.0-encrypted-session`, `1.29.0-alpine-encrypted-session`
- `1.29.0-fips-check`, `1.29.0-alpine-fips-check`
- `1.29.0-geoip`, `1.29.0-alpine-geoip`
- `1.29.0-geoip2`, `1.29.0-alpine-geoip2`
- `1.29.0-headers-more`, `1.29.0-alpine-headers-more`
- `1.29.0-image-filter`, `1.29.0-alpine-image-filter`
- `1.29.0-lua`, `1.29.0-alpine-lua`
- `1.29.0-ndk`, `1.29.0-alpine-ndk`
- `1.29.0-njs`, `1.29.0-alpine-njs`
- `1.29.0-otel`, `1.29.0-alpine-otel`
- `1.29.0-passenger`, `1.29.0-alpine-passenger`
- `1.29.0-perl`, `1.29.0-alpine-perl`
- `1.29.0-rtmp`, `1.29.0-alpine-rtmp`
- `1.29.0-set-misc`, `1.29.0-alpine-set-misc`
- `1.29.0-subs-filter`, `1.29.0-alpine-subs-filter`
- `1.29.0-vts`, `1.29.0-alpine-vts`
- `1.29.0-xslt`, `1.29.0-alpine-xslt`
- `1.29.0-zip`, `1.29.0-alpine-zip`
- `1.29.1-acme`, `1.29.1-alpine-acme`
- `1.29.1-auth-spnego`, `1.29.1-alpine-auth-spnego`
- `1.29.1-brotli`, `1.29.1-alpine-brotli`
- `1.29.1-echo`, `1.29.1-alpine-echo`
- `1.29.1-encrypted-session`, `1.29.1-alpine-encrypted-session`
- `1.29.1-fips-check`, `1.29.1-alpine-fips-check`
- `1.29.1-geoip`, `1.29.1-alpine-geoip`
- `1.29.1-geoip2`, `1.29.1-alpine-geoip2`
- `1.29.1-headers-more`, `1.29.1-alpine-headers-more`
- `1.29.1-image-filter`, `1.29.1-alpine-image-filter`
- `1.29.1-lua`, `1.29.1-alpine-lua`
- `1.29.1-ndk`, `1.29.1-alpine-ndk`
- `1.29.1-njs`, `1.29.1-alpine-njs`
- `1.29.1-otel`, `1.29.1-alpine-otel`
- `1.29.1-passenger`, `1.29.1-alpine-passenger`
- `1.29.1-perl`, `1.29.1-alpine-perl`
- `1.29.1-rtmp`, `1.29.1-alpine-rtmp`
- `1.29.1-set-misc`, `1.29.1-alpine-set-misc`
- `1.29.1-subs-filter`, `1.29.1-alpine-subs-filter`
- `1.29.1-vts`, `1.29.1-alpine-vts`
- `1.29.1-xslt`, `1.29.1-alpine-xslt`
- `1.29.1-zip`, `1.29.1-alpine-zip`

## Contributing

Contributions are welcome!

See [CONTRIBUTING.md](CONTRIBUTING.md) for more information.

## License
Licensed under the [MIT License](LICENSE).
