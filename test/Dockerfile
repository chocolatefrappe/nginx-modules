ARG NGINX_VERSION=stable
FROM chocolatefrappe/nginx-modules:${NGINX_VERSION}-alpine-brotli AS mod-brotli
FROM chocolatefrappe/nginx-modules:${NGINX_VERSION}-alpine-rtmp AS mod-rtmp
FROM chocolatefrappe/nginx-modules:${NGINX_VERSION}-alpine-echo AS mod-echo

FROM nginx:${NGINX_VERSION}-alpine
COPY --from=mod-brotli  /nginx-modules /nginx-modules
COPY --from=mod-rtmp    /nginx-modules /nginx-modules
COPY --from=mod-echo    /nginx-modules /nginx-modules

RUN for module in /nginx-modules/nginx-module-*-${NGINX_VERSION}*.apk; do \
        apk add --no-cache --allow-untrusted $module; \
    done
