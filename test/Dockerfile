ARG NGINX_VERSION=stable
FROM nginx-module:latest AS mod-brotli

FROM nginx:${NGINX_VERSION}-alpine

COPY --from=mod-brotli  / /tmp/nginx-modules
RUN for module in /tmp/nginx-modules/packages/nginx-module-*-${NGINX_VERSION}*.apk; do \
        apk add --no-cache --allow-untrusted $module; \
    done \
    && rm -rf /tmp/nginx-modules
