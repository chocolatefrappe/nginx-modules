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
    cd /tmp/nginx-modules && \
    for mod in `ls module-available.d/*`; do \
        _module=$(basename $mod); \
        echo "Installing $_module...";  \
        apk add --no-cache --allow-untrusted packages/nginx-module-$_module-${NGINX_VERSION}*.apk; \
    done \
    && rm -rf /tmp/nginx-modules

# Debian
RUN set -ex \
    cd /tmp/nginx-modules && \
    for mod in `ls module-available.d/*`; do \
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

**Versioning releases**:

- `1.25.0`
- `1.25.1`

## Modules

The following modules are available:

- [`auth-spnego`](https://github.com/stnoonan/spnego-http-auth-nginx-module): 3rd-party kerberos authentication dynamic module
- [`brotli`](https://github.com/google/ngx_brotli): 3rd-party brotli compression dynamic modules
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
- [`xslt`](https://nginx.org/en/docs/http/ngx_http_xslt_module.html): xslt dynamic module
- [`echo`](https://github.com/openresty/echo-nginx-module): Brings "echo", "sleep", "time", "exec" and more shell-style goodies to Nginx config file

## Tags

The following tags are available:

- `mainline-auth-spnego`, `mainline-auth-spnego-alpine`
- `mainline-brotli`, `mainline-brotli-alpine`
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
- `mainline-xslt`, `mainline-xslt-alpine`
- `mainline-echo`, `mainline-echo-alpine`
- `stable-auth-spnego`, `stable-auth-spnego-alpine`
- `stable-brotli`, `stable-brotli-alpine`
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
- `stable-xslt`, `stable-xslt-alpine`
- `stable-echo`, `stable-echo-alpine`

**Versioning releases**:

- `1.25.0-auth-spnego`, `1.25.0-auth-spnego-alpine`
- `1.25.0-brotli`, `1.25.0-brotli-alpine`
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
- `1.25.0-xslt`, `1.25.0-xslt-alpine`
- `1.25.0-echo`, `1.25.0-echo-alpine`
- `1.25.1-auth-spnego`, `1.25.1-auth-spnego-alpine`
- `1.25.1-brotli`, `1.25.1-brotli-alpine`
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
- `1.25.1-xslt`, `1.25.1-xslt-alpine`
- `1.25.1-echo`, `1.25.1-echo-alpine`

## License
Licensed under the [MIT License](LICENSE).
