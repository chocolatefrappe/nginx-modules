# Generated by render.sh
variable "TAG" { default = "chocolatefrappe/nginx-modules" }
variable "NGINX_VERSION" { default = "stable" }

target "nginx-module-builder" {
    args = {
        NGINX_VERSION = "${NGINX_VERSION}"
        ENABLED_MODULES = "auth-spnego brotli echo encrypted-session fips-check geoip geoip2 headers-more image-filter lua ndk njs opentracing otel passenger perl rtmp set-misc subs-filter vts xslt zip"
    }
}

group "nginx-modules-alpine" {
    targets = [
        "nginx-module-auth-spnego-alpine",
        "nginx-module-brotli-alpine",
        "nginx-module-echo-alpine",
        "nginx-module-encrypted-session-alpine",
        "nginx-module-fips-check-alpine",
        "nginx-module-geoip-alpine",
        "nginx-module-geoip2-alpine",
        "nginx-module-headers-more-alpine",
        "nginx-module-image-filter-alpine",
        "nginx-module-lua-alpine",
        "nginx-module-ndk-alpine",
        "nginx-module-njs-alpine",
        "nginx-module-opentracing-alpine",
        "nginx-module-otel-alpine",
        "nginx-module-passenger-alpine",
        "nginx-module-perl-alpine",
        "nginx-module-rtmp-alpine",
        "nginx-module-set-misc-alpine",
        "nginx-module-subs-filter-alpine",
        "nginx-module-vts-alpine",
        "nginx-module-xslt-alpine",
        "nginx-module-zip-alpine",
    ]
}

group "nginx-modules-debian" {
    targets = [
        "nginx-module-auth-spnego-debian",
        "nginx-module-brotli-debian",
        "nginx-module-echo-debian",
        "nginx-module-encrypted-session-debian",
        "nginx-module-fips-check-debian",
        "nginx-module-geoip-debian",
        "nginx-module-geoip2-debian",
        "nginx-module-headers-more-debian",
        "nginx-module-image-filter-debian",
        "nginx-module-lua-debian",
        "nginx-module-ndk-debian",
        "nginx-module-njs-debian",
        "nginx-module-opentracing-debian",
        "nginx-module-otel-debian",
        "nginx-module-passenger-debian",
        "nginx-module-perl-debian",
        "nginx-module-rtmp-debian",
        "nginx-module-set-misc-debian",
        "nginx-module-subs-filter-debian",
        "nginx-module-vts-debian",
        "nginx-module-xslt-debian",
        "nginx-module-zip-debian",
    ]
}

# auth-spnego
target "nginx-module-auth-spnego-alpine" {
    dockerfile = "alpine/Dockerfile"
    inherits = ["nginx-module-builder"]
    target = "nginx-module-auth-spnego"
    tags = [
        "${TAG}:${NGINX_VERSION}-alpine-auth-spnego"
    ]
}
target "nginx-module-auth-spnego-debian" {
    dockerfile = "debian/Dockerfile"
    inherits = ["nginx-module-builder"]
    target = "nginx-module-auth-spnego"
    tags = [
        "${TAG}:${NGINX_VERSION}-auth-spnego"
    ]
}

# brotli
target "nginx-module-brotli-alpine" {
    dockerfile = "alpine/Dockerfile"
    inherits = ["nginx-module-builder"]
    target = "nginx-module-brotli"
    tags = [
        "${TAG}:${NGINX_VERSION}-alpine-brotli"
    ]
}
target "nginx-module-brotli-debian" {
    dockerfile = "debian/Dockerfile"
    inherits = ["nginx-module-builder"]
    target = "nginx-module-brotli"
    tags = [
        "${TAG}:${NGINX_VERSION}-brotli"
    ]
}

# echo
target "nginx-module-echo-alpine" {
    dockerfile = "alpine/Dockerfile"
    inherits = ["nginx-module-builder"]
    target = "nginx-module-echo"
    tags = [
        "${TAG}:${NGINX_VERSION}-alpine-echo"
    ]
}
target "nginx-module-echo-debian" {
    dockerfile = "debian/Dockerfile"
    inherits = ["nginx-module-builder"]
    target = "nginx-module-echo"
    tags = [
        "${TAG}:${NGINX_VERSION}-echo"
    ]
}

# encrypted-session
target "nginx-module-encrypted-session-alpine" {
    dockerfile = "alpine/Dockerfile"
    inherits = ["nginx-module-builder"]
    target = "nginx-module-encrypted-session"
    tags = [
        "${TAG}:${NGINX_VERSION}-alpine-encrypted-session"
    ]
}
target "nginx-module-encrypted-session-debian" {
    dockerfile = "debian/Dockerfile"
    inherits = ["nginx-module-builder"]
    target = "nginx-module-encrypted-session"
    tags = [
        "${TAG}:${NGINX_VERSION}-encrypted-session"
    ]
}

