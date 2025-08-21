# check=skip=InvalidDefaultArgInFrom

ARG NGINX_VERSION=stable

FROM nginx:${NGINX_VERSION}-alpine AS base-builder

RUN --mount=type=cache,id=alpine,target=/tmp/locked,sharing=locked \
    apk update \
    && apk add linux-headers openssl-dev pcre2-dev zlib-dev openssl abuild \
               musl-dev libxslt libxml2-utils make mercurial gcc unzip git \
               xz g++ coreutils curl rustup \
    # allow abuild as a root user \
    && printf "#!/bin/sh\\nSETFATTR=true /usr/bin/abuild -F \"\$@\"\\n" > /usr/local/bin/abuild \
    && chmod +x /usr/local/bin/abuild

ENV RUSTUP_HOME=/usr/local/rustup \
    CARGO_HOME=/usr/local/cargo \
    PATH=/usr/local/cargo/bin:$PATH \
    RUST_VERSION=1.86.0
# COPY --from=rustup-init /rustup-init /usr/bin/rustup-init
RUN --mount=type=cache,id=alpine,target=/tmp/locked,sharing=locked \
    set -ex; \
    /usr/bin/rustup-init -y --no-modify-path --profile minimal --default-toolchain ${RUST_VERSION}; \
    chmod -R a+w $RUSTUP_HOME $CARGO_HOME; \
    rustup --version; \
    cargo --version; \
    rustc --version;

FROM ghcr.io/chocolatefrappe/nginx-modules:builder-${NGINX_VERSION}-alpine AS builder

ADD https://github.com/nginx/pkg-oss.git#${NGINX_VERSION}-${PKG_RELEASE} /pkg-oss
ADD pkg-oss /pkg-oss
WORKDIR /pkg-oss
COPY ./modules /modules/

ARG ENABLED_MODULES

RUN set -ex \
    && if [ "$ENABLED_MODULES" = "" ]; then \
        echo "No additional modules enabled, exiting"; \
        exit 1; \
    fi

WORKDIR /pkg-oss
RUN --mount=type=cache,id=alpine,target=/tmp/locked,sharing=locked \
    set -eo pipefail; \
    mkdir /tmp/packages \
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

# NGINX module package
FROM scratch AS packages
COPY --from=builder /tmp/module-available.d /module-available.d
COPY --from=builder /tmp/packages /packages

FROM scratch AS final
COPY --from=packages / /
