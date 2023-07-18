variable "NGINX_VERSION" {}
variable "ENABLED_MODULE" {}

group "default" {
    targets = ["alpine" ]
}

target "docker-metadata-action" {}

target "nginx-template" {
    inherits = ["docker-metadata-action"]
    args = {
        NGINX_VERSION = "${NGINX_VERSION}"
        ENABLED_MODULES = "${ENABLED_MODULE}"
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