# fips-check
target "nginx-module-fips-check-alpine" {
    dockerfile = "alpine/Dockerfile"
    inherits = ["nginx-module-builder"]
    target = "nginx-module-fips-check"
    tags = [
        "${TAG}:${NGINX_VERSION}-alpine-fips-check"
    ]
}
target "nginx-module-fips-check-debian" {
    dockerfile = "debian/Dockerfile"
    inherits = ["nginx-module-builder"]
    target = "nginx-module-fips-check"
    tags = [
        "${TAG}:${NGINX_VERSION}-fips-check"
    ]
}

# geoip
target "nginx-module-geoip-alpine" {
    dockerfile = "alpine/Dockerfile"
    inherits = ["nginx-module-builder"]
    target = "nginx-module-geoip"
    tags = [
        "${TAG}:${NGINX_VERSION}-alpine-geoip"
    ]
}
target "nginx-module-geoip-debian" {
    dockerfile = "debian/Dockerfile"
    inherits = ["nginx-module-builder"]
    target = "nginx-module-geoip"
    tags = [
        "${TAG}:${NGINX_VERSION}-geoip"
    ]
}

# geoip2
target "nginx-module-geoip2-alpine" {
    dockerfile = "alpine/Dockerfile"
    inherits = ["nginx-module-builder"]
    target = "nginx-module-geoip2"
    tags = [
        "${TAG}:${NGINX_VERSION}-alpine-geoip2"
    ]
}
target "nginx-module-geoip2-debian" {
    dockerfile = "debian/Dockerfile"
    inherits = ["nginx-module-builder"]
    target = "nginx-module-geoip2"
    tags = [
        "${TAG}:${NGINX_VERSION}-geoip2"
    ]
}

# headers-more
target "nginx-module-headers-more-alpine" {
    dockerfile = "alpine/Dockerfile"
    inherits = ["nginx-module-builder"]
    target = "nginx-module-headers-more"
    tags = [
        "${TAG}:${NGINX_VERSION}-alpine-headers-more"
    ]
}
target "nginx-module-headers-more-debian" {
    dockerfile = "debian/Dockerfile"
    inherits = ["nginx-module-builder"]
    target = "nginx-module-headers-more"
    tags = [
        "${TAG}:${NGINX_VERSION}-headers-more"
    ]
}

# image-filter
target "nginx-module-image-filter-alpine" {
    dockerfile = "alpine/Dockerfile"
    inherits = ["nginx-module-builder"]
    target = "nginx-module-image-filter"
    tags = [
        "${TAG}:${NGINX_VERSION}-alpine-image-filter"
    ]
}
target "nginx-module-image-filter-debian" {
    dockerfile = "debian/Dockerfile"
    inherits = ["nginx-module-builder"]
    target = "nginx-module-image-filter"
    tags = [
        "${TAG}:${NGINX_VERSION}-image-filter"
    ]
}

# lua
target "nginx-module-lua-alpine" {
    dockerfile = "alpine/Dockerfile"
    inherits = ["nginx-module-builder"]
    target = "nginx-module-lua"
    tags = [
        "${TAG}:${NGINX_VERSION}-alpine-lua"
    ]
}
target "nginx-module-lua-debian" {
    dockerfile = "debian/Dockerfile"
    inherits = ["nginx-module-builder"]
    target = "nginx-module-lua"
    tags = [
        "${TAG}:${NGINX_VERSION}-lua"
    ]
}

# ndk
target "nginx-module-ndk-alpine" {
    dockerfile = "alpine/Dockerfile"
    inherits = ["nginx-module-builder"]
    target = "nginx-module-ndk"
    tags = [
        "${TAG}:${NGINX_VERSION}-alpine-ndk"
    ]
}
target "nginx-module-ndk-debian" {
    dockerfile = "debian/Dockerfile"
    inherits = ["nginx-module-builder"]
    target = "nginx-module-ndk"
    tags = [
        "${TAG}:${NGINX_VERSION}-ndk"
    ]
}

# njs
target "nginx-module-njs-alpine" {
    dockerfile = "alpine/Dockerfile"
    inherits = ["nginx-module-builder"]
    target = "nginx-module-njs"
    tags = [
        "${TAG}:${NGINX_VERSION}-alpine-njs"
    ]
}
target "nginx-module-njs-debian" {
    dockerfile = "debian/Dockerfile"
    inherits = ["nginx-module-builder"]
    target = "nginx-module-njs"
    tags = [
        "${TAG}:${NGINX_VERSION}-njs"
    ]
}

# opentracing
target "nginx-module-opentracing-alpine" {
    dockerfile = "alpine/Dockerfile"
    inherits = ["nginx-module-builder"]
    target = "nginx-module-opentracing"
    tags = [
        "${TAG}:${NGINX_VERSION}-alpine-opentracing"
    ]
}
target "nginx-module-opentracing-debian" {
    dockerfile = "debian/Dockerfile"
    inherits = ["nginx-module-builder"]
    target = "nginx-module-opentracing"
    tags = [
        "${TAG}:${NGINX_VERSION}-opentracing"
    ]
}

