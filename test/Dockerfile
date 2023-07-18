ARG NGINX_VERSION=stable-alpine
FROM chocolatefrappe/nginx-modules:${NGINX_VERSION}-brotli  AS mod-brotli
FROM chocolatefrappe/nginx-modules:${NGINX_VERSION}-echo    AS mod-echo

# - `/module-available.d`: Represent the available modules
# - `/packages`: The content of the modules as os specific package

FROM nginx:${NGINX_VERSION}

ARG ID=1
COPY --from=mod-brotli  / /tmp/nginx-modules
COPY --from=mod-echo    / /tmp/nginx-modules
RUN set -ex && \
    cd /tmp/nginx-modules && \
    for mod in module-available.d/*; do \
        _module=$(basename $mod); \
        echo "Installing $_module...";  \
        apk add --no-cache --allow-untrusted packages/nginx-module-$_module-${NGINX_VERSION}*.apk; \
    done \
    && rm -rf /tmp/nginx-modules
