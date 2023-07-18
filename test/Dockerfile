ARG NGINX_VERSION=stable
FROM nginx-module:latest AS mod-brotli

# - `/module-available.d`: Represent the available modules
# - `/packages`: The content of the modules as os specific package

FROM nginx:${NGINX_VERSION}-alpine

COPY --from=mod-brotli  / /tmp/nginx-modules
RUN set -ex \
    cd /tmp/nginx-modules && \
    for mod in `ls module-available.d/*`; do \
        _module=$(basename $mod); \
        echo "Installing $_module...";  \
        apk add --no-cache --allow-untrusted packages/nginx-module-$_module-${NGINX_VERSION}*.apk; \
    done \
    && rm -rf /tmp/nginx-modules
