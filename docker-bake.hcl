variable "NGINX_VERSION" {}

group "default" {
    targets = ["alpine" ]
}

target "docker-metadata-action" {}

target "nginx-template" {
    inherits = ["docker-metadata-action"]
    args = {
        NGINX_VERSION = "${NGINX_VERSION}"
        ENABLED_MODULES = "auth-spnego brotli encrypted-session fips-check geoip geoip2 headers-more image-filter lua modsecurity ndk njs opentracing passenger perl rtmp set-misc subs-filter xslt"
    }
    platforms = [
        "linux/amd64",
        "linux/arm64",
    ]
}

target "alpine" {
    inherits = ["nginx-template"]
    dockerfile = "alpine/Dockerfile"
}

target "debian" {
    inherits = ["nginx-template"]
    dockerfile = "debian/Dockerfile"
}
