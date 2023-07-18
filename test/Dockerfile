ARG NGINX_VERSION=stable-alpine
FROM chocolatefrappe/nginx-modules:${NGINX_VERSION}-brotli  AS mod-brotli
FROM chocolatefrappe/nginx-modules:${NGINX_VERSION}-echo    AS mod-echo

# - `/module-available.d`: Represent the available modules
# - `/packages`: The content of the modules as os specific package

FROM nginx:${NGINX_VERSION}

COPY --from=mod-brotli  / /tmp/nginx-modules
# COPY --from=mod-echo    / /tmp/nginx-modules

# Alpine
RUN set -ex \
    && cd /tmp/nginx-modules \
    && for mod in module-available.d/*; do \
            module=$(basename $mod); \
            echo "Installing $module...";  \
            apk add --no-cache --allow-untrusted packages/nginx-module-$module-${NGINX_VERSION}*.apk; \
        done \
    && rm -rf /tmp/nginx-modules

# Debian
# RUN set -ex \
#     && apt update \
#     && cd /tmp/nginx-modules \
#     && for mod in module-available.d/*; do \
#             module=$(basename $mod); \
#             echo "Installing $module...";  \
#             apt install --no-install-suggests --no-install-recommends -y /tmp/nginx-modules/packages/nginx-module-${module}_${NGINX_VERSION}*.deb; \
#         done \
#     && rm -rf /tmp/nginx-modules \
#     && rm -rf /var/lib/apt/lists/