# otel
target "nginx-module-otel-alpine" {
    dockerfile = "alpine/Dockerfile"
    inherits = ["nginx-module-builder"]
    target = "nginx-module-otel"
    tags = [
        "${TAG}:${NGINX_VERSION}-alpine-otel"
    ]
}
target "nginx-module-otel-debian" {
    dockerfile = "debian/Dockerfile"
    inherits = ["nginx-module-builder"]
    target = "nginx-module-otel"
    tags = [
        "${TAG}:${NGINX_VERSION}-otel"
    ]
}

# passenger
target "nginx-module-passenger-alpine" {
    dockerfile = "alpine/Dockerfile"
    inherits = ["nginx-module-builder"]
    target = "nginx-module-passenger"
    tags = [
        "${TAG}:${NGINX_VERSION}-alpine-passenger"
    ]
}
target "nginx-module-passenger-debian" {
    dockerfile = "debian/Dockerfile"
    inherits = ["nginx-module-builder"]
    target = "nginx-module-passenger"
    tags = [
        "${TAG}:${NGINX_VERSION}-passenger"
    ]
}

# perl
target "nginx-module-perl-alpine" {
    dockerfile = "alpine/Dockerfile"
    inherits = ["nginx-module-builder"]
    target = "nginx-module-perl"
    tags = [
        "${TAG}:${NGINX_VERSION}-alpine-perl"
    ]
}
target "nginx-module-perl-debian" {
    dockerfile = "debian/Dockerfile"
    inherits = ["nginx-module-builder"]
    target = "nginx-module-perl"
    tags = [
        "${TAG}:${NGINX_VERSION}-perl"
    ]
}

# rtmp
target "nginx-module-rtmp-alpine" {
    dockerfile = "alpine/Dockerfile"
    inherits = ["nginx-module-builder"]
    target = "nginx-module-rtmp"
    tags = [
        "${TAG}:${NGINX_VERSION}-alpine-rtmp"
    ]
}
target "nginx-module-rtmp-debian" {
    dockerfile = "debian/Dockerfile"
    inherits = ["nginx-module-builder"]
    target = "nginx-module-rtmp"
    tags = [
        "${TAG}:${NGINX_VERSION}-rtmp"
    ]
}

# set-misc
target "nginx-module-set-misc-alpine" {
    dockerfile = "alpine/Dockerfile"
    inherits = ["nginx-module-builder"]
    target = "nginx-module-set-misc"
    tags = [
        "${TAG}:${NGINX_VERSION}-alpine-set-misc"
    ]
}
target "nginx-module-set-misc-debian" {
    dockerfile = "debian/Dockerfile"
    inherits = ["nginx-module-builder"]
    target = "nginx-module-set-misc"
    tags = [
        "${TAG}:${NGINX_VERSION}-set-misc"
    ]
}

# subs-filter
target "nginx-module-subs-filter-alpine" {
    dockerfile = "alpine/Dockerfile"
    inherits = ["nginx-module-builder"]
    target = "nginx-module-subs-filter"
    tags = [
        "${TAG}:${NGINX_VERSION}-alpine-subs-filter"
    ]
}
target "nginx-module-subs-filter-debian" {
    dockerfile = "debian/Dockerfile"
    inherits = ["nginx-module-builder"]
    target = "nginx-module-subs-filter"
    tags = [
        "${TAG}:${NGINX_VERSION}-subs-filter"
    ]
}

# vts
target "nginx-module-vts-alpine" {
    dockerfile = "alpine/Dockerfile"
    inherits = ["nginx-module-builder"]
    target = "nginx-module-vts"
    tags = [
        "${TAG}:${NGINX_VERSION}-alpine-vts"
    ]
}
target "nginx-module-vts-debian" {
    dockerfile = "debian/Dockerfile"
    inherits = ["nginx-module-builder"]
    target = "nginx-module-vts"
    tags = [
        "${TAG}:${NGINX_VERSION}-vts"
    ]
}

# xslt
target "nginx-module-xslt-alpine" {
    dockerfile = "alpine/Dockerfile"
    inherits = ["nginx-module-builder"]
    target = "nginx-module-xslt"
    tags = [
        "${TAG}:${NGINX_VERSION}-alpine-xslt"
    ]
}
target "nginx-module-xslt-debian" {
    dockerfile = "debian/Dockerfile"
    inherits = ["nginx-module-builder"]
    target = "nginx-module-xslt"
    tags = [
        "${TAG}:${NGINX_VERSION}-xslt"
    ]
}

# zip
target "nginx-module-zip-alpine" {
    dockerfile = "alpine/Dockerfile"
    inherits = ["nginx-module-builder"]
    target = "nginx-module-zip"
    tags = [
        "${TAG}:${NGINX_VERSION}-alpine-zip"
    ]
}
target "nginx-module-zip-debian" {
    dockerfile = "debian/Dockerfile"
    inherits = ["nginx-module-builder"]
    target = "nginx-module-zip"
    tags = [
        "${TAG}:${NGINX_VERSION}-zip"
    ]
}

