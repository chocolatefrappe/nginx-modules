# check=skip=InvalidDefaultArgInFrom

ARG NGINX_VERSION
FROM nginx:${NGINX_VERSION}-alpine AS nginx-base

# Module Builder
FROM nginx-base AS builder

ARG ENABLED_MODULES

RUN set -ex \
    && if [ "$ENABLED_MODULES" = "" ]; then \
        echo "No additional modules enabled, exiting"; \
        exit 1; \
    fi

COPY ./modules /modules/

RUN apk update \
    && apk add linux-headers openssl-dev pcre2-dev zlib-dev openssl abuild \
               musl-dev libxslt libxml2-utils make mercurial gcc unzip git \
               xz g++ coreutils curl \
    # allow abuild as a root user \
    && printf "#!/bin/sh\\nSETFATTR=true /usr/bin/abuild -F \"\$@\"\\n" > /usr/local/bin/abuild \
    && chmod +x /usr/local/bin/abuild \
    && git clone -b ${NGINX_VERSION}-${PKG_RELEASE} https://github.com/nginx/pkg-oss/ \
    && cd pkg-oss \
    && mkdir /tmp/packages \
    && for module in $ENABLED_MODULES; do \
        echo "Building $module for nginx-$NGINX_VERSION"; \
        if [ -d /modules/$module ]; then \
            echo "Building $module from user-supplied sources"; \
            # check if module sources file is there and not empty
            if [ ! -s /modules/$module/source ]; then \
                echo "No source file for $module in modules/$module/source, exiting"; \
                exit 1; \
            fi; \
            # some modules require build dependencies
            if [ -f /modules/$module/build-deps ]; then \
                echo "Installing $module build dependencies"; \
                apk update && apk add $(cat /modules/$module/build-deps | xargs); \
            fi; \
            # if a module has a build dependency that is not in a distro, provide a
            # shell script to fetch/build/install those
            # note that shared libraries produced as a result of this script will
            # not be copied from the builder image to the main one so build static
            if [ -x /modules/$module/prebuild ]; then \
                echo "Running prebuild script for $module"; \
                /modules/$module/prebuild; \
            fi; \
            /pkg-oss/build_module.sh -v $NGINX_VERSION -f -y -o /tmp/packages -n $module $(cat /modules/$module/source); \
            BUILT_MODULES="$BUILT_MODULES $(echo $module | tr '[A-Z]' '[a-z]' | tr -d '[/_\-\.\t ]')"; \
        elif make -C /pkg-oss/alpine list | grep -E "^$module\s+\d+" > /dev/null; then \
            echo "Building $module from pkg-oss sources"; \
            cd /pkg-oss/alpine; \
            make abuild-module-$module BASE_VERSION=$NGINX_VERSION NGINX_VERSION=$NGINX_VERSION; \
            apk add $(. ./abuild-module-$module/APKBUILD; echo $makedepends;); \
            make module-$module BASE_VERSION=$NGINX_VERSION NGINX_VERSION=$NGINX_VERSION; \
            find ~/packages -type f -name "*.apk" -exec mv -v {} /tmp/packages/ \;; \
            BUILT_MODULES="$BUILT_MODULES $module"; \
        else \
            echo "Don't know how to build $module module, exiting"; \
            exit 1; \
        fi; \
    done \
    && echo "BUILT_MODULES=\"$BUILT_MODULES\"" > /tmp/packages/modules.env

# Create module-available.d directory and touch files for built modules
RUN . /tmp/packages/modules.env \
    && for module in $BUILT_MODULES; do \
        mkdir -p /tmp/module-available.d; \
        touch /tmp/module-available.d/$module; \
    done \
    && rm /tmp/packages/modules.env

FROM scratch AS nginx-modules-packages
COPY --from=builder /tmp/module-available.d /module-available.d
COPY --from=builder /tmp/packages /packages

# NGINX module package
FROM scratch AS nginx-module-auth-spnego
COPY --from=builder /tmp/module-available.d/auth-spnego /module-available.d/
COPY --from=builder /tmp/packages/nginx-module-auth-spnego* /packages/

