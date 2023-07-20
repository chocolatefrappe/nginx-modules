# nginx-modules
A pre-built NGINX packages and modules for container.

[Source](https://github.com/chocolatefrappe/nginx-modules) | [Docker Hub](https://hub.docker.com/r/chocolatefrappe/nginx-modules)

> **Warning**:
> 
> This repository will operate autonomously via GitHub scheduled workflow.
>
> Due to limitations of GitHub Actions, in a public repository, scheduled workflows are automatically disabled when no repository activity has occurred in 60 days.
> 
> If you are expecting a new builds for new NGINX and it is not available, feel free to submit a ticket. 😉
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

[![Release channel](https://github.com/chocolatefrappe/nginx-modules/actions/workflows/release-channel.yml/badge.svg)](https://github.com/chocolatefrappe/nginx-modules/actions/workflows/release-channel.yml)
[![Release canonical](https://github.com/chocolatefrappe/nginx-modules/actions/workflows/release-canonical.yml/badge.svg)](https://github.com/chocolatefrappe/nginx-modules/actions/workflows/release-canonical.yml)
[![Release versioned](https://github.com/chocolatefrappe/nginx-modules/actions/workflows/release-versioned.yml/badge.svg)](https://github.com/chocolatefrappe/nginx-modules/actions/workflows/release-versioned.yml)

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

> **Note**:
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
- [`vts`](https://github.com/vozlt/nginx-module-vts): 3rd-party virtual host traffic status dynamic module
- [`xslt`](https://nginx.org/en/docs/http/ngx_http_xslt_module.html): xslt dynamic module
- [`zip`](https://github.com/evanmiller/mod_zip): 3rd-party zip dynamic module

## Tags

The following tags are available:

- `mainline-auth-spnego`, `mainline-auth-spnego-alpine`
- `mainline-brotli`, `mainline-brotli-alpine`
- `mainline-echo`, `mainline-echo-alpine`
- `mainline-encrypted-session`, `mainline-encrypted-session-alpine`
- `mainline-fips-check`, `mainline-fips-check-alpine`
- `mainline-geoip`, `mainline-geoip-alpine`
- `mainline-geoip2`, `mainline-geoip2-alpine`
- `mainline-headers-more`, `mainline-headers-more-alpine`
- `mainline-image-filter`, `mainline-image-filter-alpine`
- `mainline-lua`, `mainline-lua-alpine`
- `mainline-ndk`, `mainline-ndk-alpine`
- `mainline-njs`, `mainline-njs-alpine`
- `mainline-opentracing`, `mainline-opentracing-alpine`
- `mainline-passenger`, `mainline-passenger-alpine`
- `mainline-perl`, `mainline-perl-alpine`
- `mainline-rtmp`, `mainline-rtmp-alpine`
- `mainline-set-misc`, `mainline-set-misc-alpine`
- `mainline-subs-filter`, `mainline-subs-filter-alpine`
- `mainline-vts`, `mainline-vts-alpine`
- `mainline-xslt`, `mainline-xslt-alpine`
- `mainline-zip`, `mainline-zip-alpine`
- `stable-auth-spnego`, `stable-auth-spnego-alpine`
- `stable-brotli`, `stable-brotli-alpine`
- `stable-echo`, `stable-echo-alpine`
- `stable-encrypted-session`, `stable-encrypted-session-alpine`
- `stable-fips-check`, `stable-fips-check-alpine`
- `stable-geoip`, `stable-geoip-alpine`
- `stable-geoip2`, `stable-geoip2-alpine`
- `stable-headers-more`, `stable-headers-more-alpine`
- `stable-image-filter`, `stable-image-filter-alpine`
- `stable-lua`, `stable-lua-alpine`
- `stable-ndk`, `stable-ndk-alpine`
- `stable-njs`, `stable-njs-alpine`
- `stable-opentracing`, `stable-opentracing-alpine`
- `stable-passenger`, `stable-passenger-alpine`
- `stable-perl`, `stable-perl-alpine`
- `stable-rtmp`, `stable-rtmp-alpine`
- `stable-set-misc`, `stable-set-misc-alpine`
- `stable-subs-filter`, `stable-subs-filter-alpine`
- `stable-vts`, `stable-vts-alpine`
- `stable-xslt`, `stable-xslt-alpine`
- `stable-zip`, `stable-zip-alpine`

**Versioning releases**:

- `1.23.4-auth-spnego`, `1.23.4-auth-spnego-alpine`
- `1.23.4-brotli`, `1.23.4-brotli-alpine`
- `1.23.4-echo`, `1.23.4-echo-alpine`
- `1.23.4-encrypted-session`, `1.23.4-encrypted-session-alpine`
- `1.23.4-fips-check`, `1.23.4-fips-check-alpine`
- `1.23.4-geoip`, `1.23.4-geoip-alpine`
- `1.23.4-geoip2`, `1.23.4-geoip2-alpine`
- `1.23.4-headers-more`, `1.23.4-headers-more-alpine`
- `1.23.4-image-filter`, `1.23.4-image-filter-alpine`
- `1.23.4-lua`, `1.23.4-lua-alpine`
- `1.23.4-ndk`, `1.23.4-ndk-alpine`
- `1.23.4-njs`, `1.23.4-njs-alpine`
- `1.23.4-opentracing`, `1.23.4-opentracing-alpine`
- `1.23.4-passenger`, `1.23.4-passenger-alpine`
- `1.23.4-perl`, `1.23.4-perl-alpine`
- `1.23.4-rtmp`, `1.23.4-rtmp-alpine`
- `1.23.4-set-misc`, `1.23.4-set-misc-alpine`
- `1.23.4-subs-filter`, `1.23.4-subs-filter-alpine`
- `1.23.4-vts`, `1.23.4-vts-alpine`
- `1.23.4-xslt`, `1.23.4-xslt-alpine`
- `1.23.4-zip`, `1.23.4-zip-alpine`
- `1.24.0-auth-spnego`, `1.24.0-auth-spnego-alpine`
- `1.24.0-brotli`, `1.24.0-brotli-alpine`
- `1.24.0-echo`, `1.24.0-echo-alpine`
- `1.24.0-encrypted-session`, `1.24.0-encrypted-session-alpine`
- `1.24.0-fips-check`, `1.24.0-fips-check-alpine`
- `1.24.0-geoip`, `1.24.0-geoip-alpine`
- `1.24.0-geoip2`, `1.24.0-geoip2-alpine`
- `1.24.0-headers-more`, `1.24.0-headers-more-alpine`
- `1.24.0-image-filter`, `1.24.0-image-filter-alpine`
- `1.24.0-lua`, `1.24.0-lua-alpine`
- `1.24.0-ndk`, `1.24.0-ndk-alpine`
- `1.24.0-njs`, `1.24.0-njs-alpine`
- `1.24.0-opentracing`, `1.24.0-opentracing-alpine`
- `1.24.0-passenger`, `1.24.0-passenger-alpine`
- `1.24.0-perl`, `1.24.0-perl-alpine`
- `1.24.0-rtmp`, `1.24.0-rtmp-alpine`
- `1.24.0-set-misc`, `1.24.0-set-misc-alpine`
- `1.24.0-subs-filter`, `1.24.0-subs-filter-alpine`
- `1.24.0-vts`, `1.24.0-vts-alpine`
- `1.24.0-xslt`, `1.24.0-xslt-alpine`
- `1.24.0-zip`, `1.24.0-zip-alpine`
- `1.25.0-auth-spnego`, `1.25.0-auth-spnego-alpine`
- `1.25.0-brotli`, `1.25.0-brotli-alpine`
- `1.25.0-echo`, `1.25.0-echo-alpine`
- `1.25.0-encrypted-session`, `1.25.0-encrypted-session-alpine`
- `1.25.0-fips-check`, `1.25.0-fips-check-alpine`
- `1.25.0-geoip`, `1.25.0-geoip-alpine`
- `1.25.0-geoip2`, `1.25.0-geoip2-alpine`
- `1.25.0-headers-more`, `1.25.0-headers-more-alpine`
- `1.25.0-image-filter`, `1.25.0-image-filter-alpine`
- `1.25.0-lua`, `1.25.0-lua-alpine`
- `1.25.0-ndk`, `1.25.0-ndk-alpine`
- `1.25.0-njs`, `1.25.0-njs-alpine`
- `1.25.0-opentracing`, `1.25.0-opentracing-alpine`
- `1.25.0-passenger`, `1.25.0-passenger-alpine`
- `1.25.0-perl`, `1.25.0-perl-alpine`
- `1.25.0-rtmp`, `1.25.0-rtmp-alpine`
- `1.25.0-set-misc`, `1.25.0-set-misc-alpine`
- `1.25.0-subs-filter`, `1.25.0-subs-filter-alpine`
- `1.25.0-vts`, `1.25.0-vts-alpine`
- `1.25.0-xslt`, `1.25.0-xslt-alpine`
- `1.25.0-zip`, `1.25.0-zip-alpine`
- `1.25.1-auth-spnego`, `1.25.1-auth-spnego-alpine`
- `1.25.1-brotli`, `1.25.1-brotli-alpine`
- `1.25.1-echo`, `1.25.1-echo-alpine`
- `1.25.1-encrypted-session`, `1.25.1-encrypted-session-alpine`
- `1.25.1-fips-check`, `1.25.1-fips-check-alpine`
- `1.25.1-geoip`, `1.25.1-geoip-alpine`
- `1.25.1-geoip2`, `1.25.1-geoip2-alpine`
- `1.25.1-headers-more`, `1.25.1-headers-more-alpine`
- `1.25.1-image-filter`, `1.25.1-image-filter-alpine`
- `1.25.1-lua`, `1.25.1-lua-alpine`
- `1.25.1-ndk`, `1.25.1-ndk-alpine`
- `1.25.1-njs`, `1.25.1-njs-alpine`
- `1.25.1-opentracing`, `1.25.1-opentracing-alpine`
- `1.25.1-passenger`, `1.25.1-passenger-alpine`
- `1.25.1-perl`, `1.25.1-perl-alpine`
- `1.25.1-rtmp`, `1.25.1-rtmp-alpine`
- `1.25.1-set-misc`, `1.25.1-set-misc-alpine`
- `1.25.1-subs-filter`, `1.25.1-subs-filter-alpine`
- `1.25.1-vts`, `1.25.1-vts-alpine`
- `1.25.1-xslt`, `1.25.1-xslt-alpine`
- `1.25.1-zip`, `1.25.1-zip-alpine`

## Contributing

Contributions are welcome!

See [CONTRIBUTING.md](CONTRIBUTING.md) for more information.

## License
Licensed under the [MIT License](LICENSE).
