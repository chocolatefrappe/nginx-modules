## About
A pre-built NGINX packages and modules for container.

[Source](https://github.com/chocolatefrappe/nginx-modules) | [Docker Hub](https://hub.docker.com/r/chocolatefrappe/nginx-modules)

> **Note**
> 
> This repository will operate autonomously via GitHub scheduled workflow.
>
> Due to limitations of GitHub Actions, in a public repository, scheduled workflows are automatically disabled when no repository activity has occurred in 60 days.
> 
> If you are expecting a new builds for new NGINX releases and it is not available, feel free to submit a ticket.
>
> See https://docs.github.com/en/actions/learn-github-actions/usage-limits-billing-and-administration#disabling-and-enabling-workflows

## Usage

The module is shipped using `scratch` as base image and contains the following structure:

- `/module-available.d`: Represent the available modules
- `/packages`: The content of the modules as os specific package

```Dockerfile
# Use `{version}` for debian variant and `{version}-alpine` for alpine variant
ARG NGINX_VERSION=stable-alpine 
# or
# NGINX_VERSION=1.25-alpine (Not available yet)
# NGINX_VERSION=1.25.0-alpine
FROM chocolatefrappe/nginx-modules:${NGINX_VERSION}-brotli
```

**Example**:

This is an example of how to use the pre-built NGINX packages and modules for container.

```Dockerfile
# Use `{version}` for debian variant and `{version}-alpine` for alpine variant
ARG NGINX_VERSION=stable-alpine

# Modules
FROM chocolatefrappe/nginx-modules:${NGINX_VERSION}-brotli  AS mod-brotli
FROM chocolatefrappe/nginx-modules:${NGINX_VERSION}-echo    AS mod-echo

# NGINX
FROM nginx:${NGINX_VERSION}

COPY --from=mod-brotli  / /tmp/nginx-modules
COPY --from=mod-echo    / /tmp/nginx-modules

# Alpine
RUN set -ex \
    && cd /tmp/nginx-modules \
    && for mod in module-available.d/*; do \
            module=$(basename $mod); \
            apk add --no-cache --allow-untrusted packages/nginx-module-${module}-${NGINX_VERSION}*.apk; \
        done \
    && rm -rf /tmp/nginx-modules

# Debian
RUN set -ex \
    && apt update \
    && cd /tmp/nginx-modules \
    && for mod in module-available.d/*; do \
            module=$(basename $mod); \
            apt install --no-install-suggests --no-install-recommends -y /tmp/nginx-modules/packages/nginx-module-${module}_${NGINX_VERSION}*.deb; \
        done \
    && rm -rf /tmp/nginx-modules \
    && rm -rf /var/lib/apt/lists/
```

## Supported releases

The supported releases are available in the following format:

[![Release](https://github.com/chocolatefrappe/nginx-modules/actions/workflows/release.yml/badge.svg)](https://github.com/chocolatefrappe/nginx-modules/actions/workflows/release.yml)

- `{version}`, `{version}-alpine`
- `{major}.{minor}`, `{major}.{minor}-alpine`

See [tags](#tags) section below for more information.

### Releases

The following releases are available:

**Channel releases**:
- `mainline`, `mainline-alpine`
- `stable`, `stable-alpine`

**Versioned releases**:<!--releases-->

## Modules

All modules are shipped using `scratch` as base image to reduce the size of the image and avoid unnecessary dependencies.

> **Note**
>
> This repository will automatically continue to build modules and releases if any changes made to the NGINX `oss-pkg` repository.
>
> See https://github.com/nginx/pkg-oss/

The following modules are available:<!--modules-->

## Tags

The following tags are available:<!--tags-->

## Contributing

Contributions are welcome!

See [CONTRIBUTING.md](CONTRIBUTING.md) for more information.

## License
Licensed under the [MIT License](LICENSE).