FROM scratch AS nginx-module-brotli
COPY --from=builder /tmp/module-available.d/brotli /module-available.d/
COPY --from=builder /tmp/packages/nginx-module-brotli* /packages/

FROM scratch AS nginx-module-echo
COPY --from=builder /tmp/module-available.d/echo /module-available.d/
COPY --from=builder /tmp/packages/nginx-module-echo* /packages/

FROM scratch AS nginx-module-encrypted-session
COPY --from=builder /tmp/module-available.d/encrypted-session /module-available.d/
COPY --from=builder /tmp/packages/nginx-module-encrypted-session* /packages/

FROM scratch AS nginx-module-fips-check
COPY --from=builder /tmp/module-available.d/fips-check /module-available.d/
COPY --from=builder /tmp/packages/nginx-module-fips-check* /packages/

FROM scratch AS nginx-module-geoip
COPY --from=builder /tmp/module-available.d/geoip /module-available.d/
COPY --from=builder /tmp/packages/nginx-module-geoip* /packages/

FROM scratch AS nginx-module-geoip2
COPY --from=builder /tmp/module-available.d/geoip2 /module-available.d/
COPY --from=builder /tmp/packages/nginx-module-geoip2* /packages/

FROM scratch AS nginx-module-headers-more
COPY --from=builder /tmp/module-available.d/headers-more /module-available.d/
COPY --from=builder /tmp/packages/nginx-module-headers-more* /packages/

FROM scratch AS nginx-module-image-filter
COPY --from=builder /tmp/module-available.d/image-filter /module-available.d/
COPY --from=builder /tmp/packages/nginx-module-image-filter* /packages/

FROM scratch AS nginx-module-lua
COPY --from=builder /tmp/module-available.d/lua /module-available.d/
COPY --from=builder /tmp/packages/nginx-module-lua* /packages/

FROM scratch AS nginx-module-ndk
COPY --from=builder /tmp/module-available.d/ndk /module-available.d/
COPY --from=builder /tmp/packages/nginx-module-ndk* /packages/

FROM scratch AS nginx-module-njs
COPY --from=builder /tmp/module-available.d/njs /module-available.d/
COPY --from=builder /tmp/packages/nginx-module-njs* /packages/

FROM scratch AS nginx-module-opentracing
COPY --from=builder /tmp/module-available.d/opentracing /module-available.d/
COPY --from=builder /tmp/packages/nginx-module-opentracing* /packages/

FROM scratch AS nginx-module-otel
COPY --from=builder /tmp/module-available.d/otel /module-available.d/
COPY --from=builder /tmp/packages/nginx-module-otel* /packages/

FROM scratch AS nginx-module-passenger
COPY --from=builder /tmp/module-available.d/passenger /module-available.d/
COPY --from=builder /tmp/packages/nginx-module-passenger* /packages/

FROM scratch AS nginx-module-perl
COPY --from=builder /tmp/module-available.d/perl /module-available.d/
COPY --from=builder /tmp/packages/nginx-module-perl* /packages/

FROM scratch AS nginx-module-rtmp
COPY --from=builder /tmp/module-available.d/rtmp /module-available.d/
COPY --from=builder /tmp/packages/nginx-module-rtmp* /packages/

FROM scratch AS nginx-module-set-misc
COPY --from=builder /tmp/module-available.d/set-misc /module-available.d/
COPY --from=builder /tmp/packages/nginx-module-set-misc* /packages/

FROM scratch AS nginx-module-subs-filter
COPY --from=builder /tmp/module-available.d/subs-filter /module-available.d/
COPY --from=builder /tmp/packages/nginx-module-subs-filter* /packages/

FROM scratch AS nginx-module-vts
COPY --from=builder /tmp/module-available.d/vts /module-available.d/
COPY --from=builder /tmp/packages/nginx-module-vts* /packages/

FROM scratch AS nginx-module-xslt
COPY --from=builder /tmp/module-available.d/xslt /module-available.d/
COPY --from=builder /tmp/packages/nginx-module-xslt* /packages/

FROM scratch AS nginx-module-zip
COPY --from=builder /tmp/module-available.d/zip /module-available.d/
COPY --from=builder /tmp/packages/nginx-module-zip* /packages/

